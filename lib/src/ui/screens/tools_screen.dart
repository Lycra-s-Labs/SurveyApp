import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../icons/lucide_icons.dart';
import '../widgets/common_widgets.dart';
import '../../calc/survey_math.dart';
import '../../theme/app_theme.dart';

class CalculationToolsView extends StatelessWidget {
  const CalculationToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      _ToolCategory(
        title: 'Traverse & Coordinates',
        icon: Icons.navigation,
        color: AppTheme.accentAmber,
        tools: [
          _ToolInfo(
            'Traverse Calculation',
            'Lat/Dep, misclose, Bowditch & Transit adjustment',
            Icons.navigation,
          ),
          _ToolInfo(
            'Bearing + Distance → Coordinate',
            'Forward computation (E/N from angle & dist)',
            Icons.place,
          ),
          _ToolInfo(
            'Coordinate → Bearing + Distance',
            'Inverse computation between two points',
            Icons.straighten,
          ),
          _ToolInfo(
            '2 Missing Lines',
            'Solve missing traverse lines',
            Icons.swap_horiz,
          ),
        ],
      ),
      _ToolCategory(
        title: 'Bearing & Angle',
        icon: Icons.explore,
        color: AppTheme.accentBlue,
        tools: [
          _ToolInfo(
            'WCB ↔ Quadrant Bearing',
            'Convert between bearing formats',
            Icons.explore,
          ),
          _ToolInfo(
            'Internal Angle from Bearings',
            'Angle between two bearings',
            Icons.change_history,
          ),
          _ToolInfo(
            'Bearing from Known + Internal',
            'Forward/backward bearing calc',
            Icons.rotate_left,
          ),
        ],
      ),
      _ToolCategory(
        title: 'Geometry & Area',
        icon: Icons.crop_square,
        color: AppTheme.accentTeal,
        tools: [
          _ToolInfo(
            'Area by Coordinates',
            'Polygon area (shoelace formula)',
            Icons.crop_square,
          ),
          _ToolInfo('Center of Circle', 'Circle from 3 points', Icons.circle),
          _ToolInfo(
            'Center Point (Centroid)',
            'Average of coordinate points',
            LucideIcons.crosshair,
          ),
        ],
      ),
      _ToolCategory(
        title: 'Intersection & Resection',
        icon: Icons.adjust,
        color: AppTheme.accentPurple,
        tools: [
          _ToolInfo(
            'Intersection (Bearing-Bearing)',
            'Two bearings from known points',
            Icons.merge_type,
          ),
          _ToolInfo(
            'Resection (3-Point)',
            'Position from 3 known points',
            Icons.adjust,
          ),
        ],
      ),
      _ToolCategory(
        title: 'Curve & Alignment',
        icon: Icons.swap_horiz,
        color: AppTheme.accentBlue,
        tools: [
          _ToolInfo(
            'Secants Equal Width',
            'Offsets at equal intervals',
            Icons.remove,
          ),
          _ToolInfo(
            'Secants Non-Equal Width',
            'Offsets at variable intervals',
            Icons.tune,
          ),
        ],
      ),
      _ToolCategory(
        title: 'Leveling',
        icon: Icons.height,
        color: AppTheme.successColor,
        tools: [
          _ToolInfo(
            'Leveling Survey',
            'HI, elevation, backsight/foresight',
            Icons.remove_red_eye,
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
                                AppTheme.accentBlue,
                                AppTheme.accentPurple,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.build,
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
                                'Calculation Tools',
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
                                '${categories.fold<int>(0, (sum, c) => sum + c.tools.length)} tools available',
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
                  final category = categories[index];
                  return _CategorySection(category: category)
                      .animate()
                      .fadeIn(duration: 400.ms, delay: (100 * index).ms)
                      .slideY(begin: 0.2);
                }, childCount: categories.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolInfo {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ToolInfo(this.title, this.subtitle, this.icon);
}

class _ToolCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<_ToolInfo> tools;

  const _ToolCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.tools,
  });
}

class _CategorySection extends StatelessWidget {
  final _ToolCategory category;

