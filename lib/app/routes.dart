import 'package:flutter/material.dart';

/// Page transitions used across the app.
abstract final class AppRoutes {
  /// Smooth fade + subtle scale (default for pushed pages).
  static Route<T> fade<T>(Widget page) => PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 520),
    reverseTransitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, anim, _, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(scale: Tween(begin: 0.96, end: 1.0).animate(curved), child: child),
      );
    },
  );

  /// Slide up from the bottom (for the workout player).
  static Route<T> slideUp<T>(Widget page) => PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 420),
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, anim, _, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutQuart, reverseCurve: Curves.easeInCubic);
      return SlideTransition(
        position: Tween(begin: const Offset(0, 0.12), end: Offset.zero).animate(curved),
        child: FadeTransition(opacity: curved, child: child),
      );
    },
  );
}
