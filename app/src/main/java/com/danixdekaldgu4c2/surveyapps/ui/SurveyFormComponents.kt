package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun SurveyFormSection(
    title: String,
    modifier: Modifier = Modifier,
    content: @Composable ColumnScope.() -> Unit
) {
    SurveyCard(title = title, modifier = modifier) {
        content()
    }
}

@Composable
fun SurveyTextInput(
    value: String,
    onValueChange: (String) -> Unit,
    label: String,
    placeholder: String,
    helperText: String? = null,
    modifier: Modifier = Modifier
) {
    OutlinedTextField(
        value = value,
        onValueChange = onValueChange,
        label = { Text(label) },
        placeholder = { Text(placeholder) },
        modifier = modifier.fillMaxWidth(),
        singleLine = true,
        supportingText = helperText?.let {
            { Text(it, color = Color(0xFF6B7485)) }
        }
    )
}

@Composable
fun SurveyActionButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Button(
        onClick = onClick,
        modifier = modifier.fillMaxWidth(),
        shape = RoundedCornerShape(20.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = Color(0xFF2E6BE6),
            contentColor = Color.White
        )
    ) {
        Text(text, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
    }
}

@Composable
fun SurveyResultCard(
    title: String,
    message: String,
    isEmpty: Boolean,
    modifier: Modifier = Modifier
) {
    SurveyCard(title = title, modifier = modifier) {
        Text(
            text = message,
            color = if (isEmpty) Color(0xFF6B7485) else Color(0xFF171A20),
            fontSize = 14.sp,
            lineHeight = 20.sp
        )
    }
}

@Composable
fun SurveyInfoText(text: String) {
    Text(
        text = text,
        color = Color(0xFF5E6573),
        fontSize = 13.sp,
        lineHeight = 18.sp
    )
}

@Composable
fun SurveyChipRow(
    modifier: Modifier = Modifier,
    horizontalArrangement: Arrangement.Horizontal = Arrangement.spacedBy(8.dp),
    content: @Composable () -> Unit
) {
    Row(
        modifier = modifier.fillMaxWidth(),
        horizontalArrangement = horizontalArrangement
    ) {
        content()
    }
}

@Composable
fun SurveyAssistChip(
    selected: Boolean,
    label: String,
    selectedContainerColor: Color,
    selectedLabelColor: Color,
    onClick: () -> Unit
) {
    AssistChip(
        onClick = onClick,
        label = { Text(label) },
        colors = AssistChipDefaults.assistChipColors(
            containerColor = if (selected) selectedContainerColor else Color(0xFFF0F2F7),
            labelColor = if (selected) selectedLabelColor else Color(0xFF5E6573)
        )
    )
}

@Composable
fun SurveyBlockSpacer(heightDp: Int = 12) {
    Spacer(Modifier.height(heightDp.dp))
}
