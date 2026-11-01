import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Hand-drawn icon set of the app (no icon fonts, no image assets).
enum DwIcons {
  home,
  grid,
  eye,
  leaf,
  chart,
  gear,
  play,
  pause,
  next,
  prev,
  close,
  check,
  flame,
  drop,
  clock,
  neck,
  shoulder,
  wrist,
  spine,
  legs,
  lungs,
  bulb,
  chevronRight,
  chevronLeft,
  arrowRight,
  plus,
  minus,
  globe,
  bell,
  sparkle,
  coffee,
  apple,
  monitor,
  trophy,
  heart,
  restart,
  info,
  target,
  bolt,
  chair,
}

/// Paints a [DwIcons] glyph. Duotone: strokes in [color], soft fills in a
/// translucent version of it.
class DwIcon extends StatelessWidget {
  const DwIcon(this.icon, {super.key, this.size = 24, this.color, this.strokeWidth = 1.9});

  final DwIcons icon;
  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final c = color ?? DefaultTextStyle.of(context).style.color ?? const Color(0xFFFFFFFF);
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: DwIconPainter(icon, c, strokeWidth)),
    );
  }
}

/// Public so other painters (e.g. store graphics) can reuse the glyphs.
class DwIconPainter extends CustomPainter {
  DwIconPainter(this.icon, this.color, [this.sw = 1.9]);

