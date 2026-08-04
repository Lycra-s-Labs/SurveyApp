package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

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
        subtitle = "Use the Pythagorean theorem to compute the straight-line distance between two coordinates.",
        onBack = onBack
    ) {
        Column(modifier = Modifier.fillMaxWidth()) {
            SurveyFormSection(title = "Point 1") {
                SurveyTextInput(
                    value = e1,
                    onValueChange = { e1 = it; errorMsg = null; result = "" },
                    label = "Easting (E1)",
                    placeholder = "e.g. 500000.00",
                    helperText = "Reference X coordinate"
                )
                Spacer(Modifier.height(12.dp))
                SurveyTextInput(
                    value = n1,
                    onValueChange = { n1 = it; errorMsg = null; result = "" },
                    label = "Northing (N1)",
                    placeholder = "e.g. 300000.00",
                    helperText = "Reference Y coordinate"
                )
            }

            Spacer(Modifier.height(12.dp))

            SurveyFormSection(title = "Point 2") {
                SurveyTextInput(
                    value = e2,
                    onValueChange = { e2 = it; errorMsg = null; result = "" },
                    label = "Easting (E2)",
                    placeholder = "e.g. 500100.00",
                    helperText = "Target X coordinate"
                )
                Spacer(Modifier.height(12.dp))
                SurveyTextInput(
                    value = n2,
                    onValueChange = { n2 = it; errorMsg = null; result = "" },
                    label = "Northing (N2)",
                    placeholder = "e.g. 300200.00",
                    helperText = "Target Y coordinate"
                )
            }

            Spacer(Modifier.height(12.dp))

            SurveyFormSection(title = "Formula") {
                SurveyInfoText("Distance = sqrt((E2 - E1)^2 + (N2 - N1)^2)")
            }

            Spacer(Modifier.height(16.dp))

            SurveyActionButton(
                text = "Calculate Distance",
                onClick = {
                    val startE = e1.toDoubleOrNull()
                    val startN = n1.toDoubleOrNull()
                    val endE = e2.toDoubleOrNull()
                    val endN = n2.toDoubleOrNull()

                    if (startE == null || startN == null || endE == null || endN == null) {
                        errorMsg = "Please fill in all four coordinate values correctly."
                    } else {
                        errorMsg = null
                        val d = distanceBetweenCoordinates(startE, startN, endE, endN)
                        val deltaE = endE - startE
                        val deltaN = endN - startN
                        result = "Delta E: ${formatValue(deltaE)} m\nDelta N: ${formatValue(deltaN)} m\nDistance: ${formatValue(d)} m"
                    }
                }
            )

            if (errorMsg != null) {
                Spacer(Modifier.height(8.dp))
                SurveyInfoText(errorMsg!!)
            }

            Spacer(Modifier.height(16.dp))

            SurveyResultCard(
                title = "Result",
                message = result.ifBlank { "The coordinate deltas and calculated distance will appear here." },
                isEmpty = result.isBlank()
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DistanceScreenPreview() {
    DistanceScreen(onBack = {})
}