  const _CategorySection({required this.category});

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: category.tools.asMap().entries.map((entry) {
            final i = entry.key;
            final tool = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == category.tools.length - 1 ? 0 : 8,
              ),
              child: ToolCard(
                title: tool.title,
                description: tool.subtitle,
                icon: tool.icon,
                accentColor: category.color,
                onTap: () => _showToolDialog(context, tool, category.color),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showToolDialog(BuildContext context, _ToolInfo tool, Color color) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _ToolInputSheet(tool: tool, color: color),
    );
  }
}

class _ToolInputSheet extends StatefulWidget {
  final _ToolInfo tool;
  final Color color;

  const _ToolInputSheet({required this.tool, required this.color});

  @override
  State<_ToolInputSheet> createState() => _ToolInputSheetState();
}

class _LevelingLineControllers {
  final TextEditingController backsight = TextEditingController();
  final TextEditingController foresight = TextEditingController();
  final List<TextEditingController> intermediateSights = [];
  final List<FocusNode> intermediateSightFocusNodes = [];

  _LevelingLineControllers() {
    addIntermediateSight();
  }

  void addIntermediateSight() {
    intermediateSights.add(TextEditingController());
    intermediateSightFocusNodes.add(FocusNode());
  }

  void dispose() {
    backsight.dispose();
    foresight.dispose();
    for (final controller in intermediateSights) {
      controller.dispose();
    }
    for (final focusNode in intermediateSightFocusNodes) {
      focusNode.dispose();
    }
  }
}

