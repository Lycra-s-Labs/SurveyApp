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
import kotlin.math.pow
import kotlin.math.sqrt
import androidx.compose.ui.tooling.preview.Preview


@Composable
fun DistanceScreen(onBack: () -> Unit) {
    var e1 by remember { mutableStateOf("") }
    var n1 by remember { mutableStateOf("") }
    var e2 by remember { mutableStateOf("") }
    var n2 by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }
    var errorMsg by remember { mutableStateOf<String?>(null) }

    ScreenFrame(
        title = "Distance Computation",
        subtitle = "Use the Pythagoras theorem to compute the straight-line distance between two coordinates",
        onBack = onBack
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .verticalScroll(rememberScrollState())
        ) {
            // Point 1 section
            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "Point 1",
                        color = Color(0xFF64B5F6),
                        fontSize = 16.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(8.dp))

                    OutlinedTextField(
                        value = e1,
                        onValueChange = { e1 = it; errorMsg = null; result = "" },
                        label = { Text("Easting (E1)") },
                        placeholder = { Text("e.g. 500000.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("X coordinate of the first point", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = n1,
                        onValueChange = { n1 = it; errorMsg = null; result = "" },
                        label = { Text("Northing (N1)") },
                        placeholder = { Text("e.g. 300000.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Y coordinate of the first point", color = Color.Gray) }
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            // Point 2 section
            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "Point 2",
                        color = Color(0xFF64B5F6),
                        fontSize = 16.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(8.dp))

                    OutlinedTextField(
                        value = e2,
                        onValueChange = { e2 = it; errorMsg = null; result = "" },
                        label = { Text("Easting (E2)") },
                        placeholder = { Text("e.g. 500100.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("X coordinate of the second point", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = n2,
                        onValueChange = { n2 = it; errorMsg = null; result = "" },
                        label = { Text("Northing (N2)") },
                        placeholder = { Text("e.g. 300200.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Y coordinate of the second point", color = Color.Gray) }
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            // Formula card
            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "Formula",
                        color = Color(0xFF64B5F6),
                        fontSize = 14.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(4.dp))
                    Text(
                        text = "Distance = √[(E2 − E1)² + (N2 − N1)²]",
                        color = Color.Gray,
                        fontSize = 12.sp
                    )
                }
            }

            Spacer(Modifier.height(16.dp))

            Button(
                onClick = {
                    val startE = e1.toDoubleOrNull()
                    val startN = n1.toDoubleOrNull()
                    val endE = e2.toDoubleOrNull()
                    val endN = n2.toDoubleOrNull()

                    if (startE == null || startN == null || endE == null || endN == null) {
                        errorMsg = "Please fill in all four coordinate values correctly."
                        return@Button
                    }
                    errorMsg = null

                    val d = distanceBetweenCoordinates(startE, startN, endE, endN)
                    val deltaE = endE - startE
                    val deltaN = endN - startN
                    result = "ΔE: ${formatValue(deltaE)} m\nΔN: ${formatValue(deltaN)} m\nDistance: ${formatValue(d)} m"
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Calculate Distance", fontSize = 16.sp)
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
                        text = result.ifBlank { "The coordinate deltas and calculated distance will appear here." },
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
fun DistanceScreenPreview() {
    DistanceScreen(onBack = {})
}