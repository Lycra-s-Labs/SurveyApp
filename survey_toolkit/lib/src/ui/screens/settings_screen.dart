import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final Color seedColor;
  final ValueChanged<Color> onSeedColorChanged;
  final bool pureBlack;
  final ValueChanged<bool> onPureBlackChanged;

  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.seedColor,
    required this.onSeedColorChanged,
    required this.pureBlack,
    required this.onPureBlackChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          children: [
            Text(
              'Settings',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 28),
            Text(
              'Personalize your Survey Toolkit',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            _SettingsBar(
              icon: Icons.palette_outlined,
              title: 'Appearance',
              subtitle: 'Theme, colors, and dark mode',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AppearanceScreen(
                    themeMode: themeMode,
                    onThemeModeChanged: onThemeModeChanged,
                    seedColor: seedColor,
                    onSeedColorChanged: onSeedColorChanged,
                    pureBlack: pureBlack,
                    onPureBlackChanged: onPureBlackChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppearanceScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final Color seedColor;
  final ValueChanged<Color> onSeedColorChanged;
  final bool pureBlack;
  final ValueChanged<bool> onPureBlackChanged;

  const AppearanceScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.seedColor,
    required this.onSeedColorChanged,
    required this.pureBlack,
    required this.onPureBlackChanged,
  });

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late ThemeMode _themeMode;
  late Color _seedColor;
  late bool _pureBlack;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
    _seedColor = widget.seedColor;
    _pureBlack = widget.pureBlack;
  }

  void _setThemeMode(ThemeMode value) {
    setState(() => _themeMode = value);
    widget.onThemeModeChanged(value);
  }

  void _setSeedColor(Color value) {
    setState(() => _seedColor = value);
    widget.onSeedColorChanged(value);
  }

  void _setPureBlack(bool value) {
    setState(() => _pureBlack = value);
    widget.onPureBlackChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Appearance')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          Text(
            'Theme',
            style: TextStyle(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            showSelectedIcon: true,
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(Icons.brightness_auto),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.light_mode),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.dark_mode),
              ),
            ],
            selected: {_themeMode},
            onSelectionChanged: (selection) => _setThemeMode(selection.first),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: AppTheme.palettes.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final palette = AppTheme.palettes[index];
                return _PaletteCard(
                  palette: palette,
                  selected: palette.color.toARGB32() == _seedColor.toARGB32(),
                  onTap: () => _setSeedColor(palette.color),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Pure black dark mode'),
            subtitle: const Text(
              'Use black instead of the normal dark surface',
            ),
            value: _pureBlack,
            onChanged: _setPureBlack,
          ),
        ],
      ),
    );
  }
}

class _SettingsBar extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsBar({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(icon, color: scheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaletteCard extends StatelessWidget {
  final AppThemePalette palette;
  final bool selected;
  final VoidCallback onTap;

  const _PaletteCard({
    required this.palette,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = Color.lerp(
      theme.scaffoldBackgroundColor,
      palette.color,
      theme.brightness == Brightness.dark ? 0.12 : 0.08,
    )!;
    return SizedBox(
      width: 132,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected ? palette.color : theme.dividerColor,
                    width: selected ? 3 : 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      decoration: BoxDecoration(
                        color: palette.color.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: palette.color.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        CircleAvatar(radius: 7, backgroundColor: palette.color),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: palette.color.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              palette.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
