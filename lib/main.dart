import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/theme/app_theme.dart';
import 'src/ui/screens/main_shell.dart';

void main() {
  runApp(const GeoCApp());
}

class GeoCApp extends StatefulWidget {
  const GeoCApp({super.key});

  @override
  State<GeoCApp> createState() => _GeoCAppState();
}

class _GeoCAppState extends State<GeoCApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _seedColor = AppTheme.accentBlue;
  bool _pureBlack = false;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    final savedMode = preferences.getString('themeMode');
    if (!mounted || savedMode == null) return;
    setState(() {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.name == savedMode,
        orElse: () => ThemeMode.system,
      );
    });
  }

  Future<void> _setThemeMode(ThemeMode mode) async {
    setState(() => _themeMode = mode);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('themeMode', mode.name);
  }

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
      title: 'Geo.C',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeFor(_seedColor),
      darkTheme: AppTheme.darkThemeFor(
        seedColor: _seedColor,
        pureBlack: _pureBlack,
      ),
      themeMode: _themeMode,
      home: MainShell(
        themeMode: _themeMode,
        onThemeModeChanged: _setThemeMode,
        seedColor: _seedColor,
        onSeedColorChanged: (color) => setState(() => _seedColor = color),
        pureBlack: _pureBlack,
        onPureBlackChanged: (value) => setState(() => _pureBlack = value),
      ),
    );
  }
}
