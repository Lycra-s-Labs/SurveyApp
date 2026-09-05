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
fun CoordinateScreen(onBack: () -> Unit) {
    var d by remember { mutableStateOf("") }
    var theta by remember { mutableStateOf("") }
    var e1 by remember { mutableStateOf("") }
    var n1 by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }
    var errorMsg by remember { mutableStateOf<String?>(null) }

    ScreenFrame(
        title = "Coordinate Computation",
        subtitle = "Compute latitude/departure and the new Easting/Northing from distance and WCB",
        onBack = onBack
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .verticalScroll(rememberScrollState())
        ) {
            // Input section
            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "Known Values",
                        color = Color(0xFF64B5F6),
                        fontSize = 16.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(32.dp))

                    OutlinedTextField(
                        value = d,
                        onValueChange = { d = it; errorMsg = null; result = "" },
                        label = { Text("Distance (m)") },
                        placeholder = { Text("e.g. 100.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Distance used in latitude = D × cos θ and departure = D × sin θ", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = theta,
                        onValueChange = { theta = it; errorMsg = null; result = "" },
                        label = { Text("Bearing (° WCB)") },
                        placeholder = { Text("e.g. 45") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Measured clockwise from north", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = e1,
                        onValueChange = { e1 = it; errorMsg = null; result = "" },
                        label = { Text("Starting Easting (E1, m)") },
                        placeholder = { Text("e.g. 500000.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Reference X coordinate", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = n1,
                        onValueChange = { n1 = it; errorMsg = null; result = "" },
                        label = { Text("Starting Northing (N1, m)") },
                        placeholder = { Text("e.g. 300000.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Reference Y coordinate", color = Color.Gray) }
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            // How it works card
            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "How it works",
                        color = Color(0xFF64B5F6),
                        fontSize = 14.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(4.dp))
                    Text(
                        text = "ΔN = Distance × cos(Bearing)\nΔE = Distance × sin(Bearing)\nE2 = E1 + ΔE\nN2 = N1 + ΔN",
                        color = Color.Gray,
                        fontSize = 12.sp
                    )
                }
            }

            Spacer(Modifier.height(16.dp))

            Button(
                onClick = {
                    val dist = d.toDoubleOrNull()
                    val angDeg = theta.toDoubleOrNull()
                    val eStart = e1.toDoubleOrNull()
                    val nStart = n1.toDoubleOrNull()

                    if (dist == null || angDeg == null || eStart == null || nStart == null) {
                        errorMsg = "Please fill in all four values correctly."
                        return@Button
                    }
                    errorMsg = null

                    val solution = coordinateFromStart(
                        startEasting = eStart,
                        startNorthing = nStart,
                        distance = dist,
                        bearingDeg = angDeg
                    )

                    result = "ΔE: ${formatValue(solution.latitudeDeparture.departure)} m\nΔN: ${formatValue(solution.latitudeDeparture.latitude)} m\nE2: ${formatValue(solution.easting)} m\nN2: ${formatValue(solution.northing)} m"
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Calculate Coordinates", fontSize = 16.sp)
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

            // Result section
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
                        text = result.ifBlank { "Calculated latitude, departure, and coordinate values will appear here." },
                        color = if (result.isBlank()) Color.Gray else Color.White,
                        fontSize = 14.sp
                    )
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun CoordinateScreenPreview() {
    CoordinateScreen(onBack = {})
}