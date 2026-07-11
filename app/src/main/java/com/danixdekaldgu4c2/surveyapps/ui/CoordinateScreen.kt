package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.Column
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
import kotlin.math.cos
import kotlin.math.sin
import androidx.compose.ui.unit.dp
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun CoordinateScreen(onBack: () -> Unit) {
    var d by remember { mutableStateOf("") }
    var theta by remember { mutableStateOf("") }
    var e1 by remember { mutableStateOf("") }
    var n1 by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }

    ScreenFrame(
        title = "Coordinate Calculator",
        subtitle = "E / N from distance and bearing",
        onBack = onBack
    ) {
        OutlinedTextField(
            value = d,
            onValueChange = { d = it },
            label = { Text("Distance") },
            modifier = Modifier.fillMaxWidth()
        )

        OutlinedTextField(
            value = theta,
            onValueChange = { theta = it },
            label = { Text("Bearing (degrees)") },
            modifier = Modifier.fillMaxWidth()
        )

        OutlinedTextField(
            value = e1,
            onValueChange = { e1 = it },
            label = { Text("E1") },
            modifier = Modifier.fillMaxWidth()
        )

        OutlinedTextField(
            value = n1,
            onValueChange = { n1 = it },
            label = { Text("N1") },
            modifier = Modifier.fillMaxWidth()
        )

        Button(onClick = {
            val dist = d.toDoubleOrNull()
            val angDeg = theta.toDoubleOrNull()
            val eStart = e1.toDoubleOrNull()
            val nStart = n1.toDoubleOrNull()

            if (dist == null || angDeg == null || eStart == null || nStart == null) {
                result = "Enter all values correctly."
                return@Button
            }

            val ang = Math.toRadians(angDeg)
            val dN = dist * cos(ang)
            val dE = dist * sin(ang)

            val e2 = eStart + dE
            val n2 = nStart + dN

            result = "ΔE: %.3f\nΔN: %.3f\nE2: %.3f\nN2: %.3f".format(dE, dN, e2, n2)
        }) {
            Text("Calculate")
        }

        Card(
            colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
            modifier = Modifier.fillMaxWidth()
        ) {
            Text(
                text = result.ifBlank { "Result will appear here." },
                color = Color.White,
                modifier = Modifier.padding(16.dp)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun CoordinateScreenPreview() {
    CoordinateScreen(onBack = {})
}