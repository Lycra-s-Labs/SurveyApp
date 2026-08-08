import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';

enum AppTab { home, tools, guides, about }

class GlassPillNavigation extends StatelessWidget {
  final AppTab currentTab;
  final ValueChanged<AppTab> onTabChanged;

  const GlassPillNavigation({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _TabItem(tab: AppTab.home, icon: Icons.dashboard, label: 'Dashboard'),
      _TabItem(tab: AppTab.tools, icon: Icons.build, label: 'Tools'),
      _TabItem(tab: AppTab.guides, icon: Icons.menu_book, label: 'Guides'),
      _TabItem(tab: AppTab.about, icon: Icons.info, label: 'About'),
    ];

    return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: AppTheme.glassPill(radius: 32),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: tabs.asMap().entries.map((entry) {
              final item = entry.value;
              final isSelected = currentTab == item.tab;

              return Expanded(
                child: AnimatedContainer(
                  duration: 300.ms,
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(26),
                    child: InkWell(
                      onTap: () => onTabChanged(item.tab),
                      borderRadius: BorderRadius.circular(26),
                      child: AnimatedContainer(
                        duration: 300.ms,
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 8,
                        ),
                        decoration: isSelected
                            ? AppTheme.glassPillSelected(radius: 26)
                            : null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item.icon,
                              size: 20,
                              color: isSelected
                                  ? AppTheme.accentBlue
                                  : AppTheme.textMuted,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? AppTheme.accentBlue
                                    : AppTheme.textMuted,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.3, curve: Curves.easeOutCubic);
  }
}

class _TabItem {
  final AppTab tab;
  final IconData icon;
  final String label;

  const _TabItem({required this.tab, required this.icon, required this.label});
}

class GlassPillNavigationBar extends StatelessWidget {
  final AppTab currentTab;
  final ValueChanged<AppTab> onTabChanged;

  const GlassPillNavigationBar({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Center(
          child: GlassPillNavigation(
            currentTab: currentTab,
            onTabChanged: onTabChanged,
          ),
        ),
      ),
    );
  }
}
