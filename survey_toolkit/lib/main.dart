import 'package:flutter/material.dart';
import 'src/theme/app_theme.dart';
import 'src/ui/screens/main_shell.dart';

void main() {
  runApp(const SurveyToolkitApp());
}

class SurveyToolkitApp extends StatelessWidget {
  const SurveyToolkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey Toolkit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainShell(),
    );
  }
}