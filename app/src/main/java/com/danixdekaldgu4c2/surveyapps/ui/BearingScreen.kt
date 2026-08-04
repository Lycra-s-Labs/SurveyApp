package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
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
        title = "Bearing & Angle",
        subtitle = "Whole circle bearing, quadrant bearing, internal angle, and bearing from known angle",
        onBack = onBack
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .verticalScroll(rememberScrollState())
        ) {
            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = "Topic 1 reference",
                        color = Color(0xFF64B5F6),
                        fontSize = 14.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                    Spacer(Modifier.height(6.dp))
                    Text(
                        text = "WCB is measured clockwise from north. Quadrant bearing is written by quadrant, such as N45°E. Internal angle is the smaller angle between two bearings.",
                        color = Color(0xFFC4CEDA),
                        fontSize = 12.sp,
                        lineHeight = 16.sp
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            Row(horizontalArrangement = Arrangement.spacedBy(8.dp), modifier = Modifier.fillMaxWidth()) {
                AssistChip(
                    onClick = { mode = "wcb_qb" },
                    label = { Text("WCB → QB") },
                    colors = AssistChipDefaults.assistChipColors(
                        containerColor = if (mode == "wcb_qb") Color(0xFF64B5F6) else Color(0xFF2D353F),
                        labelColor = if (mode == "wcb_qb") Color(0xFF0B1720) else Color(0xFFC4CEDA)
                    )
                )
                AssistChip(
                    onClick = { mode = "qb_wcb" },
                    label = { Text("QB → WCB") },
                    colors = AssistChipDefaults.assistChipColors(
                        containerColor = if (mode == "qb_wcb") Color(0xFF64B5F6) else Color(0xFF2D353F),
                        labelColor = if (mode == "qb_wcb") Color(0xFF0B1720) else Color(0xFFC4CEDA)
                    )
                )
            }
            Spacer(Modifier.height(8.dp))
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp), modifier = Modifier.fillMaxWidth()) {
                AssistChip(
                    onClick = { mode = "internal" },
                    label = { Text("Internal angle") },
                    colors = AssistChipDefaults.assistChipColors(
                        containerColor = if (mode == "internal") Color(0xFF64B5F6) else Color(0xFF2D353F),
                        labelColor = if (mode == "internal") Color(0xFF0B1720) else Color(0xFFC4CEDA)
                    )
                )
                AssistChip(
                    onClick = { mode = "known" },
                    label = { Text("Known + angle") },
                    colors = AssistChipDefaults.assistChipColors(
                        containerColor = if (mode == "known") Color(0xFF64B5F6) else Color(0xFF2D353F),
                        labelColor = if (mode == "known") Color(0xFF0B1720) else Color(0xFFC4CEDA)
                    )
                )
            }

            Spacer(Modifier.height(12.dp))

            Card(
                colors = CardDefaults.cardColors(containerColor = Color(0xFF1E2227)),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    when (mode) {
                        "wcb_qb" -> {
                            Text(text = "Convert WCB to quadrant bearing", color = Color.White, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
                            Spacer(Modifier.height(8.dp))
                            OutlinedTextField(
                                value = wcbInput,
                                onValueChange = { wcbInput = it; errorMsg = null; result = "" },
                                label = { Text("Whole Circle Bearing (°)") },
                                placeholder = { Text("e.g. 342.90") },
                                modifier = Modifier.fillMaxWidth(),
                                singleLine = true
                            )
                        }

                        "qb_wcb" -> {
                            Text(text = "Convert quadrant bearing to WCB", color = Color.White, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
                            Spacer(Modifier.height(8.dp))
                            Row(horizontalArrangement = Arrangement.spacedBy(8.dp), modifier = Modifier.fillMaxWidth()) {
                                OutlinedTextField(
                                    value = qbPrefix,
                                    onValueChange = { qbPrefix = it.take(1).uppercase() ; errorMsg = null; result = "" },
                                    label = { Text("N / S") },
                                    modifier = Modifier.weight(0.7f),
                                    singleLine = true
                                )
                                OutlinedTextField(
                                    value = qbAngle,
                                    onValueChange = { qbAngle = it; errorMsg = null; result = "" },
                                    label = { Text("Angle") },
                                    placeholder = { Text("e.g. 20.50") },
                                    modifier = Modifier.weight(1f),
                                    singleLine = true
                                )
                                OutlinedTextField(
                                    value = qbSuffix,
                                    onValueChange = { qbSuffix = it.take(1).uppercase(); errorMsg = null; result = "" },
                                    label = { Text("E / W") },
                                    modifier = Modifier.weight(0.7f),
                                    singleLine = true
                                )
                            }
                        }

                        "internal" -> {
                            Text(text = "Calculate internal angle from two bearings", color = Color.White, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
                            Spacer(Modifier.height(8.dp))
                            OutlinedTextField(
                                value = firstBearing,
                                onValueChange = { firstBearing = it; errorMsg = null; result = "" },
                                label = { Text("First bearing (°)") },
                                placeholder = { Text("e.g. 30.00") },
                                modifier = Modifier.fillMaxWidth(),
                                singleLine = true
                            )
                            Spacer(Modifier.height(8.dp))
                            OutlinedTextField(
                                value = secondBearing,
                                onValueChange = { secondBearing = it; errorMsg = null; result = "" },
                                label = { Text("Second bearing (°)") },
                                placeholder = { Text("e.g. 100.50") },
                                modifier = Modifier.fillMaxWidth(),
                                singleLine = true
                            )
                        }

                        else -> {
                            Text(text = "Bearing from internal angle and known bearing", color = Color.White, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
                            Spacer(Modifier.height(8.dp))
                            OutlinedTextField(
                                value = knownBearing,
                                onValueChange = { knownBearing = it; errorMsg = null; result = "" },
                                label = { Text("Known bearing (°)") },
                                placeholder = { Text("e.g. 134.00") },
                                modifier = Modifier.fillMaxWidth(),
                                singleLine = true
                            )
                            Spacer(Modifier.height(8.dp))
                            OutlinedTextField(
                                value = internalAngleInput,
                                onValueChange = { internalAngleInput = it; errorMsg = null; result = "" },
                                label = { Text("Internal angle (°)") },
                                placeholder = { Text("e.g. 82.50") },
                                modifier = Modifier.fillMaxWidth(),
                                singleLine = true
                            )
                            Spacer(Modifier.height(8.dp))
                            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                                AssistChip(
                                    onClick = { turnRight = true },
                                    label = { Text("Turn right") },
                                    colors = AssistChipDefaults.assistChipColors(
                                        containerColor = if (turnRight) Color(0xFF4DB6AC) else Color(0xFF2D353F),
                                        labelColor = if (turnRight) Color(0xFF0B1720) else Color(0xFFC4CEDA)
                                    )
                                )
                                AssistChip(
                                    onClick = { turnRight = false },
                                    label = { Text("Turn left") },
                                    colors = AssistChipDefaults.assistChipColors(
                                        containerColor = if (!turnRight) Color(0xFF4DB6AC) else Color(0xFF2D353F),
                                        labelColor = if (!turnRight) Color(0xFF0B1720) else Color(0xFFC4CEDA)
                                    )
                                )
                            }
                        }
                    }
                }
            }

            Spacer(Modifier.height(12.dp))

            Button(
                onClick = {
                    errorMsg = null
                    result = ""
                    result = when (mode) {
                        "wcb_qb" -> {
                            val wcb = wcbInput.toDoubleOrNull()
                            if (wcb == null) {
                                errorMsg = "Enter a valid WCB in degrees."
                                return@Button
                            }
                            val normalized = normalizeBearing(wcb)
                            val qb = wcbToQuadrantBearing(normalized)
                            "WCB: ${formatBearing(normalized)}°\nQuadrant bearing: $qb\nBack bearing: ${formatBearing(normalizeBearing(normalized + 180.0))}°"
                        }

                        "qb_wcb" -> {
                            val angle = qbAngle.toDoubleOrNull()
                            if (angle == null) {
                                errorMsg = "Enter the quadrant angle in degrees."
                                return@Button
                            }
                            val prefix = qbPrefix.trim().uppercase()
                            val suffix = qbSuffix.trim().uppercase()
                            if (prefix !in listOf("N", "S") || suffix !in listOf("E", "W")) {
                                errorMsg = "Use N or S for the first direction and E or W for the second direction."
                                return@Button
                            }
                            val wcb = quadrantBearingToWcb(prefix, angle, suffix)
                            "Quadrant bearing: $prefix ${formatValue(angle, 2)}° $suffix\nWhole circle bearing: ${formatBearing(wcb)}°"
                        }

                        "internal" -> {
                            val b1 = firstBearing.toDoubleOrNull()
                            val b2 = secondBearing.toDoubleOrNull()
                            if (b1 == null || b2 == null) {
                                errorMsg = "Enter both bearings in degrees."
                                return@Button
                            }
                            val angle = internalAngleFromBearings(b1, b2)
                            "First bearing: ${formatBearing(b1)}°\nSecond bearing: ${formatBearing(b2)}°\nInternal angle: ${formatBearing(angle)}°"
                        }

                        else -> {
                            val known = knownBearing.toDoubleOrNull()
                            val angle = internalAngleInput.toDoubleOrNull()
                            if (known == null || angle == null) {
                                errorMsg = "Enter both the known bearing and the internal angle."
                                return@Button
                            }
                            val next = bearingFromKnownAndInternal(known, angle, turnRight)
                            "Known bearing: ${formatBearing(known)}°\nInternal angle: ${formatBearing(angle)}°\nTurn: ${if (turnRight) "Right" else "Left"}\nComputed bearing: ${formatBearing(next)}°"
                        }
                    }
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Solve Bearing")
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
                        text = result.ifBlank { "Your bearing calculation will appear here." },
                        color = if (result.isBlank()) Color.Gray else Color.White,
                        fontSize = 13.sp,
                        lineHeight = 18.sp
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