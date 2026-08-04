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
fun CoordinateScreen(onBack: () -> Unit) {
    var d by remember { mutableStateOf("") }
    var theta by remember { mutableStateOf("") }
    var e1 by remember { mutableStateOf("") }
    var n1 by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }
    var errorMsg by remember { mutableStateOf<String?>(null) }

    ScreenFrame(
        title = "Coordinate Computation",
        subtitle = "Compute latitude, departure, and the new Easting and Northing from distance and whole-circle bearing.",
        onBack = onBack
    ) {
        Column(modifier = Modifier.fillMaxWidth()) {
            SurveyFormSection(title = "Known values") {
                SurveyTextInput(
                    value = d,
                    onValueChange = { d = it; errorMsg = null; result = "" },
                    label = "Distance (m)",
                    placeholder = "e.g. 100.00",
                    helperText = "Distance used in the latitude and departure equations"
                )
                Spacer(Modifier.height(12.dp))
                SurveyTextInput(
                    value = theta,
                    onValueChange = { theta = it; errorMsg = null; result = "" },
                    label = "Bearing (deg WCB)",
                    placeholder = "e.g. 45",
                    helperText = "Measured clockwise from north"
                )
                Spacer(Modifier.height(12.dp))
                SurveyTextInput(
                    value = e1,
                    onValueChange = { e1 = it; errorMsg = null; result = "" },
                    label = "Starting Easting (E1)",
                    placeholder = "e.g. 500000.00",
                    helperText = "Reference X coordinate"
                )
                Spacer(Modifier.height(12.dp))
                SurveyTextInput(
                    value = n1,
                    onValueChange = { n1 = it; errorMsg = null; result = "" },
                    label = "Starting Northing (N1)",
                    placeholder = "e.g. 300000.00",
                    helperText = "Reference Y coordinate"
                )
            }

            Spacer(Modifier.height(12.dp))

            SurveyFormSection(title = "How it works") {
                SurveyInfoText("dN = distance * cos(bearing)\ndE = distance * sin(bearing)\nE2 = E1 + dE\nN2 = N1 + dN")
            }

            Spacer(Modifier.height(16.dp))

            SurveyActionButton(
                text = "Calculate Coordinates",
                onClick = {
                    val dist = d.toDoubleOrNull()
                    val angDeg = theta.toDoubleOrNull()
                    val eStart = e1.toDoubleOrNull()
                    val nStart = n1.toDoubleOrNull()

                    if (dist == null || angDeg == null || eStart == null || nStart == null) {
                        errorMsg = "Please fill in all four values correctly."
                    } else {
                        errorMsg = null
                        val solution = coordinateFromStart(
                            startEasting = eStart,
                            startNorthing = nStart,
                            distance = dist,
                            bearingDeg = angDeg
                        )

                        result = buildString {
                            appendLine("dE: ${formatValue(solution.latitudeDeparture.departure)} m")
                            appendLine("dN: ${formatValue(solution.latitudeDeparture.latitude)} m")
                            appendLine("E2: ${formatValue(solution.easting)} m")
                            appendLine("N2: ${formatValue(solution.northing)} m")
                        }.trimEnd()
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
                message = result.ifBlank { "Calculated latitude, departure, and coordinate values will appear here." },
                isEmpty = result.isBlank()
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun CoordinateScreenPreview() {
    CoordinateScreen(onBack = {})
}
