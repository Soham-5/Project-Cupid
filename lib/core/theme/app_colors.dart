import 'package:flutter/material.dart';

/// Design tokens extracted directly from the moodboard reference swatches.
class AppColors {
  AppColors._();

  // Primary Palette
  static const Color cream = Color(0xFFECE5D8); // Paper / Light background
  static const Color creamLight = Color(0xFFF7F4EE); // Polaroid photo border / subtle highlight
  static const Color nearBlack = Color(0xFF0C0B0B); // Dark screen background / text
  static const Color cardDark = Color(0xFF191817); // Dark torn cards
  static const Color cardDarkBorder = Color(0xFF2C2A29);

  // Vibrant Collage Accents
  static const Color lavender = Color(0xFFA98BE8); // Plan idea torn card / purple burst
  static const Color lime = Color(0xFFC8E65A); // "her vibe", "cool?" circle, smiley
  static const Color pink = Color(0xFFF277C6); // "FUNKY", "+" button, hearts
  static const Color stickyYellow = Color(0xFFFBE474); // "COLLAGE of moments" yellow

  // Collage Materials
  static const Color tape = Color(0x75E3DAC9); // Translucent parchment tape strip
  static const Color tapeDark = Color(0x50C5BAA8);
  static const Color paperShadow = Color(0x28000000);
  static const Color cardShadow = Color(0x40000000);

  // Micro Doodles
  static const Color scribblePink = Color(0xFFF277C6);
  static const Color scribbleLime = Color(0xFFC8E65A);
  static const Color doodleDark = Color(0xFF1E1D1D);
}
