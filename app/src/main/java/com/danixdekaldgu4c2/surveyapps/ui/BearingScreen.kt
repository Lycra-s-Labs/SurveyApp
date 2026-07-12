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
fun BearingScreen(onBack: () -> Unit) {
    var input by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }
    var errorMsg by remember { mutableStateOf<String?>(null) }

    ScreenFrame(
        title = "Bearing Converter",
        subtitle = "Convert Whole Circle Bearing (WCB) to reduced bearing",
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
                        text = "Enter WCB / Azimuth",
                        color = Color.White,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(4.dp))
                    Text(
                        text = "An angle from 0\u00B0 to 360\u00B0, measured clockwise from true north.",
                        color = Color.Gray,
                        fontSize = 12.sp
                    )
                    Spacer(Modifier.height(12.dp))

                    OutlinedTextField(
                        value = input,
                        onValueChange = {
                            input = it
                            errorMsg = null
                            result = ""
                        },
                        label = { Text("Angle (degrees)") },
                        placeholder = { Text("e.g. 45, 180, 315") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        isError = errorMsg != null,
                        supportingText = errorMsg?.let { msg -> { Text(msg, color = Color(0xFFEF5350)) } }
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            // Tips card
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
                    Spacer(Modifier.height(6.dp))
                    Text(
                        text = "WCB: Measured clockwise from north (0-360\u00B0)\nReduced Bearing: Quadrant bearing (e.g. N45\u00B0E)\nBack Bearing: Opposite direction bearing",
                        color = Color.Gray,
                        fontSize = 12.sp
                    )
                }
            }

            Spacer(Modifier.height(16.dp))

            Button(
                onClick = {
                    val t = input.toDoubleOrNull()
                    if (t == null) {
                        errorMsg = "Please enter a valid number (e.g. 45.5)"
                        return@Button
                    }
                    errorMsg = null

                    val normalized = ((t % 360) + 360) % 360

                    val reduced = when {
                        normalized <= 90.0 -> "N ${"%.2f".format(normalized)}\u00B0 E"
                        normalized <= 180.0 -> "S ${"%.2f".format(180.0 - normalized)}\u00B0 E"
                        normalized <= 270.0 -> "S ${"%.2f".format(normalized - 180.0)}\u00B0 W"
                        else -> "N ${"%.2f".format(360.0 - normalized)}\u00B0 W"
                    }

                    val backBearing = if (normalized < 180.0) normalized + 180.0 else normalized - 180.0

                    result = "WCB: ${"%.2f".format(t)}\u00B0\nReduced Bearing: $reduced\nBack Bearing: ${"%.2f".format(backBearing)}\u00B0"
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Convert", fontSize = 16.sp)
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
                        text = result.ifBlank { "Your converted bearing will appear here." },
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
fun BearingScreenPreview() {
    BearingScreen(onBack = {})
}