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
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun HomeScreen(onNavigate: (String) -> Unit) {
    val bg = Color(0xFF1B2128)

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(bg)
            .verticalScroll(rememberScrollState())
            .padding(horizontal = 12.dp, vertical = 12.dp)
    ) {
        Spacer(Modifier.height(32.dp))

        Text(
            text = "Survey Toolkit",
            color = Color.White,
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold
        )

        Text(
            text = "Civil engineering calculation utilities for field and office use",
            color = Color(0xFFC4CEDA),
            fontSize = 14.sp
        )

        Spacer(Modifier.height(16.dp))

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            AssistChip(
                onClick = { },
                label = { Text("Meters") },
                colors = AssistChipDefaults.assistChipColors(
                    containerColor = Color(0xFF2D353F),
                    labelColor = Color(0xFF90CAF9)
                )
            )
            AssistChip(
                onClick = { },
                label = { Text("Degrees") },
                colors = AssistChipDefaults.assistChipColors(
                    containerColor = Color(0xFF2D353F),
                    labelColor = Color(0xFF90CAF9)
                )
            )
            AssistChip(
                onClick = { },
                label = { Text("Survey") },
                colors = AssistChipDefaults.assistChipColors(
                    containerColor = Color(0xFF2D353F),
                    labelColor = Color(0xFF4DB6AC)
                )
            )
        }

        Spacer(Modifier.height(18.dp))

        Card(
            modifier = Modifier.fillMaxWidth(),
            shape = RoundedCornerShape(24.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF222831))
        ) {
            Column(modifier = Modifier.padding(18.dp)) {
                Text(
                    text = "Field-ready modules",
                    color = Color(0xFF64B5F6),
                    fontSize = 14.sp,
                    fontWeight = FontWeight.SemiBold
                )
                Spacer(Modifier.height(6.dp))
                Text(
                    text = "Choose a calculation tool. Each screen keeps formulas, units, and results easy to read.",
                    color = Color(0xFFC4CEDA),
                    fontSize = 12.sp,
                    lineHeight = 16.sp
                )
            }
        }

        Spacer(Modifier.height(18.dp))

        Text(
            text = "Quick Access",
            color = Color.White,
            fontSize = 16.sp,
            fontWeight = FontWeight.SemiBold
        )

        Spacer(Modifier.height(10.dp))

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            DashboardCard(
                title = "Coordinate",
                description = "Compute E/N from distance and bearing.",
                icon = "⌖",
                accent = Color(0xFF64B5F6),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("coordinate") }
            )

            DashboardCard(
                title = "Distance",
                description = "Measure straight-line distance between coordinates.",
                icon = "⇄",
                accent = Color(0xFF4DB6AC),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("distance") }
            )
        }

        Spacer(Modifier.height(12.dp))

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            DashboardCard(
                title = "Bearing",
                description = "Convert WCB, QB, and internal angle values.",
                icon = "◎",
                accent = Color(0xFF90CAF9),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("bearing") }
            )

            DashboardCard(
                title = "Traverse",
                description = "Latitude, departure, misclose, and adjustment.",
                icon = "▣",
                accent = Color(0xFFFFCC80),
                modifier = Modifier.weight(1f),
                onClick = { onNavigate("traverse") }
            )
        }
    }
}

@Composable
private fun DashboardCard(
    title: String,
    description: String,
    icon: String,
    accent: Color,
    modifier: Modifier = Modifier,
    onClick: () -> Unit
) {
    Card(
        modifier = modifier
            .heightIn(min = 170.dp)
            .clickable { onClick() },
        shape = RoundedCornerShape(20.dp),
        colors = CardDefaults.cardColors(containerColor = Color(0xFF222831))
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            Box(
                modifier = Modifier
                    .size(48.dp)
                    .background(Color(0xFF2D353F), RoundedCornerShape(14.dp)),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = icon,
                    color = accent,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold
                )
            }

            Spacer(Modifier.height(12.dp))

            Column {
                Text(
                    text = title,
                    color = Color.White,
                    fontSize = 18.sp,
                    lineHeight = 22.sp,
                    fontWeight = FontWeight.SemiBold
                )
                Spacer(Modifier.height(4.dp))
                Text(
                    text = description,
                    color = Color(0xFFC4CEDA),
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
