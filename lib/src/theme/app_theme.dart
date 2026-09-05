import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static bool _lightMode = false;

  static void configureBrightness(Brightness brightness) {
    _lightMode = brightness == Brightness.light;
  }

  static const Color primaryDark = Color(0xFF1B2128);
  static const Color surfaceDark = Color(0xFF222831);
  static const Color surfaceVariant = Color(0xFF2D353F);
  static const Color accentBlue = Color(0xFF64B5F6);
  static const Color accentTeal = Color(0xFF4DB6AC);
  static const Color accentAmber = Color(0xFFFFCC80);
  static const Color accentPurple = Color(0xFFBA68C8);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFC4CEDA);
  static const Color textMuted = Color(0xFF90A4AE);
  static const Color errorColor = Color(0xFFEF5350);
  static const Color successColor = Color(0xFF66BB6A);
  static const Color warningColor = Color(0xFFFFCA28);

  static const List<AppThemePalette> palettes = [
    AppThemePalette('Default', Color(0xFF64B5F6)),
    AppThemePalette('Dynamic', Color(0xFF90CAF9)),
    AppThemePalette('Catppuccin', Color(0xFFCE93D8)),
    AppThemePalette('Green Apple', Color(0xFF66BB6A)),
    AppThemePalette('Lavender', Color(0xFFAB82FF)),
    AppThemePalette('Midnight Dusk', Color(0xFFEC407A)),
    AppThemePalette('Nord', Color(0xFF88C0D0)),
    AppThemePalette('Strawberry', Color(0xFFFF8A80)),
    AppThemePalette('Tako', Color(0xFFFFB74D)),
    AppThemePalette('Tidal Wave', Color(0xFF29B6F6)),
    AppThemePalette('Yin & Yang', Color(0xFF607D8B)),
    AppThemePalette('Yotsuba', Color(0xFFFFAB91)),
    AppThemePalette('Monochrome', Color(0xFF111111)),
  ];

  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassWhiteStrong = Color(0x2FFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);

  static ThemeData get darkTheme {
    return darkThemeFor();
  }

  static ThemeData darkThemeFor({
    Color seedColor = accentBlue,
    bool pureBlack = false,
  }) {
    final base = ThemeData.dark();
    final monochrome =
        seedColor.toARGB32() == const Color(0xFF111111).toARGB32();
    final scheme =
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ).copyWith(
          primary: monochrome ? Colors.white : null,
          secondary: monochrome ? Colors.white : null,
          tertiary: monochrome ? Colors.grey : null,
          onPrimary: monochrome ? Colors.black : null,
        );
    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: pureBlack ? Colors.black : primaryDark,
      colorScheme: scheme.copyWith(
        surface: pureBlack ? Colors.black : surfaceDark,
      ),
      textTheme: GoogleFonts.interTextTheme(
        base.textTheme,
      ).apply(bodyColor: textPrimary, displayColor: textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: glassBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlue,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentBlue,
          side: const BorderSide(color: accentBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: glassBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: accentBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        labelStyle: GoogleFonts.inter(color: textMuted),
        hintStyle: GoogleFonts.inter(color: textMuted),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: accentBlue,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
      ),
      dividerTheme: const DividerThemeData(
        color: glassBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get lightTheme {
    return lightThemeFor(accentBlue);
  }

  static ThemeData lightThemeFor(Color seedColor) {
    final monochrome =
        seedColor.toARGB32() == const Color(0xFF111111).toARGB32();
    final scheme =
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ).copyWith(
          primary: monochrome ? Colors.black : null,
          secondary: monochrome ? Colors.black : null,
          tertiary: monochrome ? Colors.grey : null,
          onPrimary: monochrome ? Colors.white : null,
        );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
    );
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  static BoxDecoration glassCard({double radius = 20, Color? borderColor}) {
    return BoxDecoration(
      color: (_lightMode ? Colors.white : surfaceDark).withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color:
            borderColor ?? (_lightMode ? const Color(0x26000000) : glassBorder),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: _lightMode ? 0.12 : 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: _lightMode ? 0.5 : 0.02),
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  static BoxDecoration glassPill({double radius = 28}) {
    return BoxDecoration(
      color: surfaceDark.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: glassBorder, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: accentBlue.withValues(alpha: 0.1),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration glassPillSelected({double radius = 28}) {
    return BoxDecoration(
      color: accentBlue.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: accentBlue.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accentBlue.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

class AppThemePalette {
  final String name;
  final Color color;

  const AppThemePalette(this.name, this.color);
}

extension ColorExtension on Color {
  Color withValues({required double alpha}) {
    return withAlpha((alpha.clamp(0.0, 1.0) * 255).toInt());
  }
}
