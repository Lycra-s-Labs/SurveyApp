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

    SurveyAppTheme {
        when (screen) {
            "home" -> HomeScreen { screen = it }
            "coordinate" -> CoordinateScreen { screen = "home" }
            "distance" -> DistanceScreen { screen = "home" }
            "bearing" -> BearingScreen { screen = "home" }
            "traverse" -> TraverseScreen { screen = "home" }
        }
    }
}

@Composable
fun SurveyAppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = darkColorScheme(
            primary = Color(0xFF64B5F6),
            onPrimary = Color(0xFF0B1720),
            secondary = Color(0xFF90CAF9),
            onSecondary = Color(0xFF0B1720),
            tertiary = Color(0xFF4DB6AC),
            onTertiary = Color(0xFF0B1720),
            background = Color(0xFF1B2128),
            onBackground = Color(0xFFF4F7FA),
            surface = Color(0xFF222831),
            onSurface = Color(0xFFF4F7FA),
            surfaceVariant = Color(0xFF2D353F),
            onSurfaceVariant = Color(0xFFC4CEDA),
            outline = Color(0xFF51606F),
            outlineVariant = Color(0xFF2F3944),
            error = Color(0xFFEF5350),
            onError = Color.White
        )
    ) {
        content()
    }
}

@Preview(showBackground = true)
@Composable
fun SurveyAppPreview() {
    SurveyApp()
}
