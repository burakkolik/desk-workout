import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

import '../domain/exercise_visual.dart';
import 'paint_kit.dart';

/// Breathing guide: a glowing, breathing orb with a stylised pair of lungs.
/// Box breathing additionally traces a rounded square.
class BreathPainter extends CustomPainter {
  BreathPainter({required this.pose, required this.box, required this.time, required this.color});

  final BreathPose pose;
  final bool box;
  final double time;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final s = math.min(size.width, size.height);
    final fill = pose.fill.clamp(0.0, 1.0);

    // Outer halo rings.
    for (var i = 0; i < 3; i++) {
      final r = s * (0.26 + fill * 0.12 + i * 0.05);
      canvas.drawCircle(c, r, PaintKit.stroke(color.withValues(alpha: 0.18 - i * 0.05), s * 0.004));
    }
    // Orb.
    final r = s * (0.18 + fill * 0.12);
    canvas.drawCircle(
      c,
      r * 1.5,
      Paint()..shader = ui.Gradient.radial(c, r * 1.5, [color.withValues(alpha: 0.35), color.withValues(alpha: 0)]),
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = ui.Gradient.radial(
          c - Offset(r * 0.3, r * 0.4),
          r * 1.4,
          [PaintKit.tint(color, 0.55), color, PaintKit.shade(color, 0.45)],
          const [0, 0.5, 1],
        ),
    );

    // Lungs inside the orb.
    _lungs(canvas, c, r * 0.95, fill);

    // Particles drifting with the breath.
    for (var i = 0; i < 14; i++) {
      final a = i / 14 * math.pi * 2 + time * 0.3;
      final d = r * (1.25 + 0.35 * math.sin(time * 1.3 + i)) + fill * s * 0.04;
      final p = c + Offset(math.cos(a), math.sin(a)) * d;
      canvas.drawCircle(p, s * 0.006, Paint()..color = color.withValues(alpha: 0.5));
    }

    if (box) _box(canvas, c, s);
  }

  void _lungs(Canvas canvas, Offset c, double r, double fill) {
    final scale = 0.82 + fill * 0.18;
    final paint = Paint()..color = const Color(0xFFFFFFFF).withValues(alpha: 0.85);
    for (final side in [-1.0, 1.0]) {
      final lobe = Path()
        ..moveTo(c.dx + side * r * 0.08, c.dy - r * 0.32)
        ..cubicTo(
          c.dx + side * r * 0.62 * scale,
          c.dy - r * 0.55 * scale,
          c.dx + side * r * 0.72 * scale,
          c.dy + r * 0.45 * scale,
          c.dx + side * r * 0.42 * scale,
          c.dy + r * 0.52 * scale,
        )
        ..cubicTo(
          c.dx + side * r * 0.2,
          c.dy + r * 0.56 * scale,
          c.dx + side * r * 0.1,
          c.dy + r * 0.3,
          c.dx + side * r * 0.08,
          c.dy - r * 0.32,
        )
        ..close();
      canvas.drawPath(lobe, paint);
      // Bronchi.
      canvas.drawPath(
        Path()
          ..moveTo(c.dx, c.dy - r * 0.2)
          ..quadraticBezierTo(c.dx + side * r * 0.12, c.dy, c.dx + side * r * 0.28, c.dy + r * 0.12),
        PaintKit.stroke(PaintKit.shade(color, 0.2), r * 0.05),
      );
    }
    canvas.drawLine(
      Offset(c.dx, c.dy - r * 0.62),
      Offset(c.dx, c.dy - r * 0.18),
      PaintKit.stroke(const Color(0xFFFFFFFF).withValues(alpha: 0.85), r * 0.09),
    );
  }

  void _box(Canvas canvas, Offset c, double s) {
    final half = s * 0.44;
    final rect = Rect.fromCenter(center: c, width: half * 2, height: half * 2);
    final rr = RRect.fromRectAndRadius(rect, Radius.circular(s * 0.06));
    canvas.drawRRect(rr, PaintKit.stroke(color.withValues(alpha: 0.2), s * 0.012));
    // Progress along the square: bottom-left -> top-left -> top-right -> bottom-right -> back.
    final corners = [rect.bottomLeft, rect.topLeft, rect.topRight, rect.bottomRight, rect.bottomLeft];
    final prog = pose.corner.clamp(0.0, 4.0);
    final seg = prog.floor().clamp(0, 3);
    final t = prog - seg;
    final path = Path()..moveTo(corners[0].dx, corners[0].dy);
    for (var i = 0; i < seg; i++) {
      path.lineTo(corners[i + 1].dx, corners[i + 1].dy);
    }
    final dot = Offset.lerp(corners[seg], corners[seg + 1], t)!;
    path.lineTo(dot.dx, dot.dy);
    canvas.drawPath(path, PaintKit.stroke(color, s * 0.014));
    canvas.drawCircle(
      dot,
      s * 0.05,
      Paint()..shader = ui.Gradient.radial(dot, s * 0.05, [color.withValues(alpha: 0.7), color.withValues(alpha: 0)]),
    );
    canvas.drawCircle(dot, s * 0.018, PaintKit.fill(const Color(0xFFFFFFFF)));
  }

  @override
  bool shouldRepaint(BreathPainter old) => true;
}