  final DwIcons icon;
  final Color color;
  final double sw;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24, size.height / 24);
    final st = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final fill = Paint()
      ..color = color.withValues(alpha: 0.22)
      ..isAntiAlias = true;
    final solid = Paint()
      ..color = color
      ..isAntiAlias = true;

    void line(double x1, double y1, double x2, double y2) => canvas.drawLine(Offset(x1, y1), Offset(x2, y2), st);
    void circle(double x, double y, double r, {bool filled = false, bool solidFill = false}) {
      if (solidFill) canvas.drawCircle(Offset(x, y), r, solid);
      if (filled) canvas.drawCircle(Offset(x, y), r, fill);
      if (!solidFill) canvas.drawCircle(Offset(x, y), r, st);
    }

    Path p() => Path();

    switch (icon) {
      case DwIcons.home:
        final h = p()
          ..moveTo(4, 10.5)
          ..lineTo(12, 4)
          ..lineTo(20, 10.5)
          ..lineTo(20, 19)
          ..quadraticBezierTo(20, 20.5, 18.5, 20.5)
          ..lineTo(5.5, 20.5)
          ..quadraticBezierTo(4, 20.5, 4, 19)
          ..close();
        canvas.drawPath(h, fill);
        canvas.drawPath(h, st);
        final door = RRect.fromLTRBR(9.8, 14, 14.2, 20.5, const Radius.circular(1.5));
        canvas.drawRRect(door, st);
      case DwIcons.grid:
        for (final o in const [Offset(4, 4), Offset(13.5, 4), Offset(4, 13.5), Offset(13.5, 13.5)]) {
          final r = RRect.fromRectAndRadius(Rect.fromLTWH(o.dx, o.dy, 6.5, 6.5), const Radius.circular(2));
          if (o == const Offset(13.5, 4)) canvas.drawRRect(r, fill);
          canvas.drawRRect(r, st);
        }
      case DwIcons.eye:
        final e = p()
          ..moveTo(2.5, 12)
          ..quadraticBezierTo(12, 2.5, 21.5, 12)
          ..quadraticBezierTo(12, 21.5, 2.5, 12)
          ..close();
        canvas.drawPath(e, fill);
        canvas.drawPath(e, st);
        circle(12, 12, 3.3);
        circle(12, 12, 1.2, solidFill: true);
      case DwIcons.leaf:
        final l = p()
          ..moveTo(5, 19)
          ..quadraticBezierTo(4, 6, 19.5, 4.5)
          ..quadraticBezierTo(19, 18.5, 5, 19)
          ..close();
        canvas.drawPath(l, fill);
        canvas.drawPath(l, st);
        canvas.drawPath(
          p()
            ..moveTo(4, 20)
            ..quadraticBezierTo(10, 13, 15, 9),
          st,
        );
      case DwIcons.chart:
        final bars = [
          RRect.fromLTRBR(4, 12, 8, 20, const Radius.circular(1.5)),
          RRect.fromLTRBR(10, 7, 14, 20, const Radius.circular(1.5)),
          RRect.fromLTRBR(16, 3.5, 20, 20, const Radius.circular(1.5)),
        ];
        canvas.drawRRect(bars[2], fill);
        for (final b in bars) {
          canvas.drawRRect(b, st);
        }
      case DwIcons.gear:
        final path = p();
        for (var i = 0; i < 16; i++) {
          final a = i / 16 * math.pi * 2;
          final r = i.isEven ? 9.0 : 7.0;
          final pt = Offset(12 + math.cos(a) * r, 12 + math.sin(a) * r);
          if (i == 0) {
            path.moveTo(pt.dx, pt.dy);
          } else {
            path.lineTo(pt.dx, pt.dy);
          }
        }
        path.close();
        canvas.drawPath(path, fill);
        canvas.drawPath(path, st);
        circle(12, 12, 3);
      case DwIcons.play:
        final t = p()
          ..moveTo(8, 5)
          ..lineTo(19, 12)
          ..lineTo(8, 19)
          ..close();
        canvas.drawPath(t, solid);
        canvas.drawPath(t, st);
      case DwIcons.pause:
        canvas.drawRRect(RRect.fromLTRBR(6.5, 5, 10, 19, const Radius.circular(1.5)), solid);
        canvas.drawRRect(RRect.fromLTRBR(14, 5, 17.5, 19, const Radius.circular(1.5)), solid);
      case DwIcons.next:
        final t = p()
          ..moveTo(6, 6)
          ..lineTo(15, 12)
          ..lineTo(6, 18)
          ..close();
        canvas.drawPath(t, solid);
        canvas.drawPath(t, st);
        line(18.5, 6, 18.5, 18);
      case DwIcons.prev:
        final t = p()
          ..moveTo(18, 6)
          ..lineTo(9, 12)
          ..lineTo(18, 18)
          ..close();
        canvas.drawPath(t, solid);
        canvas.drawPath(t, st);
        line(5.5, 6, 5.5, 18);
      case DwIcons.close:
        line(6, 6, 18, 18);
        line(18, 6, 6, 18);
      case DwIcons.check:
        canvas.drawPath(
          p()
            ..moveTo(5, 12.5)
            ..lineTo(10, 17.5)
            ..lineTo(19.5, 7),
          st,
        );
      case DwIcons.flame:
        final f = p()
          ..moveTo(12, 2.8)
          ..cubicTo(13, 7, 19, 9, 18.5, 15)
          ..cubicTo(18, 19.5, 14.5, 21.5, 12, 21.5)
          ..cubicTo(8, 21.5, 5.5, 18.5, 5.5, 15)
          ..cubicTo(5.5, 11.5, 8, 10, 8.5, 7.5)
          ..cubicTo(10, 9, 10.2, 10.5, 10, 12)
          ..cubicTo(12, 10, 12.5, 6, 12, 2.8)
          ..close();
        canvas.drawPath(f, fill);
        canvas.drawPath(f, st);
        final inner = p()
          ..moveTo(12, 14)
          ..cubicTo(14.5, 15.5, 14.5, 19, 12, 19)
          ..cubicTo(9.5, 19, 9.5, 16, 12, 14)
          ..close();
        canvas.drawPath(inner, solid);
      case DwIcons.drop:
        final d = p()
          ..moveTo(12, 3)
          ..cubicTo(15, 7.5, 18.5, 11, 18.5, 14.5)
          ..cubicTo(18.5, 18.5, 15.5, 21, 12, 21)
          ..cubicTo(8.5, 21, 5.5, 18.5, 5.5, 14.5)
          ..cubicTo(5.5, 11, 9, 7.5, 12, 3)
          ..close();
        canvas.drawPath(d, fill);
        canvas.drawPath(d, st);
        canvas.drawPath(
          p()
            ..moveTo(9, 14.5)
            ..quadraticBezierTo(9, 17.5, 12, 18),
          st,
        );
      case DwIcons.clock:
        circle(12, 12, 8.5, filled: true);
        line(12, 12, 12, 7.5);
        line(12, 12, 15.5, 14);
      case DwIcons.neck:
        circle(12, 6.5, 3.6, filled: true);
        canvas.drawPath(
          p()
            ..moveTo(10.2, 10)
            ..lineTo(10.2, 13)
            ..quadraticBezierTo(5, 13.5, 4, 19.5),
          st,
        );
        canvas.drawPath(
          p()
            ..moveTo(13.8, 10)
            ..lineTo(13.8, 13)
            ..quadraticBezierTo(19, 13.5, 20, 19.5),
          st,
        );
        canvas.drawArc(Rect.fromCircle(center: const Offset(12, 6.5), radius: 6.3), -2.6, 1.0, false, st);
      case DwIcons.shoulder:
        circle(12, 5.5, 3, filled: true);
        canvas.drawPath(
          p()
            ..moveTo(3.5, 20)
            ..lineTo(4.5, 13.5)
            ..quadraticBezierTo(5, 10.5, 8, 10.2)
            ..lineTo(16, 10.2)
            ..quadraticBezierTo(19, 10.5, 19.5, 13.5)
            ..lineTo(20.5, 20),
          st,
        );
        canvas.drawArc(Rect.fromCircle(center: const Offset(6, 10.5), radius: 3.6), 3.5, 1.6, false, st);
        canvas.drawArc(Rect.fromCircle(center: const Offset(18, 10.5), radius: 3.6), 4.3, 1.6, false, st);
      case DwIcons.wrist:
        final h = p()
          ..moveTo(8, 21)
          ..lineTo(8, 13)
          ..lineTo(5.5, 9.5)
          ..quadraticBezierTo(5, 8, 6.5, 8)
          ..lineTo(9, 10.5)
          ..lineTo(9, 4.5)
          ..quadraticBezierTo(10, 3.3, 11, 4.5)
          ..lineTo(11, 9)
          ..lineTo(11, 3.5)
          ..quadraticBezierTo(12, 2.3, 13, 3.5)
          ..lineTo(13, 9)
          ..lineTo(13, 4.5)
          ..quadraticBezierTo(14, 3.3, 15, 4.5)
          ..lineTo(15, 9.5)
          ..lineTo(15, 6.5)
          ..quadraticBezierTo(16, 5.3, 17, 6.5)
          ..lineTo(17, 13)
          ..quadraticBezierTo(17, 15.5, 16, 16.5)
          ..lineTo(16, 21);
        canvas.drawPath(h, fill);
        canvas.drawPath(h, st);
        line(7, 18, 17, 18);
      case DwIcons.spine:
        for (var i = 0; i < 5; i++) {
          final y = 3.5 + i * 3.6;
          final x = 12 + math.sin(i * 0.9) * 1.6;
          final r = RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(x, y), width: 7, height: 2.6),
            const Radius.circular(1.3),
          );
          canvas.drawRRect(r, i == 2 ? solid : fill);
          canvas.drawRRect(r, st);
        }
      case DwIcons.legs:
        canvas.drawPath(
          p()
            ..moveTo(8, 3)
            ..lineTo(7.5, 12)
            ..lineTo(9, 20)
            ..lineTo(5, 21),
          st,
        );
        canvas.drawPath(
          p()
            ..moveTo(15, 3)
            ..lineTo(16.5, 11)
            ..lineTo(15, 20)
            ..lineTo(19.5, 21),
          st,
        );
        circle(7.6, 12, 1.4, solidFill: true);
        circle(16.4, 11, 1.4, solidFill: true);
      case DwIcons.lungs:
        line(12, 3, 12, 11);
        for (final s in [-1.0, 1.0]) {
          final l = p()
            ..moveTo(12 + s * 1.8, 8)
            ..cubicTo(12 + s * 7, 5, 12 + s * 9.5, 13, 12 + s * 8.5, 18.5)
            ..quadraticBezierTo(12 + s * 8, 20.5, 12 + s * 5.5, 20)
            ..quadraticBezierTo(12 + s * 2, 19, 12 + s * 1.8, 14)
            ..close();
          canvas.drawPath(l, fill);
          canvas.drawPath(l, st);
        }
        canvas.drawPath(
          p()
            ..moveTo(9.5, 11)
            ..quadraticBezierTo(12, 9, 14.5, 11),
          st,
        );
      case DwIcons.bulb:
        final b = p()
          ..moveTo(9, 17)
          ..lineTo(9, 15)
          ..cubicTo(6.5, 13.5, 5.5, 11.5, 5.5, 9.5)
          ..cubicTo(5.5, 5.5, 8.5, 3, 12, 3)
          ..cubicTo(15.5, 3, 18.5, 5.5, 18.5, 9.5)
          ..cubicTo(18.5, 11.5, 17.5, 13.5, 15, 15)
          ..lineTo(15, 17)
          ..close();
        canvas.drawPath(b, fill);
        canvas.drawPath(b, st);
        line(9.5, 20.5, 14.5, 20.5);
        canvas.drawPath(
          p()
            ..moveTo(10.5, 11)
            ..lineTo(12, 13)
            ..lineTo(13.5, 11),
          st,
        );
      case DwIcons.chevronRight:
        canvas.drawPath(
          p()
            ..moveTo(9, 5)
            ..lineTo(16, 12)
            ..lineTo(9, 19),
          st,
        );
      case DwIcons.chevronLeft:
        canvas.drawPath(
          p()
            ..moveTo(15, 5)
            ..lineTo(8, 12)
            ..lineTo(15, 19),
          st,
        );
      case DwIcons.arrowRight:
        line(4, 12, 20, 12);
        canvas.drawPath(
          p()
            ..moveTo(14, 6)
            ..lineTo(20, 12)
            ..lineTo(14, 18),
          st,
        );
      case DwIcons.plus:
        line(12, 5, 12, 19);
        line(5, 12, 19, 12);
      case DwIcons.minus:
        line(5, 12, 19, 12);
      case DwIcons.globe:
        circle(12, 12, 8.5, filled: true);
        canvas.drawOval(Rect.fromCenter(center: const Offset(12, 12), width: 8, height: 17), st);
        line(3.5, 12, 20.5, 12);
        canvas.drawPath(
          p()
            ..moveTo(5, 7.5)
            ..quadraticBezierTo(12, 9.5, 19, 7.5),
          st,
        );
        canvas.drawPath(
          p()
            ..moveTo(5, 16.5)
            ..quadraticBezierTo(12, 14.5, 19, 16.5),
          st,
        );
      case DwIcons.bell:
        final b = p()
          ..moveTo(5, 17)
          ..quadraticBezierTo(6.5, 15, 6.5, 11)
          ..cubicTo(6.5, 6.5, 9, 4, 12, 4)
          ..cubicTo(15, 4, 17.5, 6.5, 17.5, 11)
          ..quadraticBezierTo(17.5, 15, 19, 17)
          ..close();
        canvas.drawPath(b, fill);
        canvas.drawPath(b, st);
        canvas.drawArc(Rect.fromCircle(center: const Offset(12, 18.5), radius: 2.2), 0, math.pi, false, st);
      case DwIcons.sparkle:
        final s = p()
          ..moveTo(12, 2.5)
          ..quadraticBezierTo(13, 11, 21.5, 12)
          ..quadraticBezierTo(13, 13, 12, 21.5)
          ..quadraticBezierTo(11, 13, 2.5, 12)
          ..quadraticBezierTo(11, 11, 12, 2.5)
          ..close();
        canvas.drawPath(s, fill);
        canvas.drawPath(s, st);
        circle(19, 5, 1.3, solidFill: true);
      case DwIcons.coffee:
        final cup = p()
          ..moveTo(4.5, 9)
          ..lineTo(16.5, 9)
          ..lineTo(15.5, 18)
          ..quadraticBezierTo(15.2, 20, 13, 20)
          ..lineTo(8, 20)
          ..quadraticBezierTo(5.8, 20, 5.5, 18)
          ..close();
        canvas.drawPath(cup, fill);
        canvas.drawPath(cup, st);
        canvas.drawArc(Rect.fromCircle(center: const Offset(17, 12.5), radius: 2.6), -1.4, 2.8, false, st);
        for (final x in [8.0, 11.5]) {
          canvas.drawPath(
            p()
              ..moveTo(x, 6.5)
              ..quadraticBezierTo(x - 1.2, 5, x, 3.5),
            st,
          );
        }
      case DwIcons.apple:
        final a = p()
          ..moveTo(12, 7.5)
          ..cubicTo(9, 5.5, 4.5, 6.5, 4.5, 12)
          ..cubicTo(4.5, 17, 8, 21, 10, 21)
          ..quadraticBezierTo(12, 20.3, 14, 21)
          ..cubicTo(16, 21, 19.5, 17, 19.5, 12)
          ..cubicTo(19.5, 6.5, 15, 5.5, 12, 7.5)
          ..close();
        canvas.drawPath(a, fill);
        canvas.drawPath(a, st);
        canvas.drawPath(
          p()
            ..moveTo(12, 7.5)
            ..quadraticBezierTo(12, 4.5, 14, 3),
          st,
        );
        canvas.drawPath(
          p()
            ..moveTo(12.5, 5.5)
            ..quadraticBezierTo(16, 3, 18, 5)
            ..quadraticBezierTo(15.5, 7, 12.5, 5.5),
          solid,
        );
      case DwIcons.monitor:
        final m = RRect.fromLTRBR(3, 4, 21, 16, const Radius.circular(2));
        canvas.drawRRect(m, fill);
        canvas.drawRRect(m, st);
        line(12, 16, 12, 20);
        line(8, 20.5, 16, 20.5);
      case DwIcons.trophy:
        final cup = p()
          ..moveTo(7, 4)
          ..lineTo(17, 4)
          ..lineTo(17, 9)
          ..cubicTo(17, 12.5, 14.5, 14.5, 12, 14.5)
          ..cubicTo(9.5, 14.5, 7, 12.5, 7, 9)
          ..close();
        canvas.drawPath(cup, fill);
        canvas.drawPath(cup, st);
        canvas.drawArc(Rect.fromLTRB(3.5, 5, 8, 10.5), 1.5, 3.2, false, st);
        canvas.drawArc(Rect.fromLTRB(16, 5, 20.5, 10.5), -1.6, 3.2, false, st);
        line(12, 14.5, 12, 18);
        canvas.drawRRect(RRect.fromLTRBR(8, 18, 16, 21, const Radius.circular(1)), st);
      case DwIcons.heart:
        final h = p()
          ..moveTo(12, 20)
          ..cubicTo(5, 15, 3, 11.5, 3, 8.5)
          ..cubicTo(3, 5.5, 5.5, 3.8, 8, 3.8)
          ..cubicTo(10, 3.8, 11.3, 5, 12, 6.5)
          ..cubicTo(12.7, 5, 14, 3.8, 16, 3.8)
          ..cubicTo(18.5, 3.8, 21, 5.5, 21, 8.5)
          ..cubicTo(21, 11.5, 19, 15, 12, 20)
          ..close();
        canvas.drawPath(h, fill);
        canvas.drawPath(h, st);
      case DwIcons.restart:
        canvas.drawArc(Rect.fromCircle(center: const Offset(12, 12.5), radius: 7.5), -1.2, 5.2, false, st);
        canvas.drawPath(
          p()
            ..moveTo(15, 3)
            ..lineTo(15.3, 6.3)
            ..lineTo(12, 6.8),
          st,
        );
      case DwIcons.info:
        circle(12, 12, 8.5, filled: true);
        line(12, 11, 12, 16.5);
        circle(12, 7.8, 1.1, solidFill: true);
      case DwIcons.target:
        circle(12, 12, 8.5, filled: true);
        circle(12, 12, 5);
        circle(12, 12, 1.6, solidFill: true);
      case DwIcons.bolt:
        final b = p()
          ..moveTo(13.5, 2.5)
          ..lineTo(5, 13.5)
          ..lineTo(11.5, 13.5)
          ..lineTo(10.5, 21.5)
          ..lineTo(19, 10.5)
          ..lineTo(12.5, 10.5)
          ..close();
        canvas.drawPath(b, fill);
        canvas.drawPath(b, st);
      case DwIcons.chair:
        canvas.drawRRect(RRect.fromLTRBR(6.5, 3, 11, 12, const Radius.circular(2)), fill);
        canvas.drawRRect(RRect.fromLTRBR(6.5, 3, 11, 12, const Radius.circular(2)), st);
        canvas.drawRRect(RRect.fromLTRBR(6, 12, 18.5, 14.5, const Radius.circular(1.2)), st);
        line(12, 14.5, 12, 18.5);
        line(6.5, 20.5, 17.5, 20.5);
        line(12, 18.5, 7, 20.5);
        line(12, 18.5, 17, 20.5);
    }
  }

  @override
  bool shouldRepaint(DwIconPainter old) => old.icon != icon || old.color != color || old.sw != sw;
}