class _ToolInputSheetState extends State<_ToolInputSheet> {
  final Map<String, TextEditingController> _controllers = {};
  final List<TextEditingController> _traverseDistances = [
    TextEditingController(),
  ];
  final List<_LevelingLineControllers> _levelingLines = [
    _LevelingLineControllers(),
  ];

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    for (final controller in _traverseDistances) {
      controller.dispose();
    }
    for (final line in _levelingLines) {
      line.dispose();
    }
    super.dispose();
  }

  void _addTraverseLine() {
    setState(() {
      _traverseDistances.add(TextEditingController());
    });
  }

  void _removeTraverseLine(int index) {
    setState(() {
      _traverseDistances[index].dispose();
      _traverseDistances.removeAt(index);
    });
  }

  void _addLevelingLine() {
    setState(() {
      _levelingLines.add(_LevelingLineControllers());
    });
  }

  void _removeLevelingLine(int index) {
    setState(() {
      _levelingLines[index].dispose();
      _levelingLines.removeAt(index);
    });
  }

  String? _result;
  String? _error;

  TextEditingController _controller(String key) =>
      _controllers.putIfAbsent(key, TextEditingController.new);

  double _number(String key) {
    final value = double.tryParse(_controller(key).text.trim());
    if (value == null)
      throw const FormatException('Enter valid numbers in every field.');
    return value;
  }

  List<double> _numbers(String key) {
    final values = _controller(
      key,
    ).text.split(',').map((value) => double.tryParse(value.trim())).toList();
    if (values.isEmpty || values.any((value) => value == null)) {
      throw const FormatException('Use comma-separated numeric values.');
    }
    return values.cast<double>();
  }

  String _v(double value) => formatValue(value);

  void _calculate() {
    try {
      final title = widget.tool.title;
      String result;
      if (title == 'Traverse Calculation') {
        final lines = _traverseLines();
        final analysis = analyzeTraverse(lines);
        result =
            'Total distance: ${_v(analysis.totalDistance)} m\n'
            'Σ Latitude: ${_v(analysis.sumLatitude)} m\n'
            'Σ Departure: ${_v(analysis.sumDeparture)} m\n'
            'Linear misclose: ${_v(analysis.linearMisclose)} m\n'
            'Accuracy: ${analysis.accuracyRatio == null ? 'Perfect closure' : '1:${_v(analysis.accuracyRatio!)}'}';
      } else if (title.startsWith('Bearing + Distance')) {
        final value = coordinateFromStart(
          _number('startE'),
          _number('startN'),
          _number('distance'),
          _bearingValue('bearing'),
        );
        result =
            'Easting: ${_v(value.easting)} m\nNorthing: ${_v(value.northing)} m\nLatitude: ${_v(value.latitudeDeparture.latitude)} m\nDeparture: ${_v(value.latitudeDeparture.departure)} m';
      } else if (title.contains('Coordinate') &&
          title.contains('Bearing + Distance')) {
        final distance = distanceBetweenCoordinates(
          _number('e1'),
          _number('n1'),
          _number('e2'),
          _number('n2'),
        );
        final bearing = bearingBetweenCoordinates(
          _number('e1'),
          _number('n1'),
          _number('e2'),
          _number('n2'),
        );
        result =
            'Distance: ${_v(distance)} m\nBearing: ${formatBearing(bearing)}°\nQuadrant: ${wcbToQuadrantBearing(bearing)}';
      } else if (title == '2 Missing Lines') {
        final value = twoMissingLines(
          AreaPoint(easting: _number('startE'), northing: _number('startN')),
          AreaPoint(easting: _number('endE'), northing: _number('endN')),
          _bearingValue('bearing1'),
          _bearingValue('bearing2'),
        );
        result =
            'Line 1: ${_v(value.distance1)} m at ${formatBearing(value.bearing1)}°\nLine 2: ${_v(value.distance2)} m at ${formatBearing(value.bearing2)}°';
      } else if (title.contains('WCB')) {
        final bearing = _bearingValue('bearing');
        result =
            'Quadrant bearing: ${wcbToQuadrantBearing(bearing)}\nNormalized WCB: ${formatBearing(bearing)}°';
      } else if (title.contains('Internal Angle')) {
        result =
            'Internal angle: ${formatBearing(internalAngleFromBearings(_bearingValue('bearing1'), _bearingValue('bearing2')))}°';
      } else if (title.contains('Known + Internal')) {
        result =
            'Right turn: ${formatBearing(bearingFromKnownAndInternal(_bearingValue('bearing'), _number('angle'), true))}°\nLeft turn: ${formatBearing(bearingFromKnownAndInternal(_bearingValue('bearing'), _number('angle'), false))}°';
      } else if (title == 'Area by Coordinates') {
        result = 'Area: ${_v(areaByCoordinates(_points(3)))} m²';
      } else if (title == 'Center of Circle') {
        final points = _points(3);
        final value = centerOfCircle(points[0], points[1], points[2]);
        result =
            'Center Easting: ${_v(value.centerEasting)} m\nCenter Northing: ${_v(value.centerNorthing)} m\nRadius: ${_v(value.radius)} m';
      } else if (title.contains('Centroid')) {
        final value = centerPoint(_points(3));
        result =
            'Centroid Easting: ${_v(value.easting)} m\nCentroid Northing: ${_v(value.northing)} m';
      } else if (title.startsWith('Intersection')) {
        final value = intersection(
          AreaPoint(easting: _number('e1'), northing: _number('n1')),
          _bearingValue('bearing1'),
          AreaPoint(easting: _number('e2'), northing: _number('n2')),
          _bearingValue('bearing2'),
        );
        result =
            'Easting: ${_v(value.easting)} m\nNorthing: ${_v(value.northing)} m\nDistance from point 1: ${_v(value.distance1)} m\nDistance from point 2: ${_v(value.distance2)} m';
      } else if (title.startsWith('Resection')) {
        final value = resection(_points(3), [
          _number('angle1'),
          _number('angle2'),
          _number('angle3'),
        ]);
        result =
            'Easting: ${_v(value.easting)} m\nNorthing: ${_v(value.northing)} m\nResiduals: ${value.residuals.map(_v).join(', ')}°';
      } else if (title == 'Secants Equal Width') {
        final value = secantsEqualWidth(
          baseline: _number('baseline'),
          numSections: _number('sections').round(),
          offsets: _numbers('offsets'),
        );
        result =
            'Area: ${_v(value.totalArea)} m²\nOffsets: ${value.offsets.map(_v).join(', ')}';
      } else if (title == 'Secants Non-Equal Width') {
        final value = secantsNonEqualWidth(
          distances: _numbers('distances'),
          offsets: _numbers('offsets'),
        );
        result = 'Area: ${_v(value.totalArea)} m²';
      } else if (title == 'Leveling Survey') {
        final levelingLines = _levelingLines.asMap().entries.map((entry) {
          final lineNumber = entry.key + 1;
          final line = entry.value;
          final backsight = double.tryParse(line.backsight.text.trim());
          final foresight = double.tryParse(line.foresight.text.trim());
          final intermediateSights = <double>[];
          for (var isIndex = 0; isIndex < line.intermediateSights.length; isIndex++) {
            final intermediateText = line.intermediateSights[isIndex].text.trim();
            final intermediateSight = double.tryParse(intermediateText);
            if (intermediateSight == null) {
              throw FormatException(
                'Enter a valid IS ${isIndex + 1} for Line $lineNumber.',
              );
            }
            intermediateSights.add(intermediateSight);
          }
          if (backsight == null || foresight == null) {
            throw FormatException(
              'Enter the backsight and foresight for Line $lineNumber.',
            );
          }
          return LevelingLineInput(
            backsight: backsight,
            foresight: foresight,
            intermediateSights: intermediateSights,
          );
        }).toList();
        final value = levelingSurvey(
          benchmarkElevation: _number('benchmark'),
          lines: levelingLines,
        );
        final lines = <String>[
          'Benchmark RL: ${_v(_number('benchmark'))} m',
          ...value.lines.expand((line) => [
            'Line ${line.lineNumber} HI: ${_v(line.heightOfInstrument)} m',
            if (line.intermediateElevation != null)
              'Line ${line.lineNumber} IS RL: ${_v(line.intermediateElevation!)} m',
            'Line ${line.lineNumber} FS RL: ${_v(line.foresightElevation)} m',
          ]),
          'Final RL: ${_v(value.elevation)} m',
        ];
        result = lines.join('\n');
      } else {
        throw const FormatException('This tool is not configured yet.');
      }
      setState(() {
        _result = result;
        _error = null;
      });
    } on FormatException catch (error) {
      setState(() {
        _error = error.message;
        _result = null;
      });
    } catch (_) {
      setState(() {
        _error = 'Unable to calculate. Check the entered values.';
        _result = null;
      });
    }
  }

  List<TraverseLineInput> _traverseLines() => List.generate(
    _traverseDistances.length,
    (index) => TraverseLineInput(
      distance:
          double.tryParse(_traverseDistances[index].text.trim()) ??
          (throw const FormatException('Enter every traverse distance.')),
      bearingDeg: _bearingValue('traverseBearing$index'),
    ),
  );

  double _bearingValue(String key) {
    final degreesText = _controller('${key}Degrees').text.trim();
    final minutesText = _controller('${key}Minutes').text.trim();
    final secondsText = _controller('${key}Seconds').text.trim();
    final degrees = int.tryParse(degreesText);
    final minutes = int.tryParse(minutesText);
    final seconds = int.tryParse(secondsText);

    if (degrees == null || minutes == null || seconds == null) {
      throw const FormatException(
        'Enter degrees, minutes, and seconds for every bearing.',
      );
    }

    return dmsToDecimalDegrees(
      '$degrees.${minutes.toString().padLeft(2, '0')}${seconds.toString().padLeft(2, '0')}',
    );
  }

  void _showTraverse3D() {
    try {
      final lines = _traverseLines();
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => _Traverse3DSheet(lines: lines, color: widget.color),
      );
    } on FormatException catch (error) {
      setState(() {
        _error = error.message;
        _result = null;
      });
    }
  }

  List<AreaPoint> _points(int count) => List.generate(
    count,
    (index) => AreaPoint(
      easting: _number('p${index + 1}e'),
      northing: _number('p${index + 1}n'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardInset = mediaQuery.viewInsets.bottom;
    final availableHeight = mediaQuery.size.height - keyboardInset;
    final sheetHeight = keyboardInset > 0
        ? availableHeight
        : math.min(mediaQuery.size.height * 0.85, availableHeight);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: SizedBox(
        height: sheetHeight,
        child: Container(
          decoration: const BoxDecoration(
            color: AppTheme.surfaceDark,
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
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    math.max(32.0, keyboardInset + 32.0),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          widget.tool.icon,
                          color: widget.color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tool.title,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              widget.tool.subtitle,
                              style: const TextStyle(
                                color: AppTheme.textMuted,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Input Parameters',
                                style: TextStyle(
                                  color: widget.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (widget.tool.title == 'Traverse Calculation')
                              OutlinedButton(
                                onPressed: _showTraverse3D,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: widget.color,
                                  side: BorderSide(
                                    color: widget.color.withValues(alpha: 0.65),
                                  ),
                                  minimumSize: const Size(48, 34),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  '3D',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInputFields(),
                        if (_result != null || _error != null) ...[
                          const SizedBox(height: 20),
                          ResultCard(
                            title: _error == null
                                ? 'Result'
                                : 'Check your input',
                            value: _result ?? _error!,
                            accentColor: _error == null
                                ? widget.color
                                : AppTheme.errorColor,
                            isHighlighted: true,
                          ),
                        ],
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _calculate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.color,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Calculate',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() => _buildCalculatorInputs();

  Widget _field(String key, String label, {String? hint}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: GlassInputField(
      controller: _controller(key),
      label: label,
      hint: hint,
      keyboardType: TextInputType.number,
    ),
  );

  Widget _dmsBearingFields(String key, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GlassInputField(
                controller: _controller('${key}Degrees'),
                label: 'Degrees',
                hint: '52',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.explore,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GlassInputField(
                controller: _controller('${key}Minutes'),
                label: 'Minutes',
                hint: '30',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GlassInputField(
                controller: _controller('${key}Seconds'),
                label: 'Seconds',
                hint: '15',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _pointFields(int count) => Column(
    children: [
      for (var index = 1; index <= count; index++) ...[
        _field('p${index}e', 'Point $index Easting', hint: '500000.0'),
        _field('p${index}n', 'Point $index Northing', hint: '300000.0'),
      ],
    ],
  );

  Widget _buildCalculatorInputs() {
    final title = widget.tool.title;
    if (title == 'Traverse Calculation') return _buildTraverseInputs();
    if (title.startsWith('Bearing + Distance')) {
      return Column(
        children: [
          _field('startE', 'Start Easting'),
          _field('startN', 'Start Northing'),
          _field('distance', 'Distance (m)'),
          _dmsBearingFields('bearing', 'Bearing'),
        ],
      );
    }
    if (title.startsWith('Coordinate')) {
      return Column(
        children: [
          _field('e1', 'Point 1 Easting'),
          _field('n1', 'Point 1 Northing'),
          _field('e2', 'Point 2 Easting'),
          _field('n2', 'Point 2 Northing'),
        ],
      );
    }
    if (title == '2 Missing Lines') {
      return Column(
        children: [
          _field('startE', 'Start Easting'),
          _field('startN', 'Start Northing'),
          _field('endE', 'End Easting'),
          _field('endN', 'End Northing'),
          _dmsBearingFields('bearing1', 'Missing line 1 bearing'),
          _dmsBearingFields('bearing2', 'Missing line 2 bearing'),
        ],
      );
    }
    if (title.contains('WCB'))
      return _dmsBearingFields('bearing', 'Whole Circle Bearing');
    if (title.contains('Internal Angle'))
      return Column(
        children: [
          _dmsBearingFields('bearing1', 'First bearing'),
          _dmsBearingFields('bearing2', 'Second bearing'),
        ],
      );
    if (title.contains('Known + Internal'))
      return Column(
        children: [
          _dmsBearingFields('bearing', 'Known bearing'),
          _field('angle', 'Internal angle (°)'),
        ],
      );
    if (title == 'Area by Coordinates' ||
        title == 'Center of Circle' ||
        title.contains('Centroid'))
      return _pointFields(3);
    if (title.startsWith('Intersection'))
      return Column(
        children: [
          _field('e1', 'Point 1 Easting'),
          _field('n1', 'Point 1 Northing'),
          _dmsBearingFields('bearing1', 'Point 1 bearing'),
          _field('e2', 'Point 2 Easting'),
          _field('n2', 'Point 2 Northing'),
          _dmsBearingFields('bearing2', 'Point 2 bearing'),
        ],
      );
    if (title.startsWith('Resection'))
      return Column(
        children: [
          _pointFields(3),
          _field('angle1', 'Observed angle 1 (°)'),
          _field('angle2', 'Observed angle 2 (°)'),
          _field('angle3', 'Observed angle 3 (°)'),
        ],
      );
    if (title == 'Secants Equal Width')
      return Column(
        children: [
          _field('baseline', 'Baseline length (m)'),
          _field('sections', 'Number of sections'),
          _field('offsets', 'Offsets, comma separated', hint: '0, 2.1, 3.4, 0'),
        ],
      );
    if (title == 'Secants Non-Equal Width')
      return Column(
        children: [
          _field('distances', 'Chainages, comma separated', hint: '0, 10, 25'),
          _field('offsets', 'Offsets, comma separated', hint: '0, 2.1, 0'),
        ],
      );
    if (title == 'Leveling Survey')
      return Column(
        children: [
          _field('benchmark', 'Benchmark elevation (m)'),
          _buildLevelingInputs(),
        ],
      );
    return const SizedBox.shrink();
  }

  Widget _buildTraverseInputs() => Column(
    children: [
      for (var i = 0; i < _traverseDistances.length; i++) ...[
        Row(
          children: [
            Expanded(
              child: GlassInputField(
                controller: _traverseDistances[i],
                label: 'Line ${i + 1} - Distance (m)',
                hint: '60.123',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.straighten,
              ),
            ),
            if (_traverseDistances.length > 1 && i > 0) ...[
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _removeTraverseLine(i),
                icon: const Icon(Icons.delete_outline, size: 20),
                style: IconButton.styleFrom(
                  foregroundColor: Colors.red.withValues(alpha: 0.7),
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        _dmsBearingFields('traverseBearing$i', 'Line ${i + 1} - Bearing'),
        const SizedBox(height: 12),
      ],
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _addTraverseLine,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add line'),
        ),
      ),
    ],
  );

  Widget _buildLevelingInputs() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < _levelingLines.length; i++) ...[
        _levelingLineCard(i, _levelingLines[i]),
        if (i < _levelingLines.length - 1) const SizedBox(height: 12),
      ],
      const SizedBox(height: 12),
      OutlinedButton.icon(
        onPressed: _addLevelingLine,
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Add line'),
      ),
    ],
  );

  Widget _levelingLineCard(int index, _LevelingLineControllers line) => GlassCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.height, color: widget.color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Line ${index + 1}',
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'One instrument setup: BS, FS, and optional IS',
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (_levelingLines.length > 1)
              IconButton(
                onPressed: () => _removeLevelingLine(index),
                icon: const Icon(Icons.delete_outline, size: 20),
                tooltip: 'Delete Line ${index + 1}',
                style: IconButton.styleFrom(
                  foregroundColor: AppTheme.errorColor,
                  padding: const EdgeInsets.all(8),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        GlassInputField(
          controller: line.backsight,
          label: 'Line ${index + 1} - Backsight (m)',
          hint: '1.520',
          keyboardType: TextInputType.number,
          prefixIcon: Icons.vertical_align_top,
        ),
        const SizedBox(height: 10),
        GlassInputField(
          controller: line.foresight,
          label: 'Line ${index + 1} - Foresight (m)',
          hint: '1.850',
          keyboardType: TextInputType.number,
          prefixIcon: Icons.vertical_align_bottom,
        ),
        const SizedBox(height: 10),
        for (var isIndex = 0; isIndex < line.intermediateSights.length; isIndex++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GlassInputField(
                  controller: line.intermediateSights[isIndex],
                  focusNode: line.intermediateSightFocusNodes[isIndex],
                  label: 'Line ${index + 1} - IS ${isIndex + 1} (m)',
                  hint: 'e.g. 1.210',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.linear_scale,
                  onSubmitted: (_) {
                    final nextIndex = isIndex + 1;
                    if (nextIndex < line.intermediateSightFocusNodes.length) {
                      line.intermediateSightFocusNodes[nextIndex].requestFocus();
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () => setState(() {
                  line.intermediateSights[isIndex].dispose();
                  line.intermediateSightFocusNodes[isIndex].dispose();
                  line.intermediateSights.removeAt(isIndex);
                  line.intermediateSightFocusNodes.removeAt(isIndex);
                }),
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Delete IS ${isIndex + 1}',
                color: AppTheme.errorColor,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        OutlinedButton.icon(
          onPressed: () => setState(line.addIntermediateSight),
          icon: const Icon(Icons.add, size: 18),
          label: Text(
            line.intermediateSights.isEmpty ? 'Add IS' : 'Add another IS',
          ),
        ),
      ],
    ),
  );

  // ignore: unused_element
  Widget _buildLegacyInputFields() {
    switch (widget.tool.title) {
      case 'Traverse Calculation':
        return Column(
          children: [
            GlassInputField(
              controller: _traverseDistances[0],
              label: 'Line 1 - Distance (m)',
              hint: '60.123',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.straighten,
            ),
            const SizedBox(height: 12),
            _dmsBearingFields('traverseBearing0', 'Line 1 - Bearing'),
            const SizedBox(height: 8),
            for (var i = 1; i < _traverseDistances.length; i++) ...[
              GlassInputField(
                controller: _traverseDistances[i],
                label: 'Line ${i + 1} - Distance (m)',
                hint: '60.123',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.straighten,
              ),
              const SizedBox(height: 12),
              _dmsBearingFields('traverseBearing$i', 'Line ${i + 1} - Bearing'),
              const SizedBox(height: 12),
            ],
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _addTraverseLine,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add line'),
              ),
            ),
          ],
        );
      case 'Bearing + Distance → Coordinate':
        return Column(
          children: [
            GlassInputField(
              controller: TextEditingController(),
              label: 'Start Easting',
              hint: '500000.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Start Northing',
              hint: '300000.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Distance (m)',
              hint: '60.123',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.straighten,
            ),
            const SizedBox(height: 12),
            _dmsBearingFields('bearing', 'Bearing'),
          ],
        );
      case 'Coordinate → Bearing + Distance':
        return Column(
          children: [
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 1 Easting',
              hint: '500000.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 1 Northing',
              hint: '300000.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 2 Easting',
              hint: '500030.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 2 Northing',
              hint: '300052.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
          ],
        );
      case 'WCB ↔ Quadrant Bearing':
        return Column(
          children: [
            _dmsBearingFields('bearing', 'Whole Circle Bearing'),
            const SizedBox(height: 8),
            Text(
              'Or enter Quadrant Bearing:',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GlassInputField(
                    controller: TextEditingController(),
                    label: 'Prefix (N/S)',
                    hint: 'N',
                    prefixIcon: Icons.explore,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassInputField(
                    controller: TextEditingController(),
                    label: 'Angle (°)',
                    hint: '45.0',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.explore,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassInputField(
                    controller: TextEditingController(),
                    label: 'Suffix (E/W)',
                    hint: 'E',
                    prefixIcon: Icons.explore,
                  ),
                ),
              ],
            ),
          ],
        );
      case 'Area by Coordinates':
        return Column(
          children: [
            GlassInputField(
              controller: TextEditingController(),
              label: 'Number of Vertices',
              hint: '4',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.crop_square,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 1 (E, N)',
              hint: '500000, 300000',
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 2 (E, N)',
              hint: '500100, 300000',
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 8),
            Text(
              'Add more points...',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
            ),
          ],
        );
      case 'Intersection (Bearing-Bearing)':
        return Column(
          children: [
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 1 Easting',
              hint: '500000.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 1 Northing',
              hint: '300000.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            _dmsBearingFields('bearing1', 'Point 1 Bearing'),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 2 Easting',
              hint: '500100.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Point 2 Northing',
              hint: '300000.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            _dmsBearingFields('bearing2', 'Point 2 Bearing'),
          ],
        );
      case 'Resection (3-Point)':
        return Column(
          children: [
            GlassInputField(
              controller: TextEditingController(),
              label: 'Known Point 1 (E, N)',
              hint: '500000, 300000',
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Known Point 2 (E, N)',
              hint: '500100, 300000',
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Known Point 3 (E, N)',
              hint: '500050, 300100',
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Observed Angle 1-2 (°)',
              hint: '60.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.change_history,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Observed Angle 2-3 (°)',
              hint: '70.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.change_history,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Observed Angle 3-1 (°)',
              hint: '50.0',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.change_history,
            ),
          ],
        );
      case 'Leveling Survey':
        return Column(
          children: [
            GlassInputField(
              controller: TextEditingController(),
              label: 'Benchmark Elevation (m)',
              hint: '100.000',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.height,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Backsight Reading (m)',
              hint: '1.523',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.remove_red_eye,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Foresight Reading (m)',
              hint: '1.234',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.remove_red_eye,
            ),
          ],
        );
      default:
        return Column(
          children: [
            GlassInputField(
              controller: TextEditingController(),
              label: 'Parameter 1',
              hint: 'Enter value',
              prefixIcon: Icons.tune,
            ),
            const SizedBox(height: 12),
            GlassInputField(
              controller: TextEditingController(),
              label: 'Parameter 2',
              hint: 'Enter value',
              prefixIcon: Icons.tune,
            ),
          ],
        );
    }
  }
}

class _Traverse3DSheet extends StatefulWidget {
  final List<TraverseLineInput> lines;
  final Color color;

  const _Traverse3DSheet({required this.lines, required this.color});

  @override
  State<_Traverse3DSheet> createState() => _Traverse3DSheetState();
}

class _Traverse3DSheetState extends State<_Traverse3DSheet> {
  double _yaw = -0.65;
  double _pitch = 0.8;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                Icon(Icons.threed_rotation, color: widget.color),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Traverse 3D View',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    _yaw = -0.65;
                    _pitch = 0.8;
                  }),
                  tooltip: 'Reset view',
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: GlassCard(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: GestureDetector(
                    onPanUpdate: (details) => setState(() {
                      _yaw += details.delta.dx * 0.01;
                      _pitch = (_pitch - details.delta.dy * 0.01).clamp(
                        0.25,
                        1.35,
                      );
                    }),
                    child: CustomPaint(
                      painter: _Traverse3DPainter(
                        lines: widget.lines,
                        color: widget.color,
                        yaw: _yaw,
                        pitch: _pitch,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              'Drag to rotate • Traverse shown on Z = 0 plane',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _Traverse3DPainter extends CustomPainter {
  final List<TraverseLineInput> lines;
  final Color color;
  final double yaw;
  final double pitch;

  const _Traverse3DPainter({
    required this.lines,
    required this.color,
    required this.yaw,
    required this.pitch,
  });

  List<Offset> _coordinates() {
    final points = <Offset>[Offset.zero];
    for (final line in lines) {
      final radians = line.bearingDeg * math.pi / 180.0;
      final previous = points.last;
      points.add(
        Offset(
          previous.dx + line.distance * math.sin(radians),
          previous.dy + line.distance * math.cos(radians),
        ),
      );
    }
    return points;
  }

  Offset _project(Offset point, Size size, double scale, Offset center) {
    final rotatedX = point.dx * math.cos(yaw) - point.dy * math.sin(yaw);
    final rotatedY = point.dx * math.sin(yaw) + point.dy * math.cos(yaw);
    final projectedY = rotatedY * math.cos(pitch);
    return Offset(center.dx + rotatedX * scale, center.dy - projectedY * scale);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final points = _coordinates();
    final maxExtent = points.fold<double>(1.0, (current, point) {
      return math.max(current, math.max(point.dx.abs(), point.dy.abs()));
    });
    final scale = math.min(size.width, size.height) * 0.38 / maxExtent;
    final center = Offset(size.width / 2, size.height / 2);
    final projected = points
        .map((point) => _project(point, size, scale, center))
        .toList();

    canvas.drawRect(Offset.zero & size, Paint()..color = AppTheme.surfaceDark);

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    for (var index = -4; index <= 4; index++) {
      final offset = index * maxExtent * 0.5;
      final a = _project(Offset(-maxExtent, offset), size, scale, center);
      final b = _project(Offset(maxExtent, offset), size, scale, center);
      final c = _project(Offset(offset, -maxExtent), size, scale, center);
      final d = _project(Offset(offset, maxExtent), size, scale, center);
      canvas.drawLine(a, b, gridPaint);
      canvas.drawLine(c, d, gridPaint);
    }

    final axisPaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.white.withValues(alpha: 0.35);
    canvas.drawLine(
      _project(Offset(-maxExtent, 0), size, scale, center),
      _project(Offset(maxExtent, 0), size, scale, center),
      axisPaint,
    );
    canvas.drawLine(
      _project(Offset(0, -maxExtent), size, scale, center),
      _project(Offset(0, maxExtent), size, scale, center),
      axisPaint,
    );

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (var index = 0; index < projected.length - 1; index++) {
      canvas.drawLine(projected[index], projected[index + 1], linePaint);
    }

    final pointPaint = Paint()..color = Colors.white;
    final labelPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var index = 0; index < projected.length; index++) {
      canvas.drawCircle(projected[index], 6, pointPaint);
      canvas.drawCircle(projected[index], 4, Paint()..color = color);
      labelPainter.text = TextSpan(
        text: 'P${index + 1}',
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      );
      labelPainter.layout();
      labelPainter.paint(canvas, projected[index] + const Offset(8, -14));
    }
  }

  @override
  bool shouldRepaint(covariant _Traverse3DPainter oldDelegate) {
    return oldDelegate.lines != lines ||
        oldDelegate.color != color ||
        oldDelegate.yaw != yaw ||
        oldDelegate.pitch != pitch;
  }
}
