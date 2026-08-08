import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../icons/lucide_icons.dart';
import '../widgets/common_widgets.dart';
import '../../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                              colors: [
                                AppTheme.accentPurple,
                                AppTheme.accentBlue,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About',
                                style: TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                'Survey Toolkit v1.0.0',
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
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildAppInfoCard()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.2),
                  const SizedBox(height: 20),
                  _buildTechStack()
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 200.ms)
                      .slideY(begin: 0.2),
                  const SizedBox(height: 20),
                  _buildCredits()
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 300.ms)
                      .slideY(begin: 0.2),
                  const SizedBox(height: 20),
                  _buildLegal()
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 400.ms)
                      .slideY(begin: 0.2),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfoCard() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.accentBlue, AppTheme.accentPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentBlue.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.dashboard, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            'Survey Toolkit',
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Civil Engineering Field Calculator',
            style: TextStyle(
              color: AppTheme.accentBlue,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'A comprehensive surveying calculation app designed for civil engineering students '
            'and field professionals. Built to handle traverse computations, coordinate geometry, '
            'bearing conversions, intersection/resection, area calculations, and leveling — '
            'all with a modern, field-ready interface.',
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatChip('15+', 'Tools'),
              const SizedBox(width: 12),
              _buildStatChip('11', 'Categories'),
              const SizedBox(width: 12),
              _buildStatChip('Offline', 'Ready'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Retained as a reference for the feature descriptions; the About layout no
  // longer renders this section.
  // ignore: unused_element
  Widget _buildFeatureList() {
    final features = [
      (
        'Traverse & Adjustment',
        'Lat/Dep, misclose, Bowditch & Transit corrections',
        Icons.navigation,
        AppTheme.accentAmber,
      ),
      (
        'Coordinate Geometry',
        'Forward/inverse computation, 2 missing lines',
        Icons.place,
        AppTheme.accentBlue,
      ),
      (
        'Bearing Operations',
        'WCB ↔ Quadrant, internal angles, bearing from known',
        Icons.explore,
        AppTheme.accentTeal,
      ),
      (
        'Area & Centroid',
        'Polygon area by coordinates, center point',
        Icons.crop_square,
        AppTheme.accentPurple,
      ),
      (
        'Intersection/Resection',
        'Bearing-bearing intersection, 3-point resection',
        Icons.adjust,
        AppTheme.accentPurple,
      ),
      (
        'Curve Offsets',
        'Secants equal/non-equal width for circular curves',
        Icons.swap_horiz,
        AppTheme.accentBlue,
      ),
      (
        'Leveling Survey',
        'HI method, elevation computation',
        Icons.height,
        AppTheme.successColor,
      ),
      (
        'Circle Geometry',
        'Center and radius from 3 points',
        Icons.circle,
        AppTheme.accentTeal,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Tools',
          style: TextStyle(
            color: AppTheme.accentBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: features.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final (title, desc, icon, color) = features[index];
            return GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icon, color: color, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              desc,
                              style: const TextStyle(
                                color: AppTheme.textMuted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.successColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          LucideIcons.check,
                          color: AppTheme.successColor,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms, delay: (50 * index).ms)
                .slideX(begin: 0.1);
          },
        ),
      ],
    );
  }

  Widget _buildTechStack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Built With',
          style: TextStyle(
            color: AppTheme.accentBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _TechItem(
                'Flutter 3.x',
                'Cross-platform UI framework',
                Icons.smartphone,
                AppTheme.accentBlue,
              ),
              _TechItem(
                'Dart',
                'Type-safe programming language',
                Icons.code,
                AppTheme.accentTeal,
              ),
              _TechItem(
                'Material 3',
                'Modern design system',
                Icons.palette,
                AppTheme.accentPurple,
              ),
              _TechItem(
                'Material Icons',
                'Built-in Flutter icon set',
                Icons.image,
                AppTheme.accentAmber,
              ),
              _TechItem(
                'Google Fonts (Inter)',
                'Clean, readable typography',
                Icons.font_download,
                AppTheme.successColor,
              ),
              _TechItem(
                'Flutter Animate',
                'Declarative animations',
                Icons.flash_on,
                AppTheme.warningColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCredits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Credits & References',
          style: TextStyle(
            color: AppTheme.accentBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CreditItem(
                'Surveying Formulas',
                'Based on standard civil engineering surveying textbooks and field manuals',
                Icons.book,
              ),
              _CreditItem(
                'Material Icons',
                'Built into Flutter through the Material icon font',
                Icons.code,
                url: 'https://fonts.google.com/icons',
              ),
              _CreditItem(
                'Google Fonts - Inter',
                'SIL Open Font License by Rasmus Andersson',
                Icons.font_download,
                url: 'https://fonts.google.com/specimen/Inter',
              ),
              _CreditItem(
                'Flutter Team',
                'Framework and tooling by Google and contributors',
                Icons.favorite,
                url: 'https://flutter.dev',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legal',
          style: TextStyle(
            color: AppTheme.accentBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LegalItem(
                'Privacy Policy',
                'No personal data collected. All calculations performed locally on device.',
                Icons.shield,
              ),
              _LegalItem(
                'Open Source Licenses',
                'View licenses for all third-party packages used in this app.',
                Icons.description,
              ),
              _LegalItem(
                'Disclaimer',
                'This app is for educational and reference purposes. Always verify critical calculations independently.',
                Icons.warning,
              ),
              _LegalItem(
                'Version',
                '1.0.0+1 — Built for civil engineering students',
                Icons.label,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TechItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _TechItem(this.title, this.subtitle, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? url;

  const _CreditItem(this.title, this.description, this.icon, {this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.accentBlue, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (url != null)
            IconButton(
              icon: Icon(
                Icons.open_in_new,
                color: AppTheme.textMuted,
                size: 16,
              ),
              onPressed: () {},
              tooltip: 'Open link',
            ),
        ],
      ),
    );
  }
}

class _LegalItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _LegalItem(this.title, this.description, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.textMuted, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
