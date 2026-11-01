import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

enum Food { nuts, fruit, yogurt, veggies, eggs, chickpeas }

/// Detailed, hand-coded food illustrations for the snack cards.
class FoodArt extends StatelessWidget {
  const FoodArt(this.food, {super.key});

  final Food food;

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _FoodPainter(food), size: Size.infinite);
}

class _FoodPainter extends CustomPainter {
  _FoodPainter(this.food);

  final Food food;

  static const _outline = Color(0x660B1020);

  Paint _grad(Rect r, Color a, Color b) => Paint()..shader = ui.Gradient.linear(r.topLeft, r.bottomRight, [a, b]);

  @override
  void paint(Canvas canvas, Size size) {
    final s = math.min(size.width, size.height);
    canvas.translate((size.width - s) / 2, (size.height - s) / 2);
    canvas.scale(s / 100);
    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = _outline;
    // Soft plate shadow.
    canvas.drawOval(const Rect.fromLTWH(14, 78, 72, 12), Paint()..color = const Color(0x44000000));

    switch (food) {
      case Food.nuts:
        _bowl(canvas, const Color(0xFF8E6CFF));
        final rnd = math.Random(5);
        for (var i = 0; i < 14; i++) {
          final c = Offset(30 + rnd.nextDouble() * 40, 44 + rnd.nextDouble() * 16 - (i > 9 ? 8 : 0));
          final a = rnd.nextDouble() * math.pi;
          canvas.save();
          canvas.translate(c.dx, c.dy);
          canvas.rotate(a);
          if (i.isEven) {
            // Almond.
            final p = Path()
              ..moveTo(-9, 0)
              ..quadraticBezierTo(0, -7, 9, 0)
              ..quadraticBezierTo(0, 7, -9, 0);
            canvas.drawPath(
              p,
              _grad(const Rect.fromLTWH(-9, -6, 18, 12), const Color(0xFFD9A066), const Color(0xFF9C6232)),
            );
            canvas.drawPath(p, outline);
            canvas.drawLine(
              const Offset(-5, 0),
              const Offset(5, 0),
              Paint()
                ..color = const Color(0x55FFFFFF)
                ..strokeWidth = 1,
            );
          } else {
            // Walnut half.
            final r = const Rect.fromLTWH(-8, -7, 16, 14);
            canvas.drawOval(r, _grad(r, const Color(0xFFC79A6B), const Color(0xFF7D5533)));
            canvas.drawOval(r, outline);
            final w = Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.2
              ..color = const Color(0x885A3A1E);
            canvas.drawArc(const Rect.fromLTWH(-6, -5, 6, 10), -1.5, 3, false, w);
            canvas.drawArc(const Rect.fromLTWH(0, -5, 6, 10), 1.6, 3, false, w);
          }
          canvas.restore();
        }
        _bowlFront(canvas, const Color(0xFF8E6CFF));
      case Food.fruit:
        // Apple.
        final apple = Path()
          ..moveTo(50, 30)
          ..cubicTo(38, 20, 16, 26, 18, 50)
          ..cubicTo(20, 72, 36, 84, 44, 82)
          ..quadraticBezierTo(50, 80, 56, 82)
          ..cubicTo(64, 84, 80, 72, 82, 50)
          ..cubicTo(84, 26, 62, 20, 50, 30)
          ..close();
        canvas.drawPath(
          apple,
          Paint()
            ..shader = ui.Gradient.radial(
              const Offset(38, 42),
              50,
              [const Color(0xFFFF8A7A), const Color(0xFFE5383B), const Color(0xFF9D0208)],
              [0, 0.55, 1],
            ),
        );
        canvas.drawPath(apple, outline);
        canvas.drawOval(const Rect.fromLTWH(28, 36, 10, 16), Paint()..color = const Color(0x66FFFFFF));
        canvas.drawLine(
          const Offset(50, 30),
          const Offset(53, 16),
          Paint()
            ..color = const Color(0xFF6B4226)
            ..strokeWidth = 3.4
            ..strokeCap = StrokeCap.round,
        );
        final leaf = Path()
          ..moveTo(53, 20)
          ..quadraticBezierTo(64, 8, 76, 14)
          ..quadraticBezierTo(66, 26, 53, 20)
          ..close();
        canvas.drawPath(
          leaf,
          _grad(const Rect.fromLTWH(53, 8, 24, 18), const Color(0xFFA6F25C), const Color(0xFF2D9C4A)),
        );
        canvas.drawPath(leaf, outline);
        canvas.drawLine(
          const Offset(55, 20),
          const Offset(72, 15),
          Paint()
            ..color = const Color(0x552D6A1F)
            ..strokeWidth = 1,
        );
      case Food.yogurt:
        _bowl(canvas, const Color(0xFF5CC8FF));
        final top = Path()..addOval(const Rect.fromLTWH(18, 38, 64, 20));
        canvas.drawPath(top, Paint()..color = const Color(0xFFF7F5EF));
        canvas.drawPath(top, outline);
        canvas.drawArc(
          const Rect.fromLTWH(30, 41, 40, 12),
          0.2,
          2.6,
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.4
            ..color = const Color(0x22000000),
        );
        final berries = [
          (const Offset(38, 46), const Color(0xFF4C3FB0)),
          (const Offset(48, 43), const Color(0xFFE5383B)),
          (const Offset(58, 47), const Color(0xFF4C3FB0)),
          (const Offset(44, 51), const Color(0xFFFF6B9D)),
          (const Offset(64, 44), const Color(0xFFE5383B)),
          (const Offset(54, 52), const Color(0xFF4C3FB0)),
        ];
        for (final (c, col) in berries) {
          canvas.drawCircle(
            c,
            4.6,
            Paint()
              ..shader = ui.Gradient.radial(c - const Offset(1.5, 1.5), 5, [Color.lerp(col, Colors.white, 0.4)!, col]),
          );
          canvas.drawCircle(c - const Offset(1.4, 1.4), 1.1, Paint()..color = const Color(0xAAFFFFFF));
        }
        _bowlFront(canvas, const Color(0xFF5CC8FF));
      case Food.veggies:
        // Hummus cup.
        final cup = Path()
          ..moveTo(52, 58)
          ..lineTo(86, 58)
          ..lineTo(82, 84)
          ..lineTo(56, 84)
          ..close();
        canvas.drawPath(
          cup,
          _grad(const Rect.fromLTWH(52, 58, 34, 26), const Color(0xFFFFC857), const Color(0xFFE09F3E)),
        );
        canvas.drawPath(cup, outline);
        canvas.drawOval(const Rect.fromLTWH(52, 53, 34, 10), Paint()..color = const Color(0xFFF3D9A4));
        canvas.drawOval(const Rect.fromLTWH(52, 53, 34, 10), outline);
        canvas.drawCircle(const Offset(66, 57), 2, Paint()..color = const Color(0xFFB5651D));
        // Carrot sticks + cucumber.
        void stick(Offset a, Offset b, Color c1, Color c2, double w) {
          final p = Paint()
            ..shader = ui.Gradient.linear(a, b, [c1, c2])
            ..strokeWidth = w
            ..strokeCap = StrokeCap.round;
          canvas.drawLine(a, b, p);
        }
        stick(const Offset(20, 84), const Offset(46, 24), const Color(0xFFFF7A1A), const Color(0xFFFFA94D), 8);
        stick(const Offset(30, 86), const Offset(60, 30), const Color(0xFFFF7A1A), const Color(0xFFFFB86B), 7);
        stick(const Offset(14, 80), const Offset(30, 30), const Color(0xFF2D9C4A), const Color(0xFFA6F25C), 8);
        for (final y in [40.0, 52.0, 64.0]) {
          canvas.drawLine(
            Offset(40 - (y - 40) * 0.4, y),
            Offset(46 - (y - 40) * 0.4, y + 1),
            Paint()
              ..color = const Color(0x55B34700)
              ..strokeWidth = 1,
          );
        }
      case Food.eggs:
        _plate(canvas);
        for (final (dx, rot) in [(36.0, -0.2), (62.0, 0.25)]) {
          canvas.save();
          canvas.translate(dx, 52);
          canvas.rotate(rot);
          const egg = Rect.fromLTWH(-15, -20, 30, 40);
          canvas.drawOval(
            egg,
            Paint()..shader = ui.Gradient.radial(const Offset(-5, -8), 26, [Colors.white, const Color(0xFFE9E3D5)]),
          );
          canvas.drawOval(egg, outline);
          if (dx > 50) {
            canvas.drawCircle(
              const Offset(0, 4),
              9,
              Paint()
                ..shader = ui.Gradient.radial(const Offset(-2, 2), 10, [
                  const Color(0xFFFFE066),
                  const Color(0xFFFFB703),
                ]),
            );
          }
          canvas.restore();
        }
      case Food.chickpeas:
        _bowl(canvas, const Color(0xFFFF7A59));
        final rnd = math.Random(9);
        for (var i = 0; i < 22; i++) {
          final c = Offset(26 + rnd.nextDouble() * 48, 40 + rnd.nextDouble() * 18);
          canvas.drawCircle(
            c,
            5.2,
            Paint()
              ..shader = ui.Gradient.radial(c - const Offset(2, 2), 6, [
                const Color(0xFFF7D9A0),
                const Color(0xFFD4A04C),
              ]),
          );
          canvas.drawCircle(c, 5.2, outline..strokeWidth = 1);
          canvas.drawArc(
            Rect.fromCircle(center: c, radius: 3),
            0.5,
            1.6,
            false,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.9
              ..color = const Color(0x66905A1E),
          );
        }
        _bowlFront(canvas, const Color(0xFFFF7A59));
    }
  }

