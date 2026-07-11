package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun SurveyApp() {
    var screen by remember { mutableStateOf("home") }

    MaterialTheme(
        colorScheme = darkColorScheme(
            background = Color(0xFF2C3036),
            surface = Color(0xFF22262B)
        )
    ) {
        when (screen) {
            "home" -> HomeScreen { screen = it }
            "coordinate" -> CoordinateScreen { screen = "home" }
            "distance" -> DistanceScreen { screen = "home" }
            "bearing" -> BearingScreen { screen = "home" }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun SurveyAppPreview() {
    SurveyApp()
}