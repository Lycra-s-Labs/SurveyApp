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
import kotlin.math.cos
import kotlin.math.sin
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
        title = "Coordinate Calculator",
        subtitle = "Calculate new coordinates from distance and bearing",
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
                    Spacer(Modifier.height(8.dp))

                    OutlinedTextField(
                        value = d,
                        onValueChange = { d = it; errorMsg = null; result = "" },
                        label = { Text("Distance") },
                        placeholder = { Text("e.g. 100.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Distance from point 1 to point 2", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = theta,
                        onValueChange = { theta = it; errorMsg = null; result = "" },
                        label = { Text("Bearing (degrees)") },
                        placeholder = { Text("e.g. 45") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Angle from north (0\u00B0 to 360\u00B0)", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = e1,
                        onValueChange = { e1 = it; errorMsg = null; result = "" },
                        label = { Text("Starting Easting (E1)") },
                        placeholder = { Text("e.g. 500000.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("X coordinate of the starting point", color = Color.Gray) }
                    )
                    Spacer(Modifier.height(8.dp))
                    OutlinedTextField(
                        value = n1,
                        onValueChange = { n1 = it; errorMsg = null; result = "" },
                        label = { Text("Starting Northing (N1)") },
                        placeholder = { Text("e.g. 300000.00") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        supportingText = { Text("Y coordinate of the starting point", color = Color.Gray) }
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
                        text = "\u0394E = Distance \u00D7 sin(Bearing)\n\u0394N = Distance \u00D7 cos(Bearing)\nE2 = E1 + \u0394E\nN2 = N1 + \u0394N",
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

                    val ang = Math.toRadians(angDeg)
                    val dN = dist * cos(ang)
                    val dE = dist * sin(ang)

                    val e2 = eStart + dE
                    val n2 = nStart + dN

                    result = """\u0394E: ${"%.3f".format(dE)} units
\u0394N: ${"%.3f".format(dN)} units
E2: ${"%.3f".format(e2)}
N2: ${"%.3f".format(n2)}"""
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
                        text = result.ifBlank { "Calculated coordinate values will appear here." },
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