package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun TraverseScreen(onBack: () -> Unit) {
    var d1 by remember { mutableStateOf("") }
    var b1 by remember { mutableStateOf("") }
    var d2 by remember { mutableStateOf("") }
    var b2 by remember { mutableStateOf("") }
    var d3 by remember { mutableStateOf("") }
    var b3 by remember { mutableStateOf("") }
    var d4 by remember { mutableStateOf("") }
    var b4 by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }
    var errorMsg by remember { mutableStateOf<String?>(null) }

    ScreenFrame(
        title = "Traverse & Coordinate",
        subtitle = "Latitude, departure, misclose, accuracy, and adjustment using the reference formulas",
        onBack = onBack
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .verticalScroll(rememberScrollState())
        ) {
            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "Reference formulas",
                        color = Color(0xFF64B5F6),
                        fontSize = 14.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(6.dp))
                    Text(
                        text = "Latitude = Distance × cos(θ)\nDeparture = Distance × sin(θ)\nLinear misclose = √(ΣLatitude² + ΣDeparture²)\nBowditch correction uses distance proportion\nTransit correction uses latitude/departure proportion",
                        color = Color(0xFFC4CEDA),
                        fontSize = 12.sp,
                        lineHeight = 16.sp
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            TraverseLineCard(index = 1, distance = d1, bearing = b1, onDistanceChange = { d1 = it; errorMsg = null; result = "" }, onBearingChange = { b1 = it; errorMsg = null; result = "" })
            Spacer(Modifier.height(10.dp))
            TraverseLineCard(index = 2, distance = d2, bearing = b2, onDistanceChange = { d2 = it; errorMsg = null; result = "" }, onBearingChange = { b2 = it; errorMsg = null; result = "" })
            Spacer(Modifier.height(10.dp))
            TraverseLineCard(index = 3, distance = d3, bearing = b3, onDistanceChange = { d3 = it; errorMsg = null; result = "" }, onBearingChange = { b3 = it; errorMsg = null; result = "" })
            Spacer(Modifier.height(10.dp))
            TraverseLineCard(index = 4, distance = d4, bearing = b4, onDistanceChange = { d4 = it; errorMsg = null; result = "" }, onBearingChange = { b4 = it; errorMsg = null; result = "" })

            Spacer(Modifier.height(12.dp))

            Button(
                onClick = {
                    val inputs = listOf(
                        d1 to b1,
                        d2 to b2,
                        d3 to b3,
                        d4 to b4
                    ).mapIndexed { index, pair ->
                        val distance = pair.first.toDoubleOrNull()
                        val bearing = pair.second.toDoubleOrNull()
                        if (distance == null || bearing == null) {
                            errorMsg = "Please fill distance and bearing for line ${index + 1}."
                            return@Button
                        }
                        TraverseLineInput(distance = distance, bearingDeg = bearing)
                    }

                    errorMsg = null
                    val analysis = analyzeTraverse(inputs)
                    val ratioText = analysis.accuracyRatio?.let { "1:${formatValue(it, 3)}" } ?: "—"
                    val builder = StringBuilder()
                    builder.appendLine("Traverse analysis")
                    builder.appendLine("Total distance: ${formatValue(analysis.totalDistance)} m")
                    builder.appendLine("Σ Latitude: ${formatValue(analysis.sumLatitude)} m")
                    builder.appendLine("Σ Departure: ${formatValue(analysis.sumDeparture)} m")
                    builder.appendLine("Linear misclose: ${formatValue(analysis.linearMisclose)} m")
                    builder.appendLine("Traverse accuracy: $ratioText")
                    builder.appendLine()
                    builder.appendLine("Per line results")
                    analysis.lines.forEachIndexed { index, line ->
                        builder.appendLine(
                            "Line ${index + 1}: Lat ${formatValue(line.latitude)} m, Dep ${formatValue(line.departure)} m"
                        )
                    }
                    builder.appendLine()
                    builder.appendLine("Bowditch correction")
                    analysis.bowditchCorrections.forEachIndexed { index, correction ->
                        builder.appendLine(
                            "Line ${index + 1}: Lat ${formatValue(correction.latitude)} m, Dep ${formatValue(correction.departure)} m"
                        )
                    }
                    builder.appendLine()
                    builder.appendLine("Transit correction")
                    analysis.transitCorrections.forEachIndexed { index, correction ->
                        builder.appendLine(
                            "Line ${index + 1}: Lat ${formatValue(correction.latitude)} m, Dep ${formatValue(correction.departure)} m"
                        )
                    }
                    result = builder.toString().trimEnd()
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Compute Traverse")
            }

            if (errorMsg != null) {
                Spacer(Modifier.height(8.dp))
                Text(
                    text = errorMsg!!,
                    color = Color(0xFFEF5350),
                    fontSize = 13.sp
                )
            }

            Spacer(Modifier.height(16.dp))

            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "Result",
                        color = Color(0xFF64B5F6),
                        fontSize = 14.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(8.dp))
                    Text(
                        text = result.ifBlank { "Enter four traverse lines to calculate latitudes, departures, misclose, and adjustments." },
                        color = if (result.isBlank()) Color.Gray else Color.White,
                        fontSize = 13.sp,
                        lineHeight = 18.sp
                    )
                }
            }
        }
    }
}

@Composable
private fun TraverseLineCard(
    index: Int,
    distance: String,
    bearing: String,
    onDistanceChange: (String) -> Unit,
    onBearingChange: (String) -> Unit
) {
    Card(
        colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(
                text = "Line $index",
                color = Color(0xFF90CAF9),
                fontSize = 15.sp,
                fontWeight = FontWeight.SemiBold
            )
            Spacer(Modifier.height(8.dp))
            OutlinedTextField(
                value = distance,
                onValueChange = onDistanceChange,
                label = { Text("Distance (m)") },
                placeholder = { Text("e.g. 60.123") },
                modifier = Modifier.fillMaxWidth(),
                singleLine = true,
                supportingText = { Text("Distance used with latitude and departure", color = Color.Gray) }
            )
            Spacer(Modifier.height(8.dp))
            OutlinedTextField(
                value = bearing,
                onValueChange = onBearingChange,
                label = { Text("Bearing (degrees)") },
                placeholder = { Text("e.g. 30 or 100.5") },
                modifier = Modifier.fillMaxWidth(),
                singleLine = true,
                supportingText = { Text("Whole circle bearing in decimal degrees", color = Color.Gray) }
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun TraverseScreenPreview() {
    TraverseScreen(onBack = {})
}


