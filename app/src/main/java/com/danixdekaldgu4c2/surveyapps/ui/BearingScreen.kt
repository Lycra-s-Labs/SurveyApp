package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.fillMaxWidth
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
import androidx.compose.ui.unit.dp
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun BearingScreen(onBack: () -> Unit) {
    var input by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }

    ScreenFrame(
        title = "Bearing Converter",
        subtitle = "Convert WCB to reduced bearing",
        onBack = onBack
    ) {
        OutlinedTextField(
            value = input,
            onValueChange = { input = it },
            label = { Text("WCB / Azimuth") },
            modifier = Modifier.fillMaxWidth()
        )

        Button(onClick = {
            val t = input.toDoubleOrNull()
            if (t == null) {
                result = "Enter a bearing."
                return@Button
            }

            val normalized = ((t % 360) + 360) % 360

            val reduced = when {
                normalized <= 90.0 -> "N %.2f E".format(normalized)
                normalized <= 180.0 -> "S %.2f E".format(180.0 - normalized)
                normalized <= 270.0 -> "S %.2f W".format(normalized - 180.0)
                else -> "N %.2f W".format(360.0 - normalized)
            }

            val backBearing = if (normalized < 180.0) normalized + 180.0 else normalized - 180.0

            result = "Reduced Bearing: $reduced\nBack Bearing: %.2f°".format(backBearing)
        }) {
            Text("Convert")
        }

        Card(
            colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
            modifier = Modifier.fillMaxWidth()
        ) {
            Text(
                text = result.ifBlank { "Result will appear here." },
                color = Color.White,
                modifier = androidx.compose.ui.Modifier.padding(16.dp)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun BearingScreenPreview() {
    BearingScreen(onBack = {})
}