  void _plate(Canvas canvas) {
    const r = Rect.fromLTWH(10, 60, 80, 24);
    canvas.drawOval(r, Paint()..color = const Color(0xFFE6EBF7));
    canvas.drawOval(r.deflate(6), Paint()..color = const Color(0xFFF7F9FF));
    canvas.drawOval(
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = _outline,
    );
  }

  void _bowl(Canvas canvas, Color c) {
    // Inner back of the bowl.
    canvas.drawOval(const Rect.fromLTWH(14, 36, 72, 24), Paint()..color = Color.lerp(c, Colors.black, 0.45)!);
  }

  void _bowlFront(Canvas canvas, Color c) {
    final front = Path()
      ..moveTo(14, 48)
      ..quadraticBezierTo(16, 86, 50, 86)
      ..quadraticBezierTo(84, 86, 86, 48)
      ..quadraticBezierTo(50, 66, 14, 48)
      ..close();
    canvas.drawPath(
      front,
      Paint()
        ..shader = ui.Gradient.linear(
          const Offset(14, 50),
          const Offset(86, 86),
          [Color.lerp(c, Colors.white, 0.25)!, c, Color.lerp(c, Colors.black, 0.3)!],
          [0, 0.5, 1],
        ),
    );
    canvas.drawPath(
      front,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = _outline,
    );
    canvas.drawArc(
      const Rect.fromLTWH(22, 56, 56, 26),
      2.0,
      1.0,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round
        ..color = const Color(0x66FFFFFF),
    );
  }

  @override
  bool shouldRepaint(_FoodPainter old) => old.food != food;
}
