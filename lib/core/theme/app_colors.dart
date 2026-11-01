import 'package:flutter/painting.dart';

/// Brand palette. Every colour used in the UI comes from here.
abstract final class AppColors {
  // Backgrounds
  static const bg = Color(0xFF080C18);
  static const bgElevated = Color(0xFF0E1426);
  static const surface = Color(0xFF151C33);
  static const surfaceHigh = Color(0xFF1D2644);
  static const stroke = Color(0xFF2A3458);

  // Accents
  static const teal = Color(0xFF2EE6C5);
  static const blue = Color(0xFF3D7BFF);
  static const violet = Color(0xFF9B7BFF);
  static const coral = Color(0xFFFF7A59);
  static const amber = Color(0xFFFFC857);
  static const lime = Color(0xFFA6F25C);
  static const sky = Color(0xFF5CC8FF);
  static const pink = Color(0xFFFF6B9D);

  // Text
  static const textPrimary = Color(0xFFF4F6FF);
  static const textSecondary = Color(0xFFB0B9DB);
  static const textMuted = Color(0xFF7A84AA);

  static const success = lime;
  static const danger = Color(0xFFFF5C7A);
}

/// Reusable gradients.
abstract final class AppGradients {
  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.teal, AppColors.blue],
  );

  static const energy = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.coral, AppColors.pink],
  );

  static const calm = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.violet, AppColors.blue],
  );

  static const sunrise = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.amber, AppColors.coral],
  );

  static const fresh = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.lime, AppColors.teal],
  );

  static LinearGradient of(Color c) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [c, Color.lerp(c, AppColors.blue, 0.55)!],
  );

  static const card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2240), Color(0xFF111833)],
  );
}
