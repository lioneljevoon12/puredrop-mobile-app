import 'package:flutter/material.dart';

/// Semua warna PUREDROP diekstrak langsung dari prototype HTML.
/// Jangan hardcode warna di widget — selalu pakai class ini.
class AppColors {
  AppColors._();

  // ── Aqua Palette ──────────────────────────────────────────────────────────
  static const aqua50  = Color(0xFFF0F8FC);
  static const aqua100 = Color(0xFFDCF0FB);
  static const aqua200 = Color(0xFFB9E1F6);
  static const aqua300 = Color(0xFF86CDEE);
  static const aqua400 = Color(0xFF4FB3E3);
  static const aqua500 = Color(0xFF2A96D4); // primary
  static const aqua600 = Color(0xFF1C77B4);
  static const aqua700 = Color(0xFF1A608F);

  // ── Teal Palette ──────────────────────────────────────────────────────────
  static const teal400 = Color(0xFF36C9C0);
  static const teal500 = Color(0xFF16B0A8); // secondary / accent

  // ── Ink (Text) ────────────────────────────────────────────────────────────
  static const ink     = Color(0xFF0D2A3F); // body text
  static const inkSoft = Color(0xFF4A647A); // muted / label

  // ── Neutral ───────────────────────────────────────────────────────────────
  static const white   = Color(0xFFFFFFFF);
  static const bgLight = Color(0xFFEEF6FB); // scaffold background
  static const tabBar  = Color(0xFFAAB9C6); // inactive tab icon

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [aqua500, aqua600, aqua700],
  );

  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [teal400, aqua600],
  );

  static const LinearGradient ringCardGradient = LinearGradient(
    begin: Alignment(-0.5, -0.5),
    end: Alignment(1, 1),
    colors: [aqua500, aqua600, aqua700],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE6F4FC), Color(0xFFE0F6F3), bgLight],
  );

  // ── Shadows ───────────────────────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0xFF14608F).withOpacity(0.30),
      blurRadius: 14,
      offset: const Offset(0, 4),
      spreadRadius: -6,
    ),
  ];

  static List<BoxShadow> get strongShadow => [
    BoxShadow(
      color: const Color(0xFF14608F).withOpacity(0.35),
      blurRadius: 30,
      offset: const Offset(0, 10),
      spreadRadius: -12,
    ),
  ];
}
