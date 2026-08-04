package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.AssistChip
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Delete
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun TraverseScreen(onBack: () -> Unit) {
    data class TraverseLineEntry(
        val id: Long,
        val lineNumber: Int,
        val distance: String = "",
        val bearing: String = ""
    )

    var nextId by remember { mutableLongStateOf(1L) }
    val lines = remember {
        mutableStateListOf(
            TraverseLineEntry(id = 1L, lineNumber = 1),
            TraverseLineEntry(id = 2L, lineNumber = 2),
            TraverseLineEntry(id = 3L, lineNumber = 3),
            TraverseLineEntry(id = 4L, lineNumber = 4)
        )
    }
    var result by remember { mutableStateOf("") }
    var errorMsg by remember { mutableStateOf<String?>(null) }

    ScreenFrame(
        title = "Traverse and Coordinate",
        subtitle = "Calculate latitude, departure, linear misclose, accuracy, and correction values for four traverse lines.",
        onBack = onBack
    ) {
        Column(modifier = Modifier.fillMaxWidth()) {
            SurveyFormSection(title = "Reference formulas") {
                SurveyInfoText("Latitude = distance * cos(theta)\nDeparture = distance * sin(theta)\nLinear misclose = sqrt(sumLat^2 + sumDep^2)\nBowditch correction uses distance proportion\nTransit correction uses latitude and departure proportion")
            }

            Spacer(Modifier.height(12.dp))

            SurveyActionButton(
                text = "Add new line",
                onClick = {
                    nextId += 1
                    lines.add(TraverseLineEntry(id = nextId, lineNumber = lines.size + 1))
                }
            )

            Spacer(Modifier.height(12.dp))

            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(10.dp),
                modifier = Modifier.fillMaxWidth()
            ) {
                items(lines, key = { it.id }) { line ->
                    TraverseLineCard(
                        index = line.lineNumber,
                        distance = line.distance,
                        bearing = line.bearing,
                        onDistanceChange = { newValue ->
                            errorMsg = null
                            result = ""
                            val index = lines.indexOfFirst { it.id == line.id }
                            if (index >= 0) {
                                lines[index] = line.copy(distance = newValue)
                            }
                        },
                        onBearingChange = { newValue ->
                            errorMsg = null
                            result = ""
                            val index = lines.indexOfFirst { it.id == line.id }
                            if (index >= 0) {
                                lines[index] = line.copy(bearing = newValue)
                            }
                        },
                        onRemove = if (lines.size > 1) {
                            {
                                val index = lines.indexOfFirst { it.id == line.id }
                                if (index >= 0) {
                                    lines.removeAt(index)
                                    lines.forEachIndexed { updatedIndex, entry ->
                                        lines[updatedIndex] = entry.copy(lineNumber = updatedIndex + 1)
                                    }
                                }
                            }
                        } else null
                    )
                }
            }

            Spacer(Modifier.height(12.dp))

            SurveyActionButton(text = "Compute Traverse", onClick = {
                val inputs = mutableListOf<TraverseLineInput>()
                for ((index, line) in lines.withIndex()) {
                    val distance = line.distance.toDoubleOrNull()
                    val bearing = line.bearing.toDoubleOrNull()
                    if (distance == null || bearing == null) {
                        errorMsg = "Please fill distance and bearing for line ${index + 1}."
                        return@SurveyActionButton
                    }
                    inputs += TraverseLineInput(distance = distance, bearingDeg = bearing)
                }

                errorMsg = null
                val analysis = analyzeTraverse(inputs)
                val ratioText = analysis.accuracyRatio?.let { "1:${formatValue(it, 3)}" } ?: "-"
                val builder = StringBuilder()
                builder.appendLine("Traverse analysis")
                builder.appendLine("Total distance: ${formatValue(analysis.totalDistance)} m")
                builder.appendLine("Sum latitude: ${formatValue(analysis.sumLatitude)} m")
                builder.appendLine("Sum departure: ${formatValue(analysis.sumDeparture)} m")
                builder.appendLine("Linear misclose: ${formatValue(analysis.linearMisclose)} m")
                builder.appendLine("Traverse accuracy: $ratioText")
                builder.appendLine()
                builder.appendLine("Per line results")
                analysis.lines.forEachIndexed { index, line ->
                    builder.appendLine("Line ${index + 1}: Lat ${formatValue(line.latitude)} m, Dep ${formatValue(line.departure)} m")
                }
                builder.appendLine()
                builder.appendLine("Bowditch correction")
                analysis.bowditchCorrections.forEachIndexed { index, correction ->
                    builder.appendLine("Line ${index + 1}: Lat ${formatValue(correction.latitude)} m, Dep ${formatValue(correction.departure)} m")
                }
                builder.appendLine()
                builder.appendLine("Transit correction")
                analysis.transitCorrections.forEachIndexed { index, correction ->
                    builder.appendLine("Line ${index + 1}: Lat ${formatValue(correction.latitude)} m, Dep ${formatValue(correction.departure)} m")
                }
                result = builder.toString().trimEnd()
            })

            if (errorMsg != null) {
                Spacer(Modifier.height(8.dp))
                SurveyInfoText(errorMsg!!)
            }

            Spacer(Modifier.height(16.dp))

            SurveyResultCard(
                title = "Result",
                message = result.ifBlank { "Add traverse lines and calculate latitudes, departures, misclose, and adjustments." },
                isEmpty = result.isBlank()
            )
        }
    }
}

@Composable
private fun TraverseLineCard(
    index: Int,
    distance: String,
    bearing: String,
    onDistanceChange: (String) -> Unit,
    onBearingChange: (String) -> Unit,
    onRemove: (() -> Unit)?
) {
    SurveyFormSection(title = "Line $index") {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            SurveyInfoText("Line ${index}")
            if (onRemove != null) {
                IconButton(onClick = onRemove) {
                    Icon(imageVector = Icons.Filled.Delete, contentDescription = "Remove line")
                }
            }
        }
        SurveyTextInput(
            value = distance,
            onValueChange = onDistanceChange,
            label = "Distance (m)",
            placeholder = "e.g. 60.123",
            helperText = "Distance used with latitude and departure"
        )
        Spacer(Modifier.height(12.dp))
        SurveyTextInput(
            value = bearing,
            onValueChange = onBearingChange,
            label = "Bearing (deg)",
            placeholder = "e.g. 30 or 100.5",
            helperText = "Whole-circle bearing in decimal degrees"
        )
    }
}

@Preview(showBackground = true)
@Composable
fun TraverseScreenPreview() {
    TraverseScreen(onBack = {})
}
