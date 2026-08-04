package com.danixdekaldgu4c2.surveyapps.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun HomeScreen(onNavigate: (String) -> Unit) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(
                Brush.verticalGradient(
                    colors = listOf(
                        Color(0xFFF8FBFF),
                        Color(0xFFF2F6FD),
                        Color(0xFFEFF3FA)
                    )
                )
            )
            .padding(14.dp)
    ) {
        Spacer(Modifier.height(16.dp))

        Text(
            text = "Survey Toolkit",
            color = Color(0xFF171A20),
            fontSize = 32.sp,
            fontWeight = FontWeight.Bold
        )

        Spacer(Modifier.height(6.dp))

        Text(
            text = "Fast field calculations for coordinates, distance, bearings, and traverse work.",
            color = Color(0xFF6B7485),
            fontSize = 14.sp,
            lineHeight = 18.sp
        )

        Spacer(Modifier.height(16.dp))

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            AssistChip(
                onClick = { },
                label = { Text("Meters") },
                colors = AssistChipDefaults.assistChipColors(
                    containerColor = Color(0xFFEAF0FD),
                    labelColor = Color(0xFF2E6BE6)
                )
            )
            AssistChip(
                onClick = { },
                label = { Text("Degrees") },
                colors = AssistChipDefaults.assistChipColors(
                    containerColor = Color(0xFFEAF8F5),
                    labelColor = Color(0xFF2BB8A6)
                )
            )
            AssistChip(
                onClick = { },
                label = { Text("Survey") },
                colors = AssistChipDefaults.assistChipColors(
                    containerColor = Color(0xFFFFF1E6),
                    labelColor = Color(0xFFF2A65A)
                )
            )
        }

        Spacer(Modifier.height(18.dp))

        SurveyCard(title = "Built for quick checks") {
            Text(
                text = "The app keeps the math in place while the interface stays clean, soft, and easy to read in the field.",
                color = Color(0xFF5E6573),
                fontSize = 13.sp,
                lineHeight = 18.sp
            )
        }

        Spacer(Modifier.height(18.dp))

        Text(
            text = "Quick Access",
            color = Color(0xFF171A20),
            fontSize = 17.sp,
            fontWeight = FontWeight.SemiBold
        )

        Spacer(Modifier.height(10.dp))

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            FeatureTile(
                title = "Coordinate",
                description = "Compute new Easting and Northing.",
                icon = "⌖",
                accent = Color(0xFF2E6BE6),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("coordinate") }
            )
            FeatureTile(
                title = "Distance",
                description = "Measure straight-line distance.",
                icon = "↔",
                accent = Color(0xFF2BB8A6),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("distance") }
            )
        }

        Spacer(Modifier.height(12.dp))

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            FeatureTile(
                title = "Bearing",
                description = "Convert and solve bearings.",
                icon = "◎",
                accent = Color(0xFFF2A65A),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("bearing") }
            )
            FeatureTile(
                title = "Traverse",
                description = "Latitude, departure, and misclose.",
                icon = "▣",
                accent = Color(0xFF6C7AE0),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("traverse") }
            )
        }

        Spacer(Modifier.height(20.dp))
    }
}

@Composable
private fun FeatureTile(
    title: String,
    description: String,
    icon: String,
    accent: Color,
    modifier: Modifier = Modifier,
    onClick: () -> Unit
) {
    Card(
        modifier = modifier
            .heightIn(min = 168.dp)
            .clickable { onClick() },
        shape = RoundedCornerShape(28.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            Box(
                modifier = Modifier
                    .size(48.dp)
                    .background(accent.copy(alpha = 0.12f), RoundedCornerShape(16.dp)),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = icon,
                    color = accent,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold
                )
            }

            Column {
                Text(
                    text = title,
                    color = Color(0xFF171A20),
                    fontSize = 18.sp,
                    fontWeight = FontWeight.SemiBold
                )
                Spacer(Modifier.height(4.dp))
                Text(
                    text = description,
                    color = Color(0xFF6B7485),
                    fontSize = 12.sp,
                    lineHeight = 16.sp
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun HomeScreenPreview() {
    SurveyAppTheme {
        HomeScreen(onNavigate = {})
    }
}
