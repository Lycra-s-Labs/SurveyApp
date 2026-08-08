import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../navigation/glass_pill_navigation.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import 'tools_screen.dart';
import 'guides_screen.dart';
import 'about_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  AppTab _currentTab = AppTab.home;
  late final PageController _pageController;

  final List<Widget> _screens = const [
    HomeScreen(),
    ToolsScreen(),
    GuidesScreen(),
    AboutScreen(),
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
      duration: 300.ms,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
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