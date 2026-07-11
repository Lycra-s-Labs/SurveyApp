package com.danixdekaldgu4c2.surveyapps

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.danixdekaldgu4c2.surveyapps.ui.SurveyApp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            SurveyApp()
        }
    }
}