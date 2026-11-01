import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Animated gradient progress ring.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 140,
    this.stroke = 14,
    this.colors = const [AppColors.teal, AppColors.blue, AppColors.violet],
    this.child,
    this.animate = true,
  });

  final double progress;
  final double size;
  final double stroke;
  final List<Color> colors;
  final Widget? child;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
      duration: animate ? const Duration(milliseconds: 1400) : Duration.zero,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _RingPainter(v, stroke, colors),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.v, this.stroke, this.colors);

  final double v;
  final double stroke;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final r = rect.deflate(stroke / 2);
    canvas.drawArc(
      r,
      0,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = Colors.white.withValues(alpha: 0.07),
    );
    if (v <= 0) return;
    final sweep = math.pi * 2 * v;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: math.pi * 2,
        colors: [...colors, colors.first],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect);
    // Glow
    canvas.drawArc(
      r,
      -math.pi / 2,
      sweep,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke * 1.6
        ..strokeCap = StrokeCap.round
        ..color = colors.first.withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    canvas.drawArc(r, -math.pi / 2, sweep, false, paint);
    // Head dot
    final a = -math.pi / 2 + sweep;
    final c = r.center + Offset(math.cos(a), math.sin(a)) * (r.width / 2);
    canvas.drawCircle(c, stroke * 0.32, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.v != v;
}
