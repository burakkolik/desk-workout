import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

/// Material theme. Typography is intentionally large for comfortable
/// reading at arm's length from a desk.
abstract final class AppTheme {
  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: AppColors.teal,
      onPrimary: AppColors.bg,
      secondary: AppColors.blue,
      onSecondary: AppColors.textPrimary,
      tertiary: AppColors.violet,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.danger,
    );
    const text = TextTheme(
      displayLarge: TextStyle(fontSize: 44, fontWeight: FontWeight.w800, letterSpacing: -1.2, height: 1.05),
      displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -1.0, height: 1.1),
      displaySmall: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.6, height: 1.12),
      headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.4, height: 1.15),
      headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.2, height: 1.2),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, height: 1.25),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, height: 1.3),
      titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, height: 1.3),
      bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, height: 1.5),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.45),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.4),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.2),
      labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.3),
      labelSmall: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, letterSpacing: 0.8),
    );
    final themed = text.apply(bodyColor: AppColors.textPrimary, displayColor: AppColors.textPrimary);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.bg,
      textTheme: themed,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {TargetPlatform.android: ZoomPageTransitionsBuilder()},
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.teal,
        thumbColor: AppColors.teal,
        inactiveTrackColor: AppColors.stroke,
      ),
      dividerColor: AppColors.stroke,
    );
  }
}
