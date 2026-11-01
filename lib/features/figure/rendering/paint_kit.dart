import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

/// Low level drawing helpers shared by every illustration painter.
abstract final class PaintKit {
  /// A tapered capsule (rounded limb) from [a] (radius [ra]) to [b] (radius [rb]).
  static Path capsule(Offset a, Offset b, double ra, double rb) {
    final d = b - a;
    final len = d.distance;
    if (len < 1e-6) {
      return Path()..addOval(Rect.fromCircle(center: a, radius: math.max(ra, rb)));
    }
    final u = d / len;
    final n = Offset(-u.dy, u.dx);
    return Path()
      ..moveTo((a + n * ra).dx, (a + n * ra).dy)
      ..lineTo((b + n * rb).dx, (b + n * rb).dy)
      ..arcToPoint(b - n * rb, radius: Radius.circular(rb), clockwise: false)
      ..lineTo((a - n * ra).dx, (a - n * ra).dy)
      ..arcToPoint(a + n * ra, radius: Radius.circular(ra), clockwise: false)
      ..close();
  }

  /// Tube-like shading across a limb.
  static Paint tube(Offset a, Offset b, double r, Color light, Color base, Color dark) {
    final d = b - a;
    final len = d.distance;
    final u = len < 1e-6 ? const Offset(0, 1) : d / len;
    final n = Offset(-u.dy, u.dx);
    final mid = (a + b) / 2;
    return Paint()
      ..isAntiAlias = true
      ..shader = ui.Gradient.linear(mid + n * r, mid - n * r, [light, base, dark], const [0.0, 0.45, 1.0]);
  }

  /// Smooth closed path through [pts] (Catmull-Rom converted to cubics).
  static Path smoothClosed(List<Offset> pts, {double tension = 0.5}) {
    final path = Path();
    final n = pts.length;
    if (n < 3) return path;
    path.moveTo(pts[0].dx, pts[0].dy);
    for (var i = 0; i < n; i++) {
      final p0 = pts[(i - 1 + n) % n];
      final p1 = pts[i];
      final p2 = pts[(i + 1) % n];
      final p3 = pts[(i + 2) % n];
      final c1 = p1 + (p2 - p0) * (tension / 3);
      final c2 = p2 - (p3 - p1) * (tension / 3);
      path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p2.dx, p2.dy);
    }
    path.close();
    return path;
  }

  /// Smooth open path through [pts].
  static Path smoothOpen(List<Offset> pts, {double tension = 0.5}) {
    final path = Path();
    final n = pts.length;
    if (n < 2) return path;
    path.moveTo(pts[0].dx, pts[0].dy);
    for (var i = 0; i < n - 1; i++) {
      final p0 = pts[math.max(i - 1, 0)];
      final p1 = pts[i];
      final p2 = pts[i + 1];
      final p3 = pts[math.min(i + 2, n - 1)];
      final c1 = p1 + (p2 - p0) * (tension / 3);
      final c2 = p2 - (p3 - p1) * (tension / 3);
      path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p2.dx, p2.dy);
    }
    return path;
  }

  static Color shade(Color c, double amount) => Color.lerp(c, const Color(0xFF0B1020), amount.clamp(0.0, 1.0))!;

  static Color tint(Color c, double amount) => Color.lerp(c, const Color(0xFFFFFFFF), amount.clamp(0.0, 1.0))!;

  static Paint fill(Color c) => Paint()
    ..isAntiAlias = true
    ..color = c;

  static Paint stroke(Color c, double w) => Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = w
    ..color = c;

  /// Rotates a local point (x along [fwd], y along [up]) into world space.
  static Offset local(Offset origin, Offset fwd, Offset up, double x, double y) => origin + fwd * x + up * y;
}
