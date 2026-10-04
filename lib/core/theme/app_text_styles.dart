import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Central typography system implementing:
/// - Hand-drawn marker uppercase for headings
/// - Fluid cursive handwriting for annotations & accents
/// - Minimal modern sans-serif for body & tags
class AppTextStyles {
  AppTextStyles._();

  /// Hand-drawn marker style font for card titles and names
  static TextStyle markerHeading({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w800,
    Color color = AppColors.nearBlack,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.caveatBrush(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  /// Secondary marker uppercase font alternative (Patrick Hand SC)
  static TextStyle markerSc({
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.nearBlack,
    double letterSpacing = 1.0,
  }) {
    return GoogleFonts.patrickHandSc(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  /// Casual, organic cursive handwriting for annotations, subtitles & prompts
  static TextStyle handwritten({
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w600,
    Color color = AppColors.nearBlack,
    double height = 1.15,
  }) {
    return GoogleFonts.caveat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// Clean, minimal modern sans for metadata, tags, counts, and descriptions
  static TextStyle bodySans({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w500,
    Color color = AppColors.nearBlack,
    double letterSpacing = 0.2,
    double height = 1.3,
  }) {
    return GoogleFonts.dmSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// Pill button text (bold, modern sans or stylized)
  static TextStyle buttonText({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.cream,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.caveat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}
