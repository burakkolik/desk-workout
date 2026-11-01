import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Living background: slowly drifting colour orbs over the base colour.
class AppBackground extends StatefulWidget {
  const AppBackground({super.key, required this.child, this.colors});

  final Widget child;
  final List<Color>? colors;

  @override
  State<AppBackground> createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 24))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors ?? const [AppColors.teal, AppColors.blue, AppColors.violet];
    return Stack(
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _c,
              builder: (context, _) => CustomPaint(painter: _OrbPainter(_c.value, colors)),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter(this.t, this.colors);

  final double t;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.bg);
    final s = math.max(size.width, size.height);
    final a = t * math.pi * 2;
    final orbs = [
      (
        Offset(size.width * (0.15 + 0.08 * math.sin(a)), size.height * (0.08 + 0.05 * math.cos(a))),
        s * 0.55,
        colors[0],
        0.16,
      ),
      (
        Offset(size.width * (0.95 + 0.06 * math.cos(a)), size.height * (0.35 + 0.08 * math.sin(a))),
        s * 0.5,
        colors[1],
        0.14,
      ),
      (
        Offset(size.width * (0.3 + 0.1 * math.cos(a + 1)), size.height * (1.0 + 0.04 * math.sin(a))),
        s * 0.6,
        colors[2 % colors.length],
        0.12,
      ),
    ];
    for (final (c, r, color, alpha) in orbs) {
      canvas.drawCircle(
        c,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withValues(alpha: alpha),
              color.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: c, radius: r)),
      );
    }
    // Fine grain dots for texture.
    final dot = Paint()..color = Colors.white.withValues(alpha: 0.035);
    final rnd = math.Random(7);
    for (var i = 0; i < 70; i++) {
      final p = Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height);
      final drift = math.sin(a * 2 + i) * 4;
      canvas.drawCircle(p + Offset(0, drift), 1 + rnd.nextDouble(), dot);
    }
  }

  @override
  bool shouldRepaint(_OrbPainter old) => old.t != t;
}
