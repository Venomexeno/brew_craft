import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Warm, tonal palette tuned to feel like a premium espresso bar —
/// espresso, mocha, caramel and cream. No cool greys.

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: const ColorScheme.light(
        primary: AppColors.espresso,
        secondary: AppColors.caramel,
        surface: AppColors.surface,
        onPrimary: AppColors.foam,
        onSurface: AppColors.ink,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.outfitTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.fraunces(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
          height: 1.05,
        ),
        displaySmall: GoogleFonts.fraunces(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        labelSmall: GoogleFonts.outfit(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
          color: AppColors.inkSoft,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 14,
          color: AppColors.inkSoft,
        ),
      ),
    );
  }
}
