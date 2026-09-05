import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../navigation/glass_pill_navigation.dart';
import 'home_screen.dart';
import 'tools_screen.dart';
import 'guides_screen.dart';
import 'about_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final Color seedColor;
  final ValueChanged<Color> onSeedColorChanged;
  final bool pureBlack;
  final ValueChanged<bool> onPureBlackChanged;

  const MainShell({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.seedColor,
    required this.onSeedColorChanged,
    required this.pureBlack,
    required this.onPureBlackChanged,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  AppTab _currentTab = AppTab.home;
  late final PageController _pageController;

  List<Widget> get _screens => [
    const HomeScreen(),
    const ToolsScreen(),
    const GuidesScreen(),
    SettingsScreen(
      themeMode: widget.themeMode,
      onThemeModeChanged: widget.onThemeModeChanged,
      seedColor: widget.seedColor,
      onSeedColorChanged: widget.onSeedColorChanged,
      pureBlack: widget.pureBlack,
      onPureBlackChanged: widget.onPureBlackChanged,
    ),
    const AboutScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(AppTab tab) {
    setState(() => _currentTab = tab);
    _pageController.animateToPage(
      AppTab.values.indexOf(tab),
      duration: 700.ms,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GlassPillNavigationBar(
              currentTab: _currentTab,
              onTabChanged: _onTabChanged,
            ),
          ),
        ],
      ),
    );
  }
}
