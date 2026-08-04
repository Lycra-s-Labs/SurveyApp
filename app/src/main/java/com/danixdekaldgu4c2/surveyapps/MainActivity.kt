package com.danixdekaldgu4c2.surveyapps

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.danixdekaldgu4c2.surveyapps.ui.CrashDebugScreen
import com.danixdekaldgu4c2.surveyapps.ui.clearLastCrash
import com.danixdekaldgu4c2.surveyapps.ui.readLastCrash
import com.danixdekaldgu4c2.surveyapps.ui.installCrashDebug
import com.danixdekaldgu4c2.surveyapps.ui.SurveyApp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        installCrashDebug(applicationContext)
        val lastCrash = readLastCrash(applicationContext)

        if (lastCrash != null) {
            setContent {
                CrashDebugScreen(
                    crashText = lastCrash,
                    onRetry = {
                        clearLastCrash(applicationContext)
                        recreate()
                    }
                )
            }
            return
        }

        try {
            setContent {
                SurveyApp()
            }
        } catch (throwable: Throwable) {
            setContent {
                CrashDebugScreen(
                    crashText = throwable.stackTraceToString(),
                    onRetry = {
                        clearLastCrash(applicationContext)
                        recreate()
                    }
                )
            }
        }
    }
}
