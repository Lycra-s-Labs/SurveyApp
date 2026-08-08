import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryDark = Color(0xFF000000);
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

  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassWhiteStrong = Color(0x2FFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: accentBlue,
        secondary: accentTeal,
        tertiary: accentAmber,
        surface: surfaceDark,
        surfaceContainerHighest: surfaceVariant,
        error: errorColor,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: textPrimary,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentBlue,
          side: const BorderSide(color: accentBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  static BoxDecoration glassCard({double radius = 20, Color? borderColor}) {
    return BoxDecoration(
      color: surfaceDark.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor ?? glassBorder, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.02),
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

extension ColorExtension on Color {
  Color withValues({required double alpha}) {
    return withAlpha((alpha.clamp(0.0, 1.0) * 255).toInt());
  }
}