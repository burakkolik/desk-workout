import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// The Desk Workout mark: a seated person stretching both arms up above a
/// desk line, inside a gradient squircle. [progress] (0..1) draws it in.
class LogoMark extends StatelessWidget {
  const LogoMark({super.key, this.size = 120, this.progress = 1, this.glow = true});

  final double size;
  final double progress;
  final bool glow;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size.square(size),
    painter: LogoPainter(progress, glow: glow),
  );
}

class LogoPainter extends CustomPainter {
  LogoPainter(this.t, {this.glow = true, this.square = false, this.background = true, this.figureScale = 1});

  final double t;
  final bool glow;

  /// Full-bleed square background (store icon) instead of a squircle.
  final bool square;

  /// Draw the gradient background (false = transparent adaptive foreground).
  final bool background;

  /// Scale of the figure around the centre (adaptive icon safe zone).
  final double figureScale;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final rect = Offset.zero & size;
    final bgT = Curves.easeOutBack.transform((t * 2).clamp(0.0, 1.0));
    canvas.save();
    canvas.translate(s / 2, s / 2);
    canvas.scale(0.6 + 0.4 * bgT);
    canvas.translate(-s / 2, -s / 2);
    final rr = RRect.fromRectAndRadius(rect, Radius.circular(square ? 0 : s * 0.28));
    if (background && glow) {
      canvas.drawRRect(
        rr.inflate(s * 0.04),
        Paint()
          ..color = AppColors.teal.withValues(alpha: 0.35 * bgT)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, s * 0.12),
      );
    }
    if (background) {
      canvas.drawRRect(
        rr,
        Paint()
          ..shader = ui.Gradient.linear(rect.topLeft, rect.bottomRight, [
            AppColors.teal.withValues(alpha: bgT),
            AppColors.blue.withValues(alpha: bgT),
          ]),
      );
      // Gloss.
      canvas.drawRRect(
        rr,
        Paint()
          ..shader = ui.Gradient.linear(rect.topCenter, rect.center, [
            Colors.white.withValues(alpha: 0.22 * bgT),
            Colors.white.withValues(alpha: 0),
          ]),
      );
    }
    canvas.restore();

    // Figure (scaled around the centre for icon safe zones).
    canvas.save();
    canvas.translate(s / 2, s / 2);
    canvas.scale(figureScale);
    canvas.translate(-s / 2, -s / 2);
    final draw = ((t - 0.25) / 0.75).clamp(0.0, 1.0);
    if (draw <= 0) {
      canvas.restore();
      return;
    }
    final stroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.075
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    Offset p(double x, double y) => Offset(x * s, y * s);

    // Body path: left hand -> shoulder -> right hand, torso, seat, legs.
    final arms = Path()
      ..moveTo(p(0.27, 0.2).dx, p(0.27, 0.2).dy)
      ..quadraticBezierTo(p(0.36, 0.4).dx, p(0.36, 0.4).dy, p(0.47, 0.45).dx, p(0.47, 0.45).dy)
      ..quadraticBezierTo(p(0.6, 0.4).dx, p(0.6, 0.4).dy, p(0.69, 0.2).dx, p(0.69, 0.2).dy);
    final body = Path()
      ..moveTo(p(0.47, 0.42).dx, p(0.47, 0.42).dy)
      ..lineTo(p(0.44, 0.63).dx, p(0.44, 0.63).dy)
      ..lineTo(p(0.64, 0.63).dx, p(0.64, 0.63).dy)
      ..lineTo(p(0.64, 0.78).dx, p(0.64, 0.78).dy);
    _partial(canvas, arms, draw, stroke);
    _partial(canvas, body, draw, stroke);
    // Desk line.
    final desk = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.05
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(p(0.22, 0.82), p(0.22 + 0.56 * draw, 0.82), desk);
    // Head pops in last.
    final headT = Curves.elasticOut.transform(((t - 0.7) / 0.3).clamp(0.0, 1.0));
    if (headT > 0) {
      canvas.drawCircle(p(0.48, 0.27), s * 0.075 * headT, Paint()..color = Colors.white);
      // Little motion sparks around the hands.
      final spark = Paint()
        ..color = AppColors.amber.withValues(alpha: headT.clamp(0.0, 1.0))
        ..strokeWidth = s * 0.03
        ..strokeCap = StrokeCap.round;
      for (final c in [p(0.27, 0.2), p(0.69, 0.2)]) {
        for (var i = 0; i < 3; i++) {
          final a = -math.pi / 2 + (i - 1) * 0.7;
          final d = Offset(math.cos(a), math.sin(a));
          canvas.drawLine(c + d * s * 0.07, c + d * s * (0.07 + 0.05 * headT), spark);
        }
      }
    }
    canvas.restore();
  }

  void _partial(Canvas canvas, Path path, double t, Paint paint) {
    for (final m in path.computeMetrics()) {
      canvas.drawPath(m.extractPath(0, m.length * t), paint);
    }
  }

  @override
  bool shouldRepaint(LogoPainter old) => old.t != t;
}
