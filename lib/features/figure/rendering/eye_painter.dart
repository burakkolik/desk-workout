import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../domain/exercise_visual.dart';
import 'paint_kit.dart';

/// Close-up illustration of a face's eye area: gaze, blinking, palming and
/// near/far focusing.
class EyePainter extends CustomPainter {
  EyePainter({required this.pose, this.showTarget = false, this.time = 0});

  final EyePose pose;
  final bool showTarget;
  final double time;

  static const _skin = Color(0xFFF4C7A3);
  static const _hair = Color(0xFF2A2140);
  static const _iris = Color(0xFF2EB8A6);
  static const _outline = Color(0x990A0F1E);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final s = math.min(w / 1.6, h / 1.1);
    final c = Offset(w / 2, h * 0.56);

    if (showTarget) _target(canvas, size, s);

    // Face patch.
    final face = RRect.fromRectAndRadius(
      Rect.fromCenter(center: c + Offset(0, s * 0.05), width: s * 1.5, height: s * 0.8),
      Radius.circular(s * 0.4),
    );
    canvas.drawRRect(
      face,
      Paint()
        ..shader = ui.Gradient.radial(
          c - Offset(0, s * 0.2),
          s,
          [PaintKit.tint(_skin, 0.15), _skin, PaintKit.shade(_skin, 0.18)],
          const [0, 0.6, 1],
        ),
    );
    // Nose bridge.
    canvas.drawPath(
      Path()
        ..moveTo(c.dx - s * 0.02, c.dy - s * 0.12)
        ..quadraticBezierTo(c.dx + s * 0.05, c.dy + s * 0.15, c.dx - s * 0.04, c.dy + s * 0.3),
      PaintKit.stroke(PaintKit.shade(_skin, 0.25), s * 0.012),
    );

    for (final side in [-1.0, 1.0]) {
      _eye(canvas, c + Offset(side * s * 0.36, 0), s * 0.5, side);
    }

