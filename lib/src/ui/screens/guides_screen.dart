import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../icons/lucide_icons.dart';
import '../widgets/common_widgets.dart';
import '../../theme/app_theme.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guides = [
      _GuideCategory(
        title: 'Getting Started',
        icon: Icons.menu_book,
        color: AppTheme.accentBlue,
        items: [
          _GuideItem(
            'Introduction to Survey Toolkit',
            'Overview of the app, navigation, and basic concepts for civil engineering students.',
            Icons.info,
            'beginner',
          ),
          _GuideItem(
            'Units & Coordinate Systems',
            'Understanding meters, degrees, WCB, quadrant bearings, and local coordinate systems.',
            Icons.straighten,
            'beginner',
          ),
          _GuideItem(
            'Field Data Entry Best Practices',
            'Tips for accurate field measurements and data recording.',
            LucideIcons.clipboard,
            'beginner',
          ),
        ],
      ),
      _GuideCategory(
        title: 'Traverse Calculations',
        icon: Icons.navigation,
        color: AppTheme.accentAmber,
        items: [
          _GuideItem(
            'Traverse Fundamentals',
            'Latitude, departure, linear misclose, and accuracy ratio explained.',
            Icons.change_history,
            'beginner',
          ),
          _GuideItem(
            'Bowditch (Compass) Rule',
            'Proportional correction method based on line lengths.',
            Icons.explore,
            'intermediate',
          ),
          _GuideItem(
            'Transit Rule',
            'Correction based on latitude/departure proportions.',
            Icons.swap_vert,
            'intermediate',
          ),
          _GuideItem(
            'Closed vs Open Traverse',
            'When to use each type and how to check closure.',
            Icons.swap_horiz,
            'intermediate',
          ),
        ],
      ),
      _GuideCategory(
        title: 'Coordinate Geometry',
        icon: Icons.place,
        color: AppTheme.accentTeal,
        items: [
          _GuideItem(
            'Forward Computation',
            'Calculating new coordinates from known point, bearing, and distance.',
            LucideIcons.arrowRight,
            'beginner',
          ),
          _GuideItem(
            'Inverse Computation',
            'Finding bearing and distance between two known coordinates.',
            LucideIcons.arrowLeftRight,
            'beginner',
          ),
          _GuideItem(
            'Area by Coordinates',
            'Shoelace formula for polygon area calculation.',
            Icons.crop_square,
            'intermediate',
          ),
          _GuideItem(
            '2 Missing Lines Solution',
            'Solving traverse with two unknown sides.',
            Icons.swap_horiz,
            'advanced',
          ),
        ],
      ),
      _GuideCategory(
        title: 'Bearing & Angle Operations',
        icon: Icons.explore,
        color: AppTheme.accentBlue,
        items: [
          _GuideItem(
            'Whole Circle Bearing (WCB)',
            '0°-360° clockwise from North - the standard in surveying.',
            Icons.circle,
            'beginner',
          ),
          _GuideItem(
            'Quadrant Bearing (QB)',
            'N/S angle E/W format - converting to/from WCB.',
            Icons.navigation,
            'beginner',
          ),
          _GuideItem(
            'Internal Angles',
            'Calculating angles between traverse lines from bearings.',
            Icons.change_history,
            'intermediate',
          ),
        ],
      ),
      _GuideCategory(
        title: 'Advanced Surveying',
        icon: Icons.adjust,
        color: AppTheme.accentPurple,
        items: [
          _GuideItem(
            'Intersection (Bearing-Bearing)',
            'Finding a point from two known points with measured bearings.',
            Icons.merge_type,
            'intermediate',
          ),
          _GuideItem(
            'Resection (Three-Point)',
            'Determining instrument position from three known points.',
            Icons.adjust,
            'advanced',
          ),
          _GuideItem(
            'Center of Circle from 3 Points',
            'Curve fitting for circular alignments.',
            Icons.circle,
            'intermediate',
          ),
          _GuideItem(
            'Secant Offsets for Curves',
            'Equal and non-equal width offset calculations.',
            Icons.remove,
            'advanced',
          ),
        ],
      ),
      _GuideCategory(
        title: 'Leveling & Vertical Control',
        icon: Icons.height,
        color: AppTheme.successColor,
        items: [
          _GuideItem(
            'Differential Leveling',
            'HI method, rise/fall method, and booking formats.',
            Icons.swap_vert,
            'beginner',
          ),
          _GuideItem(
            'Error Sources & Adjustments',
            'Collimation error, curvature & refraction, loop closure.',
            Icons.warning,
            'intermediate',
          ),
        ],
      ),
    ];

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
                                AppTheme.accentTeal,
                                AppTheme.accentBlue,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.menu_book,
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
                                'Guides & Tutorials',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                'Learn each tool with step-by-step guides',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  final category = guides[index];
                  return _GuideCategoryWidget(category: category)
                      .animate()
                      .fadeIn(duration: 400.ms, delay: (80 * index).ms)
                      .slideY(begin: 0.2);
                }, childCount: guides.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuideItem {
  final String title;
  final String description;
  final IconData icon;
  final String level;

  const _GuideItem(this.title, this.description, this.icon, this.level);
}

