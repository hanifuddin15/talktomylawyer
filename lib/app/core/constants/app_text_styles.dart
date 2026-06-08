import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All typography using Outfit from Google Fonts
class AppTextStyles {
  AppTextStyles._();

  // --- Dark Mode Text Styles ---
  static TextStyle darkDisplayLarge = GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: const Color(0xFFFFFFFF),
    height: 1.2,
  );

  static TextStyle darkHeadlineLarge = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: const Color(0xFFFFFFFF),
    height: 1.3,
  );

  static TextStyle darkHeadlineMedium = GoogleFonts.outfit(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFFFFFFFF),
    height: 1.3,
  );

  static TextStyle darkTitleLarge = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFFFFFFF),
    height: 1.4,
  );

  static TextStyle darkTitleMedium = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFFFFFFF),
    height: 1.4,
  );

  static TextStyle darkBodyLarge = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFFFFFFF),
    height: 1.5,
  );

  static TextStyle darkBodyMedium = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF8A9CC8),
    height: 1.5,
  );

  static TextStyle darkBodySmall = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF8A9CC8),
    height: 1.5,
  );

  static TextStyle darkLabelLarge = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFFFFFFF),
    height: 1.4,
  );

  static TextStyle darkLabelMedium = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF8A9CC8),
    height: 1.4,
  );

  static TextStyle darkLabelSmall = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF8A9CC8),
    height: 1.4,
  );

  // --- Light Mode Text Styles ---
  static TextStyle lightDisplayLarge = GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0A1128),
    height: 1.2,
  );

  static TextStyle lightHeadlineLarge = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0A1128),
    height: 1.3,
  );

  static TextStyle lightHeadlineMedium = GoogleFonts.outfit(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0A1128),
    height: 1.3,
  );

  static TextStyle lightTitleLarge = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF0A1128),
    height: 1.4,
  );

  static TextStyle lightTitleMedium = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF0A1128),
    height: 1.4,
  );

  static TextStyle lightBodyLarge = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF0A1128),
    height: 1.5,
  );

  static TextStyle lightBodyMedium = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF4A5568),
    height: 1.5,
  );

  static TextStyle lightBodySmall = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF4A5568),
    height: 1.5,
  );

  static TextStyle lightLabelLarge = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF0A1128),
    height: 1.4,
  );

  static TextStyle lightLabelMedium = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF4A5568),
    height: 1.4,
  );

  static TextStyle lightLabelSmall = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF4A5568),
    height: 1.4,
  );
}

/// Helper to get correct TextTheme for ThemeData
TextTheme buildTextTheme({required bool isDark}) {
  final primary = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF0A1128);
  final secondary = isDark ? const Color(0xFF8A9CC8) : const Color(0xFF4A5568);

  return GoogleFonts.outfitTextTheme(TextTheme(
    displayLarge: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w700, color: primary, height: 1.2),
    headlineLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: primary, height: 1.3),
    headlineMedium: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w700, color: primary, height: 1.3),
    titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: primary, height: 1.4),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: primary, height: 1.4),
    bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: primary, height: 1.5),
    bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.5),
    bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.5),
    labelLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: primary, height: 1.4),
    labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: secondary,
        height: 1.4),
    labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondary,
        height: 1.4),
  ));
}
