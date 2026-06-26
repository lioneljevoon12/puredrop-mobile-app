import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.aqua500,
        brightness: Brightness.light,
        primary: AppColors.aqua500,
        secondary: AppColors.teal500,
        surface: AppColors.white,
        background: AppColors.bgLight,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.ink,
        onBackground: AppColors.ink,
      ),
      scaffoldBackgroundColor: AppColors.bgLight,

      // ── Typography ──────────────────────────────────────────────────────
      textTheme: GoogleFonts.soraTextTheme(ThemeData.light().textTheme).copyWith(
        bodyLarge: GoogleFonts.sora(color: AppColors.ink),
        bodyMedium: GoogleFonts.sora(color: AppColors.ink),
        bodySmall: GoogleFonts.sora(color: AppColors.inkSoft),
      ),

      // ── AppBar ──────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: AppColors.ink),
        titleTextStyle: GoogleFonts.sora(
          color: AppColors.ink,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ── Buttons ─────────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.aqua500,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.aqua200,
          textStyle: GoogleFonts.sora(fontWeight: FontWeight.w700, fontSize: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size(double.infinity, 50),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.aqua600,
          side: const BorderSide(color: AppColors.aqua300, width: 1.5),
          textStyle: GoogleFonts.sora(fontWeight: FontWeight.w700, fontSize: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size(double.infinity, 50),
        ),
      ),

      // ── Input ───────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.aqua50,
        labelStyle: GoogleFonts.sora(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.inkSoft,
        ),
        hintStyle: GoogleFonts.sora(
          fontSize: 13,
          color: AppColors.inkSoft,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.aqua200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.aqua200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.aqua500, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── Card ────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: AppColors.aqua100),
        ),
        margin: const EdgeInsets.only(bottom: 14),
      ),

      // ── Bottom Nav ──────────────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.aqua500,
        unselectedItemColor: AppColors.tabBar,
        selectedLabelStyle: GoogleFonts.sora(fontSize: 9, fontWeight: FontWeight.w700),
        unselectedLabelStyle: GoogleFonts.sora(fontSize: 9, fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
      ),

      // ── Divider ─────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.aqua50,
        thickness: 1,
        space: 0,
      ),
    );
  }
}