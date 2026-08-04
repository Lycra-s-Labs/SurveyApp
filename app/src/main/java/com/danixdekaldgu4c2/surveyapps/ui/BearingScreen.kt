package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BearingScreen(onBack: () -> Unit) {
    var mode by remember { mutableStateOf("wcb_qb") }
    var wcbInput by remember { mutableStateOf("") }
    var qbPrefix by remember { mutableStateOf("N") }
    var qbAngle by remember { mutableStateOf("") }
    var qbSuffix by remember { mutableStateOf("E") }
    var firstBearing by remember { mutableStateOf("") }
    var secondBearing by remember { mutableStateOf("") }
    var knownBearing by remember { mutableStateOf("") }
    var internalAngleInput by remember { mutableStateOf("") }
    var turnRight by remember { mutableStateOf(true) }
    var result by remember { mutableStateOf("") }
    var errorMsg by remember { mutableStateOf<String?>(null) }

    ScreenFrame(
        title = "Bearing and Angle",
        subtitle = "Convert whole-circle bearing, quadrant bearing, internal angle, and known-angle bearing results.",
        onBack = onBack
    ) {
        Column(modifier = Modifier.fillMaxWidth()) {
            SurveyFormSection(title = "Choose a mode") {
                SurveyChipRow {
                    SurveyAssistChip(
                        selected = mode == "wcb_qb",
                        label = "WCB to QB",
                        selectedContainerColor = Color(0xFFEAF0FD),
                        selectedLabelColor = Color(0xFF2E6BE6),
                        onClick = { mode = "wcb_qb" }
                    )
                    SurveyAssistChip(
                        selected = mode == "qb_wcb",
                        label = "QB to WCB",
                        selectedContainerColor = Color(0xFFEAF0FD),
                        selectedLabelColor = Color(0xFF2E6BE6),
                        onClick = { mode = "qb_wcb" }
                    )
                }
                Spacer(Modifier.height(8.dp))
                SurveyChipRow {
                    SurveyAssistChip(
                        selected = mode == "internal",
                        label = "Internal angle",
                        selectedContainerColor = Color(0xFFEAF0FD),
                        selectedLabelColor = Color(0xFF2E6BE6),
                        onClick = { mode = "internal" }
                    )
                    SurveyAssistChip(
                        selected = mode == "known",
                        label = "Known + angle",
                        selectedContainerColor = Color(0xFFEAF0FD),
                        selectedLabelColor = Color(0xFF2E6BE6),
                        onClick = { mode = "known" }
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            SurveyFormSection(title = "Input") {
                when (mode) {
                    "wcb_qb" -> {
                        SurveyInfoText("Convert a whole-circle bearing to quadrant bearing.")
                        Spacer(Modifier.height(12.dp))
                        SurveyTextInput(
                            value = wcbInput,
                            onValueChange = { wcbInput = it; errorMsg = null; result = "" },
                            label = "Whole-circle bearing (deg)",
                            placeholder = "e.g. 342.90"
                        )
                    }

                    "qb_wcb" -> {
                        SurveyInfoText("Convert a quadrant bearing to whole-circle bearing.")
                        Spacer(Modifier.height(12.dp))
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp), modifier = Modifier.fillMaxWidth()) {
                            SurveyTextInput(
                                value = qbPrefix,
                                onValueChange = { qbPrefix = it.take(1).uppercase(); errorMsg = null; result = "" },
                                label = "N or S",
                                placeholder = "N"
                            )
                            SurveyTextInput(
                                value = qbAngle,
                                onValueChange = { qbAngle = it; errorMsg = null; result = "" },
                                label = "Angle",
                                placeholder = "e.g. 20.50"
                            )
                            SurveyTextInput(
                                value = qbSuffix,
                                onValueChange = { qbSuffix = it.take(1).uppercase(); errorMsg = null; result = "" },
                                label = "E or W",
                                placeholder = "E"
                            )
                        }
                    }

                    "internal" -> {
                        SurveyInfoText("Find the smaller angle between two bearings.")
                        Spacer(Modifier.height(12.dp))
                        SurveyTextInput(
                            value = firstBearing,
                            onValueChange = { firstBearing = it; errorMsg = null; result = "" },
                            label = "First bearing (deg)",
                            placeholder = "e.g. 30.00"
                        )
                        Spacer(Modifier.height(12.dp))
                        SurveyTextInput(
                            value = secondBearing,
                            onValueChange = { secondBearing = it; errorMsg = null; result = "" },
                            label = "Second bearing (deg)",
                            placeholder = "e.g. 100.50"
                        )
                    }

                    else -> {
                        SurveyInfoText("Apply an internal angle from a known bearing and turn direction.")
                        Spacer(Modifier.height(12.dp))
                        SurveyTextInput(
                            value = knownBearing,
                            onValueChange = { knownBearing = it; errorMsg = null; result = "" },
                            label = "Known bearing (deg)",
                            placeholder = "e.g. 134.00"
                        )
                        Spacer(Modifier.height(12.dp))
                        SurveyTextInput(
                            value = internalAngleInput,
                            onValueChange = { internalAngleInput = it; errorMsg = null; result = "" },
                            label = "Internal angle (deg)",
                            placeholder = "e.g. 82.50"
                        )
                        Spacer(Modifier.height(12.dp))
                        SurveyChipRow {
                            SurveyAssistChip(
                                selected = turnRight,
                                label = "Turn right",
                                selectedContainerColor = Color(0xFFEAF8F5),
                                selectedLabelColor = Color(0xFF2BB8A6),
                                onClick = { turnRight = true }
                            )
                            SurveyAssistChip(
                                selected = !turnRight,
                                label = "Turn left",
                                selectedContainerColor = Color(0xFFEAF8F5),
                                selectedLabelColor = Color(0xFF2BB8A6),
                                onClick = { turnRight = false }
                            )
                        }
                    }
                }
            }

            Spacer(Modifier.height(16.dp))

            SurveyActionButton(text = "Solve Bearing", onClick = {
                errorMsg = null
                result = when (mode) {
                    "wcb_qb" -> {
                        val wcb = wcbInput.toDoubleOrNull()
                        if (wcb == null) {
                            errorMsg = "Enter a valid WCB in degrees."
                            ""
                        } else {
                            val normalized = normalizeBearing(wcb)
                            val qb = wcbToQuadrantBearing(normalized)
                            "WCB: ${formatBearing(normalized)} deg\nQuadrant bearing: $qb\nBack bearing: ${formatBearing(normalizeBearing(normalized + 180.0))} deg"
                        }
                    }

                    "qb_wcb" -> {
                        val angle = qbAngle.toDoubleOrNull()
                        val prefix = qbPrefix.trim().uppercase()
                        val suffix = qbSuffix.trim().uppercase()
                        if (angle == null) {
                            errorMsg = "Enter the quadrant angle in degrees."
                            ""
                        } else if (prefix !in listOf("N", "S") || suffix !in listOf("E", "W")) {
                            errorMsg = "Use N or S first, and E or W second."
                            ""
                        } else {
                            val wcb = quadrantBearingToWcb(prefix, angle, suffix)
                            "Quadrant bearing: $prefix ${formatValue(angle, 2)} deg $suffix\nWhole-circle bearing: ${formatBearing(wcb)} deg"
                        }
                    }

                    "internal" -> {
                        val b1 = firstBearing.toDoubleOrNull()
                        val b2 = secondBearing.toDoubleOrNull()
                        if (b1 == null || b2 == null) {
                            errorMsg = "Enter both bearings in degrees."
                            ""
                        } else {
                            val angle = internalAngleFromBearings(b1, b2)
                            "First bearing: ${formatBearing(b1)} deg\nSecond bearing: ${formatBearing(b2)} deg\nInternal angle: ${formatBearing(angle)} deg"
                        }
                    }

                    else -> {
                        val known = knownBearing.toDoubleOrNull()
                        val angle = internalAngleInput.toDoubleOrNull()
                        if (known == null || angle == null) {
                            errorMsg = "Enter both the known bearing and the internal angle."
                            ""
                        } else {
                            val next = bearingFromKnownAndInternal(known, angle, turnRight)
                            "Known bearing: ${formatBearing(known)} deg\nInternal angle: ${formatBearing(angle)} deg\nTurn: ${if (turnRight) "Right" else "Left"}\nComputed bearing: ${formatBearing(next)} deg"
                        }
                    }
                }
            })

            if (errorMsg != null) {
                Spacer(Modifier.height(8.dp))
                SurveyInfoText(errorMsg!!)
            }

            Spacer(Modifier.height(16.dp))

            SurveyResultCard(
                title = "Result",
                message = result.ifBlank { "Your bearing calculation will appear here." },
                isEmpty = result.isBlank()
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun BearingScreenPreview() {
    BearingScreen(onBack = {})
}
