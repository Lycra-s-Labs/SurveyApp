import 'package:flutter/material.dart';
import 'src/theme/app_theme.dart';
import 'src/ui/screens/main_shell.dart';

void main() {
  runApp(const SurveyToolkitApp());
}

class SurveyToolkitApp extends StatefulWidget {
  const SurveyToolkitApp({super.key});

  @override
  State<SurveyToolkitApp> createState() => _SurveyToolkitAppState();
}

class _SurveyToolkitAppState extends State<SurveyToolkitApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _seedColor = AppTheme.accentBlue;
  bool _pureBlack = false;

  @override
  Widget build(BuildContext context) {
    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    AppTheme.configureBrightness(
      _themeMode == ThemeMode.system
          ? platformBrightness
          : (_themeMode == ThemeMode.light
                ? Brightness.light
                : Brightness.dark),
    );
    return MaterialApp(
      title: 'Survey Toolkit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeFor(_seedColor),
      darkTheme: AppTheme.darkThemeFor(
        seedColor: _seedColor,
        pureBlack: _pureBlack,
      ),
      themeMode: _themeMode,
      home: MainShell(
        themeMode: _themeMode,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
        seedColor: _seedColor,
        onSeedColorChanged: (color) => setState(() => _seedColor = color),
        pureBlack: _pureBlack,
        onPureBlackChanged: (value) => setState(() => _pureBlack = value),
      ),
    );
  }
}
