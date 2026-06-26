import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography PUREDROP.
/// - Sora    → body, label, button (font utama)
/// - Fraunces → display, heading, angka besar (font dekoratif)
class AppTextStyles {
  AppTextStyles._();

  // ── Display / Heading (Fraunces) ──────────────────────────────────────────

  static TextStyle display({
    Color color = AppColors.ink,
    double size = 23,
    FontWeight weight = FontWeight.w600,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: -0.5,
      );

  /// Angka besar di ring card / stat
  static TextStyle statBig({
    Color color = AppColors.white,
    double size = 34,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w800,
        color: color,
        height: 1,
      );

  static TextStyle statMedium({
    Color color = AppColors.aqua600,
    double size = 18,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w800,
        color: color,
      );

  // ── Body (Sora) ───────────────────────────────────────────────────────────

  static TextStyle body({
    Color color = AppColors.ink,
    double size = 14,
    FontWeight weight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.sora(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  static TextStyle label({
    Color color = AppColors.inkSoft,
    double size = 12,
    FontWeight weight = FontWeight.w600,
  }) =>
      GoogleFonts.sora(
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  static TextStyle caption({
    Color color = AppColors.inkSoft,
    double size = 10,
  }) =>
      GoogleFonts.sora(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle button({
    Color color = AppColors.white,
    double size = 14,
  }) =>
      GoogleFonts.sora(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle greet({Color color = AppColors.inkSoft}) =>
      GoogleFonts.sora(fontSize: 12, color: color);

  static TextStyle sectionHeader({Color color = AppColors.ink}) =>
      GoogleFonts.sora(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: color,
      );
}
