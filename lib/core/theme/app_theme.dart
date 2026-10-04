import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.cream,
      primaryColor: AppColors.nearBlack,
      colorScheme: const ColorScheme.light(
        primary: AppColors.nearBlack,
        secondary: AppColors.lavender,
        tertiary: AppColors.lime,
        surface: AppColors.cream,
        onPrimary: AppColors.cream,
        onSurface: AppColors.nearBlack,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: AppColors.nearBlack),
      ),
      textTheme: TextTheme(
        headlineMedium: AppTextStyles.markerHeading(),
        bodyMedium: AppTextStyles.bodySans(),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.nearBlack,
      primaryColor: AppColors.cream,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.cream,
        secondary: AppColors.lavender,
        tertiary: AppColors.lime,
        surface: AppColors.nearBlack,
        onPrimary: AppColors.nearBlack,
        onSurface: AppColors.cream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: AppColors.cream),
      ),
      textTheme: TextTheme(
        headlineMedium: AppTextStyles.markerHeading(color: AppColors.cream),
        bodyMedium: AppTextStyles.bodySans(color: AppColors.cream),
      ),
    );
  }
}