    if (pose.palms > 0.01) _palms(canvas, c, s);
  }

  void _eye(Canvas canvas, Offset c, double s, double side) {
    final ew = s * 0.62;
    final eh = s * 0.34;
    final open = (pose.open * (1 - pose.squeeze * 0.6)).clamp(0.0, 1.0);

    // Brow.
    final browY = c.dy - eh * 0.95 - (pose.gazeY < 0 ? -pose.gazeY * eh * 0.15 : 0) + pose.squeeze * eh * 0.2;
    canvas.drawPath(
      Path()
        ..moveTo(c.dx - side * ew * 0.45, browY + eh * 0.12)
        ..quadraticBezierTo(c.dx, browY - eh * 0.2, c.dx + side * ew * 0.55, browY + eh * 0.05),
      PaintKit.stroke(_hair, s * 0.06),
    );

    // Almond shape.
    final top = c.dy - eh * 0.5 * open;
    final bottom = c.dy + eh * 0.5 * math.max(open, 0.05);
    final almond = Path()
      ..moveTo(c.dx - ew / 2, c.dy)
      ..quadraticBezierTo(c.dx, top - eh * 0.45 * open, c.dx + ew / 2, c.dy)
      ..quadraticBezierTo(c.dx, bottom + eh * 0.3 * open, c.dx - ew / 2, c.dy)
      ..close();

    if (open > 0.04) {
      canvas.save();
      canvas.clipPath(almond);
      canvas.drawPath(almond, PaintKit.fill(const Color(0xFFF8FAFF)));
      // Iris + pupil.
      final irisR = eh * 0.42;
      final ic = c + Offset(pose.gazeX * ew * 0.28, pose.gazeY * eh * 0.32);
      canvas.drawCircle(
        ic,
        irisR,
        Paint()
          ..shader = ui.Gradient.radial(
            ic,
            irisR,
            [PaintKit.tint(_iris, 0.25), _iris, PaintKit.shade(_iris, 0.45)],
            const [0, 0.6, 1],
          ),
      );
      final pupil = irisR * (0.36 + pose.far * 0.14);
      canvas.drawCircle(ic, pupil, PaintKit.fill(const Color(0xFF0B1020)));
      canvas.drawCircle(
        ic + Offset(-irisR * 0.35, -irisR * 0.35),
        irisR * 0.18,
        PaintKit.fill(const Color(0xDDFFFFFF)),
      );
      canvas.drawCircle(ic + Offset(irisR * 0.3, irisR * 0.25), irisR * 0.08, PaintKit.fill(const Color(0x88FFFFFF)));
      // Upper lid shadow.
      canvas.drawRect(
        Rect.fromLTRB(c.dx - ew, top - eh, c.dx + ew, top + eh * 0.18),
        Paint()
          ..shader = ui.Gradient.linear(Offset(c.dx, top - eh * 0.2), Offset(c.dx, top + eh * 0.25), [
            const Color(0x55000000),
            const Color(0x00000000),
          ]),
      );
      canvas.restore();
      canvas.drawPath(almond, PaintKit.stroke(_outline, s * 0.018));
      // Lashes (upper lid line).
      canvas.drawPath(
        Path()
          ..moveTo(c.dx - ew / 2, c.dy)
          ..quadraticBezierTo(c.dx, top - eh * 0.45 * open, c.dx + ew / 2, c.dy),
        PaintKit.stroke(_hair, s * 0.04),
      );
    } else {
      // Closed: curved lash line.
      canvas.drawPath(
        Path()
          ..moveTo(c.dx - ew / 2, c.dy)
          ..quadraticBezierTo(c.dx, c.dy + eh * (0.35 + pose.squeeze * 0.1), c.dx + ew / 2, c.dy),
        PaintKit.stroke(_hair, s * 0.045),
      );
      for (var i = 0; i < 4; i++) {
        final t = 0.2 + i * 0.2;
        final x = c.dx - ew / 2 + ew * t;
        final y = c.dy + eh * 0.33 * math.sin(math.pi * t) * (1 + pose.squeeze * 0.2);
        canvas.drawLine(Offset(x, y), Offset(x + side * ew * 0.02, y + eh * 0.15), PaintKit.stroke(_hair, s * 0.02));
      }
    }
  }

  void _palms(Canvas canvas, Offset c, double s) {
    final t = pose.palms;
    for (final side in [-1.0, 1.0]) {
      final from = c + Offset(side * s * 1.2, s * 0.9);
      final to = c + Offset(side * s * 0.38, s * 0.02);
      final p = Offset.lerp(from, to, Curves.easeOutCubic.transform(t))!;
      canvas.save();
      canvas.translate(p.dx, p.dy);
      canvas.rotate(side * 0.25);
      final palm = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: s * 0.62, height: s * 0.7),
        Radius.circular(s * 0.3),
      );
      canvas.drawRRect(
        palm,
        Paint()
          ..color = const Color(0xFFEDB892).withValues(alpha: t.clamp(0.0, 1.0))
          ..isAntiAlias = true,
      );
      // Fingers.
      for (var i = 0; i < 4; i++) {
        final x = (-0.2 + i * 0.135) * s;
        canvas.drawLine(
          Offset(x, -s * 0.32),
          Offset(x - side * s * 0.03, -s * 0.52),
          PaintKit.stroke(const Color(0xFFEDB892).withValues(alpha: t), s * 0.12),
        );
      }
      canvas.drawRRect(palm, PaintKit.stroke(_outline.withValues(alpha: 0.4 * t), s * 0.012));
      // Warmth glow.
      canvas.drawCircle(
        Offset.zero,
        s * 0.5,
        Paint()
          ..blendMode = BlendMode.plus
          ..shader = ui.Gradient.radial(Offset.zero, s * 0.5, [
            const Color(0x33FF9A6B).withValues(alpha: 0.2 * t),
            const Color(0x00FF9A6B),
          ]),
      );
      canvas.restore();
    }
  }

  /// Near target (finger) and far target (mountains) depending on focus.
  void _target(Canvas canvas, Size size, double s) {
    final far = pose.far;
    // Far scene: mountains + sun at the top.
    final horizon = size.height * 0.2;
    final farPaint = Paint()..color = const Color(0xFF8FA6FF).withValues(alpha: 0.25 + far * 0.6);
    final mountains = Path()
      ..moveTo(size.width * 0.15, horizon)
      ..lineTo(size.width * 0.32, horizon - s * 0.2)
      ..lineTo(size.width * 0.44, horizon - s * 0.08)
      ..lineTo(size.width * 0.56, horizon - s * 0.27)
      ..lineTo(size.width * 0.72, horizon - s * 0.05)
      ..lineTo(size.width * 0.85, horizon)
      ..close();
    if (far < 0.5) {
      farPaint.maskFilter = MaskFilter.blur(BlurStyle.normal, (0.5 - far) * 8);
    }
    canvas.drawPath(mountains, farPaint);
    canvas.drawCircle(
      Offset(size.width * 0.7, horizon - s * 0.3),
      s * 0.06,
      Paint()..color = const Color(0xFFFFC857).withValues(alpha: 0.3 + far * 0.6),
    );
    // Near target: a finger pointing up in the lower foreground.
    final near = 1 - far;
    final fp = Paint()
      ..color = const Color(0xFFEDB892).withValues(alpha: 0.35 + near * 0.6)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = s * 0.1;
    if (near < 0.5) fp.maskFilter = MaskFilter.blur(BlurStyle.normal, (0.5 - near) * 10);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 1.05), Offset(size.width * 0.5, size.height * 0.88), fp);
    // Focus ring.
    final ringC = Offset.lerp(
      Offset(size.width * 0.5, size.height * 0.88),
      Offset(size.width * 0.5, horizon - s * 0.12),
      far,
    )!;
    final pulse = 0.5 + 0.5 * math.sin(time * math.pi * 2);
    canvas.drawCircle(
      ringC,
      s * (0.1 + pulse * 0.02),
      PaintKit.stroke(const Color(0xFF9B7BFF).withValues(alpha: 0.7), s * 0.012),
    );
  }

  @override
  bool shouldRepaint(EyePainter old) => true;
}
