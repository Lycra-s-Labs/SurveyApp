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
import kotlin.math.pow
import kotlin.math.sqrt
import androidx.compose.ui.unit.dp
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun DistanceScreen(onBack: () -> Unit) {
    var e1 by remember { mutableStateOf("") }
    var n1 by remember { mutableStateOf("") }
    var e2 by remember { mutableStateOf("") }
    var n2 by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }

    ScreenFrame(
        title = "Distance Calculator",
        subtitle = "Distance between two points",
        onBack = onBack
    ) {
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

        OutlinedTextField(
            value = e2,
            onValueChange = { e2 = it },
            label = { Text("E2") },
            modifier = Modifier.fillMaxWidth()
        )

        OutlinedTextField(
            value = n2,
            onValueChange = { n2 = it },
            label = { Text("N2") },
            modifier = Modifier.fillMaxWidth()
        )

        Button(onClick = {
            val startE = e1.toDoubleOrNull()
            val startN = n1.toDoubleOrNull()
            val endE = e2.toDoubleOrNull()
            val endN = n2.toDoubleOrNull()

            if (startE == null || startN == null || endE == null || endN == null) {
                result = "Enter all values correctly."
                return@Button
            }

            val d = sqrt(
                (endE - startE).pow(2) +
                        (endN - startN).pow(2)
            )
            result = "Distance: %.3f".format(d)
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
                modifier = androidx.compose.ui.Modifier.padding(16.dp)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DistanceScreenPreview() {
    DistanceScreen(onBack = {})
}