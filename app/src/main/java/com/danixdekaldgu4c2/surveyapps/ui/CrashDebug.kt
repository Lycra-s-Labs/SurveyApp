package com.danixdekaldgu4c2.surveyapps.ui

import android.content.Context
import android.util.Log
import com.danixdekaldgu4c2.surveyapps.BuildConfig
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import java.io.File
import java.io.PrintWriter
import java.io.StringWriter

private const val TAG = "CrashDebug"
private const val CRASH_FILE_NAME = "last_crash_debug.txt"

fun installCrashDebug(context: Context) {
    if (!BuildConfig.DEBUG) return

    val previousHandler = Thread.getDefaultUncaughtExceptionHandler()
    Thread.setDefaultUncaughtExceptionHandler { thread, throwable ->
        try {
            val text = buildCrashText(thread.name, throwable)
            Log.e(TAG, text, throwable)
            context.openFileOutput(CRASH_FILE_NAME, Context.MODE_PRIVATE).use { stream ->
                stream.write(text.toByteArray())
            }
        } catch (_: Throwable) {
            // Keep crash handling best-effort only.
        } finally {
            previousHandler?.uncaughtException(thread, throwable)
        }
    }
}

@Composable
fun CrashDebugScreen(
    crashText: String,
    onRetry: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        Text(
            text = "Crash Debug",
            color = Color(0xFF171A20),
            fontWeight = FontWeight.Bold
        )
        Spacer(Modifier.height(8.dp))
        Text(
            text = "The UI hit an exception while rendering. This debug view keeps the app usable for inspection.",
            color = Color(0xFF5E6573)
        )

        Spacer(Modifier.height(12.dp))

        Card(
            colors = CardDefaults.cardColors(containerColor = Color.White),
            elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
        ) {
            Text(
                text = crashText,
                modifier = Modifier.padding(16.dp),
                color = Color(0xFFCD3D3D)
            )
        }

        Spacer(Modifier.height(12.dp))

        Button(onClick = onRetry) {
            Text("Retry")
        }
    }
}

private fun buildCrashText(source: String, throwable: Throwable): String {
    val writer = StringWriter()
    throwable.printStackTrace(PrintWriter(writer))
    return buildString {
        appendLine("Source: $source")
        appendLine("Exception: ${throwable::class.java.name}")
        appendLine("Message: ${throwable.message ?: "(none)"}")
        appendLine()
        append(writer.toString())
    }.trimEnd()
}

fun readLastCrash(context: Context): String? {
    if (!BuildConfig.DEBUG) return null
    val file = File(context.filesDir, CRASH_FILE_NAME)
    return if (file.exists()) file.readText() else null
}

fun clearLastCrash(context: Context) {
    if (!BuildConfig.DEBUG) return
    File(context.filesDir, CRASH_FILE_NAME).delete()
}
