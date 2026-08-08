import 'package:flutter/material.dart';

import 'tools_screen.dart';

/// Dashboard now serves as the main entry point for every calculation tool.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalculationToolsView();
  }
}
