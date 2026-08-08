import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/common_widgets.dart';
import '../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.accentBlue, AppTheme.accentTeal],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.dashboard, color: Colors.white, size: 26),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Survey Toolkit',
                                style: TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                'Civil engineering field calculations',
                                style: TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: AppTheme.glassCard(radius: 14, borderColor: AppTheme.accentBlue.withValues(alpha: 0.3)),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: AppTheme.accentBlue, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Quick access to traverse, coordinate, bearing, and distance calculations',
                              style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: SectionHeader(
                  title: 'Quick Tools',
                  subtitle: 'Most used calculations for field work',
                  icon: Icons.flash_on,
                  accentColor: AppTheme.accentAmber,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildListDelegate([
                  _QuickToolCard(
                    title: 'Traverse',
                    subtitle: 'Lat/Dep, Misclose, Adjustment',
                    icon: Icons.navigation,
                    color: AppTheme.accentAmber,
                    onTap: () {},
                  ),
                  _QuickToolCard(
                    title: 'Coordinate',
                    subtitle: 'Bearing + Distance → E/N',
                    icon: Icons.place,
                    color: AppTheme.accentBlue,
                    onTap: () {},
                  ),
                  _QuickToolCard(
                    title: 'Distance',
                    subtitle: 'Between two coordinates',
                    icon: Icons.straighten,
                    color: AppTheme.accentTeal,
                    onTap: () {},
                  ),
                  _QuickToolCard(
                    title: 'Bearing',
                    subtitle: 'WCB, Quadrant, Internal',
                    icon: Icons.explore,
                    color: AppTheme.accentPurple,
                    onTap: () {},
                  ),
                ]),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: SectionHeader(
                  title: 'Advanced Tools',
                  subtitle: 'Area, Intersection, Resection & more',
                  icon: Icons.memory,
                  accentColor: AppTheme.accentPurple,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildListDelegate([
                  _QuickToolCard(
                    title: 'Area by Coords',
                    subtitle: 'Polygon area computation',
                    icon: Icons.crop_square,
                    color: AppTheme.accentTeal,
                    onTap: () {},
                  ),
                  _QuickToolCard(
                    title: 'Intersection',
                    subtitle: 'Bearing-bearing intersection',
                    icon: Icons.merge_type,
                    color: AppTheme.accentBlue,
                    onTap: () {},
                  ),
                  _QuickToolCard(
                    title: 'Resection',
                    subtitle: 'Three-point resection',
                    icon: Icons.adjust,
                    color: AppTheme.accentPurple,
                    onTap: () {},
                  ),
                  _QuickToolCard(
                    title: 'Leveling',
                    subtitle: 'Survey leveling calc',
                    icon: Icons.height,
                    color: AppTheme.accentAmber,
                    onTap: () {},
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.glassCard(radius: 18, borderColor: color.withValues(alpha: 0.3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 11,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1);
  }
}
