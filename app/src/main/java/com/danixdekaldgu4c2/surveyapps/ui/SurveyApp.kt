package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun SurveyApp() {
    val backStack = remember { mutableStateListOf("home") }
    val currentScreen = backStack.lastOrNull() ?: "home"

    SurveyAppTheme {
        when (currentScreen) {
            "home" -> HomeScreen { destination ->
                backStack.add(destination)
            }
            "coordinate" -> CoordinateScreen {
                if (backStack.size > 1) backStack.removeAt(backStack.lastIndex)
            }
            "distance" -> DistanceScreen {
                if (backStack.size > 1) backStack.removeAt(backStack.lastIndex)
            }
            "bearing" -> BearingScreen {
                if (backStack.size > 1) backStack.removeAt(backStack.lastIndex)
            }
            "traverse" -> TraverseScreen {
                if (backStack.size > 1) backStack.removeAt(backStack.lastIndex)
            }
        }
    }
}

@Composable
fun SurveyAppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = lightColorScheme(
            primary = Color(0xFF2E6BE6),
            onPrimary = Color.White,
            secondary = Color(0xFF2BB8A6),
            onSecondary = Color.White,
            tertiary = Color(0xFFF2A65A),
            onTertiary = Color(0xFF1D1D1D),
            background = Color(0xFFF3F5FA),
            onBackground = Color(0xFF15171C),
            surface = Color.White,
            onSurface = Color(0xFF15171C),
            surfaceVariant = Color(0xFFE8ECF5),
            onSurfaceVariant = Color(0xFF5E6573),
            outline = Color(0xFFC9D1E1),
            outlineVariant = Color(0xFFE2E7F0),
            error = Color(0xFFCD3D3D),
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
