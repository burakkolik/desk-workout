import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Animated glass with a sloshing wave and rising bubbles.
class WaterGlass extends StatefulWidget {
  const WaterGlass({super.key, required this.fill, this.color = AppColors.sky});

  /// 0..1
  final double fill;
  final Color color;

  @override
  State<WaterGlass> createState() => _WaterGlassState();
}

class _WaterGlassState extends State<WaterGlass> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: widget.fill.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutBack,
      builder: (context, fill, _) => AnimatedBuilder(
        animation: _c,
        builder: (context, _) => CustomPaint(painter: _GlassPainter(fill, _c.value, widget.color)),
      ),
    );
  }
}

class _GlassPainter extends CustomPainter {
  _GlassPainter(this.fill, this.t, this.color);

  final double fill;
  final double t;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = math.min(size.width, size.height * 0.75);
    final h = w / 0.75;
    final o = Offset((size.width - w) / 2, (size.height - h) / 2);
    Offset p(double x, double y) => o + Offset(x * w, y * h);
    final glass = Path()
      ..moveTo(p(0.08, 0.04).dx, p(0.08, 0.04).dy)
      ..lineTo(p(0.92, 0.04).dx, p(0.92, 0.04).dy)
      ..lineTo(p(0.80, 0.94).dx, p(0.80, 0.94).dy)
      ..quadraticBezierTo(p(0.79, 0.99).dx, p(0.79, 0.99).dy, p(0.72, 0.99).dx, p(0.72, 0.99).dy)
      ..lineTo(p(0.28, 0.99).dx, p(0.28, 0.99).dy)
      ..quadraticBezierTo(p(0.21, 0.99).dx, p(0.21, 0.99).dy, p(0.20, 0.94).dx, p(0.20, 0.94).dy)
      ..close();
    canvas.drawPath(glass, Paint()..color = Colors.white.withValues(alpha: 0.06));

    canvas.save();
    canvas.clipPath(glass);
    final level = 0.97 - fill.clamp(0.0, 1.05) * 0.88;
    final wave = Path()..moveTo(p(0, 1.1).dx, p(0, 1.1).dy);
    for (var i = 0; i <= 40; i++) {
      final x = i / 40;
      final y = level + math.sin((x * 2 + t * 2) * math.pi) * 0.018 * (fill > 0 ? 1 : 0);
      wave.lineTo(p(x, y).dx, p(x, y).dy);
    }
    wave
      ..lineTo(p(1, 1.1).dx, p(1, 1.1).dy)
      ..close();
    canvas.drawPath(
      wave,
      Paint()
        ..shader = ui.Gradient.linear(p(0, level), p(0, 1), [
          color.withValues(alpha: 0.95),
          Color.lerp(color, AppColors.blue, 0.6)!,
        ]),
    );
    // Second, lighter wave for depth.
    final wave2 = Path()..moveTo(p(0, 1.1).dx, p(0, 1.1).dy);
    for (var i = 0; i <= 40; i++) {
      final x = i / 40;
      final y = level + 0.01 + math.sin((x * 2.5 - t * 2) * math.pi + 1) * 0.015 * (fill > 0 ? 1 : 0);
      wave2.lineTo(p(x, y).dx, p(x, y).dy);
    }
    wave2
      ..lineTo(p(1, 1.1).dx, p(1, 1.1).dy)
      ..close();
    canvas.drawPath(wave2, Paint()..color = Colors.white.withValues(alpha: 0.12));
    // Bubbles.
    if (fill > 0.05) {
      final rnd = math.Random(11);
      for (var i = 0; i < 9; i++) {
        final x = 0.3 + rnd.nextDouble() * 0.4;
        final speed = 0.5 + rnd.nextDouble();
        final y = 0.98 - ((t * speed + rnd.nextDouble()) % 1) * (0.98 - level);
        canvas.drawCircle(
          p(x, y),
          w * (0.012 + rnd.nextDouble() * 0.012),
          Paint()..color = Colors.white.withValues(alpha: 0.35),
        );
      }
    }
    canvas.restore();
    // Glass outline + shine.
    canvas.drawPath(
      glass,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.035
        ..strokeJoin = StrokeJoin.round
        ..color = Colors.white.withValues(alpha: 0.55),
    );
    canvas.drawLine(
      p(0.2, 0.14),
      p(0.27, 0.8),
      Paint()
        ..strokeWidth = w * 0.04
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withValues(alpha: 0.22),
    );
  }

  @override
  bool shouldRepaint(_GlassPainter old) => true;
}