class _GuideCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<_GuideItem> items;

  const _GuideCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class _GuideCategoryWidget extends StatelessWidget {
  final _GuideCategory category;

  const _GuideCategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: category.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(category.icon, color: category.color, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                category.title,
                style: TextStyle(
                  color: category.color,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: category.items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == category.items.length - 1 ? 0 : 8,
              ),
              child: _GuideCard(item: item, accentColor: category.color),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  final _GuideItem item;
  final Color accentColor;

  const _GuideCard({required this.item, required this.accentColor});

  Color _levelColor(String level) {
    switch (level) {
      case 'beginner':
        return AppTheme.successColor;
      case 'intermediate':
        return AppTheme.warningColor;
      case 'advanced':
        return AppTheme.errorColor;
      default:
        return AppTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelColor = _levelColor(item.level);
    return GlassCard(
      onTap: () => _showGuideDetail(context),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: accentColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: levelColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: levelColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        item.level.toUpperCase(),
                        style: TextStyle(
                          color: levelColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ],
      ),
    );
  }

  void _showGuideDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          _GuideDetailSheet(item: item, accentColor: accentColor),
    );
  }
}

class _GuideDetailSheet extends StatelessWidget {
  final _GuideItem item;
  final Color accentColor;

  const _GuideDetailSheet({required this.item, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.textMuted.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(item.icon, color: accentColor, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: _levelColor(
                                  item.level,
                                ).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item.level.toUpperCase(),
                                style: TextStyle(
                                  color: _levelColor(item.level),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Text(
                      _getGuideContent(item.title),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'beginner':
        return AppTheme.successColor;
      case 'intermediate':
        return AppTheme.warningColor;
      case 'advanced':
        return AppTheme.errorColor;
      default:
        return AppTheme.textMuted;
    }
  }

  String _getGuideContent(String title) {
    const guides = {
      'Introduction to Survey Toolkit':
          'Survey Toolkit is a comprehensive calculation app designed for civil engineering students and field surveyors. '
          'The app provides 15+ essential surveying calculations organized into intuitive categories.\n\n'
          'Navigation: Use the glass pill at the bottom to switch between Dashboard (quick access), Tools (all calculations), '
          'Guides (this section), and About (app info).\n\n'
          'Each tool includes input validation, clear result display, and reference formulas. '
          'Results can be copied or shared for field notes.',

      'Units & Coordinate Systems':
          'All calculations use metric units (meters) and decimal degrees by default.\n\n'
          'Coordinate System: Local planar coordinates (Easting, Northing) are used. '
          'Eastings increase to the East, Northings increase to the North.\n\n'
          'Bearing Formats:\n'
          '• Whole Circle Bearing (WCB): 0° to 360° measured clockwise from North\n'
          '• Quadrant Bearing (QB): N/S [angle]° E/W (e.g., N 45° E, S 30° W)\n\n'
          'Angle Units: Decimal degrees (e.g., 45.5°) not DMS.',

      'Field Data Entry Best Practices':
          '1. Record measurements immediately in field book\n'
          '2. Double-check bearing readings (face left/face right)\n'
          '3. Use consistent decimal places (3 for distance, 2 for angles)\n'
          '4. Sketch traverse with approximate dimensions\n'
          '5. Note weather, instrument height, and target height\n'
          '6. Perform arithmetic checks before leaving site\n\n'
          'In the app: Enter values carefully, use the clear button to reset, '
          'and verify results match field expectations.',

      'Traverse Fundamentals':
          'A traverse is a series of connected lines whose lengths and directions are measured.\n\n'
          'Key Terms:\n'
          '• Latitude = Distance × cos(Bearing) — North-South component\n'
          '• Departure = Distance × sin(Bearing) — East-West component\n'
          '• Linear Misclose = √(ΣLat² + ΣDep²) — closure error\n'
          '• Accuracy Ratio = Total Distance / Linear Misclose\n\n'
          'For a closed traverse, ΣLat and ΣDep should equal zero. '
          'The misclose indicates measurement quality.',

      'Bowditch (Compass) Rule':
          'Distributes closure error proportionally to line lengths.\n\n'
          'Correction for each line:\n'
          '• ΔLat = -ΣLat × (Line Distance / Total Distance)\n'
          '• ΔDep = -ΣDep × (Line Distance / Total Distance)\n\n'
          'Best for: Traverses with roughly equal precision in angles and distances. '
          'Most commonly used adjustment method.',

      'Transit Rule':
          'Distributes closure error proportionally to latitude/departure magnitudes.\n\n'
          'Correction for each line:\n'
          '• ΔLat = -ΣLat × (|Lat| / Σ|Lat|)\n'
          '• ΔDep = -ΣDep × (|Dep| / Σ|Dep|)\n\n'
          'Best for: Traverses where angular measurements are more precise than distances.',

      'Closed vs Open Traverse':
          'Closed Traverse: Returns to starting point or closes on known point. '
          'Allows misclose calculation and adjustment.\n\n'
          'Open Traverse: Does not return to known point. '
          'No geometric closure check possible — rely on procedural checks.\n\n'
          'Always prefer closed traverses for control surveys.',

      'Forward Computation':
          'Given: Known point (E₀, N₀), Distance (d), Bearing (θ)\n'
          'Find: New point (E₁, N₁)\n\n'
          'Formulas:\n'
          '• Lat = d × cos(θ)\n'
          '• Dep = d × sin(θ)\n'
          '• E₁ = E₀ + Dep\n'
          '• N₁ = N₀ + Lat\n\n'
          'Bearing must be in Whole Circle Bearing format (0-360°).',

      'Inverse Computation':
          'Given: Two known points (E₁, N₁) and (E₂, N₂)\n'
          'Find: Distance and Bearing from point 1 to point 2\n\n'
          'Formulas:\n'
          '• ΔE = E₂ - E₁\n'
          '• ΔN = N₂ - N₁\n'
          '• Distance = √(ΔE² + ΔN²)\n'
          '• Bearing = atan2(ΔE, ΔN) converted to 0-360°\n\n'
          'Use atan2 for correct quadrant determination.',

      'Area by Coordinates':
          'Shoelace formula for polygon area:\n\n'
          'Area = ½ | Σ(Eᵢ × Nᵢ₊₁ - Eᵢ₊₁ × Nᵢ) |\n\n'
          'Vertices must be ordered sequentially (clockwise or counterclockwise). '
          'The formula works for any simple polygon.\n\n'
          'Result is in square meters. For hectares, divide by 10,000.',

      '2 Missing Lines Solution':
          'When two traverse lines are unknown but all other data is known:\n\n'
          '1. Compute coordinates through known lines to get closure point\n'
          '2. The missing lines form a triangle with known baseline\n'
          '3. Solve using sine rule or coordinate geometry\n\n'
          'Two solutions may exist (ambiguous case). Field context determines correct one.',

      'Whole Circle Bearing (WCB)':
          'Standard bearing format in surveying:\n\n'
          '• Measured clockwise from True/Magnetic/Grid North\n'
          '• Range: 0° to 360°\n'
          '• N = 0°/360°, E = 90°, S = 180°, W = 270°\n\n'
          'Advantages: Unambiguous, simple trigonometry, standard for computations.',

      'Quadrant Bearing (QB)':
          'Traditional format: N/S [angle]° E/W\n\n'
          'Examples:\n'
          '• N 45° E = 45° WCB\n'
          '• S 30° E = 150° WCB\n'
          '• S 60° W = 240° WCB\n'
          '• N 15° W = 345° WCB\n\n'
          'Angle always < 90°. Prefix = N/S (latitude direction), Suffix = E/W (departure direction).',

      'Internal Angles':
          'Angle between two successive traverse lines.\n\n'
          'From bearings: Internal Angle = |Bearing₂ - Bearing₁| (use smaller angle)\n'
          'If difference > 180°, use 360° - difference.\n\n'
          'Sum of internal angles in n-sided polygon = (n-2) × 180°.',

      'Intersection (Bearing-Bearing)':
          'Locate unknown point P from two known points A and B:\n\n'
          '1. Measure bearing from A to P (θ₁)\n'
          '2. Measure bearing from B to P (θ₂)\n'
          '3. Solve intersection of two rays\n\n'
          'Formulas (using coordinate geometry):\n'
          'tan(θ) = ΔE / ΔN for each ray\n'
          'Solve simultaneous equations for P(E, N)\n\n'
          'Check: Angle at P between rays should be > 30° for good geometry.',

      'Resection (Three-Point)':
          'Determine instrument position from 3 known points:\n\n'
          '1. Set up at unknown point P\n'
          '2. Observe horizontal angles to 3 known points A, B, C\n'
          '3. Solve for P coordinates\n\n'
          'Methods: Cassini, Tienstra, or iterative least squares.\n'
          'Best geometry: P inside triangle ABC, angles ~60° each.\n'
          'Avoid: P on circle through A, B, C (danger circle — infinite solutions).',

      'Center of Circle from 3 Points':
          'Given 3 points on a circle, find center and radius:\n\n'
          '1. Find perpendicular bisectors of two chords\n'
          '2. Intersection of bisectors = circle center\n'
          '3. Radius = distance from center to any point\n\n'
          'Used for: Horizontal curve design, checking circular alignments.',

      'Secant Offsets for Curves':
          'Offsets from long chord to circular curve:\n\n'
          'Equal Width: Constant interval along chord\n'
          'Offset y = R - √(R² - x²) where x = distance from mid-point\n\n'
          'Non-Equal Width: Variable intervals for specific stations\n\n'
          'Used for: Setting out circular curves, road/rail alignment.',

      'Differential Leveling':
          'Height difference between points using level instrument:\n\n'
          'HI Method:\n'
          '• HI = BM Elevation + Backsight\n'
          '• Point Elevation = HI - Foresight\n\n'
          'Rise/Fall Method:\n'
          '• Rise = BS - FS (if positive)\n'
          '• Fall = FS - BS (if positive)\n'
          '• Elevation = Previous Elevation + Rise - Fall\n\n'
          'Booking: BS, IS, FS, Rise, Fall, RL, Remarks columns.',

      'Error Sources & Adjustments':
          'Common Leveling Errors:\n\n'
          '1. Collimation Error: Line of sight not horizontal\n'
          '   → Eliminate by equal BS/FS distances (balancing sights)\n\n'
          '2. Curvature & Refraction:\n'
          '   • Curvature: Earth curves away (~-0.0785 × d² km)\n'
          '   • Refraction: Light bends downward (~+0.0112 × d² km)\n'
          '   • Combined: ~-0.0673 × d² (d in km)\n\n'
          '3. Loop Closure: Distribute error proportionally to distance or setups.',
    };

    return guides[title] ??
        'Guide content coming soon. This tool helps with ${item.description.toLowerCase()}.';
  }
}
