import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

import '../domain/figure_scene.dart';
import '../domain/pose.dart';
import '../domain/skeleton.dart';
import 'paint_kit.dart';
import 'props_painter.dart';

/// Colours of the illustrated character.
class FigureStyle {
  const FigureStyle({
    this.skin = const Color(0xFFF4C7A3),
    this.hair = const Color(0xFF2A2140),
    this.shirt = const Color(0xFF22D3B6),
    this.pants = const Color(0xFF2E3A66),
    this.shoe = const Color(0xFFF2F4FA),
    this.sole = const Color(0xFFFF7A59),
    this.glow = const Color(0xFF2EE6C5),
  });

  final Color skin, hair, shirt, pants, shoe, sole, glow;
}

/// Paints the full illustrated scene: floor, furniture and the character.
class FigurePainter extends CustomPainter {
  FigurePainter({
    required this.pose,
    required this.scene,
    this.focus = const [],
    this.pulse = 0,
    this.style = const FigureStyle(),
  });

  final Pose pose;
  final FigureScene scene;
  final List<BodyArea> focus;

  /// 0..1 animation phase for the focus glow.
  final double pulse;
  final FigureStyle style;

  static const _outline = Color(0x8C0A0F1E);
  static const _farShade = 0.30;

  /// Scene -> canvas mapping (uniform scale, centred "contain" fit).
  static (double scale, Offset offset) sceneTransform(Size size, Rect vp) {
    final scale = math.min(size.width / vp.width, size.height / vp.height);
    final dx = (size.width - vp.width * scale) / 2 - vp.left * scale;
    final dy = (size.height - vp.height * scale) / 2 - vp.top * scale;
    return (scale, Offset(dx, dy));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final vp = scene.viewport;
    final (scale, o) = sceneTransform(size, vp);
    final dx = o.dx;
    final dy = o.dy;
    canvas.save();
    canvas.translate(dx, dy);
    canvas.scale(scale);

    final unit = 1.0 / scale; // one logical pixel in scene units
    final props = PropsPainter(scene, unit);
    final f = SkeletonFrame.solve(pose, scene.view);

    props.paintFloor(canvas, vp);
    if (!scene.chair) {
      final cx = (f.ankleL.dx + f.ankleR.dx) / 2;
      props.paintShadow(canvas, cx, 0.5);
    }
    props.paintDesk(canvas);
    props.paintChair(canvas);

    _paintFocusGlow(canvas, f, behind: true);
    if (f.isSide) {
      _paintSide(canvas, f, unit);
    } else {
      _paintFront(canvas, f, unit);
    }
    _paintFocusGlow(canvas, f, behind: false);
    canvas.restore();
  }

  // ---------------------------------------------------------------------------
  // Side view
  // ---------------------------------------------------------------------------

  void _paintSide(Canvas canvas, SkeletonFrame f, double unit) {
    // Far limbs first (darkened), then torso, near leg, head, near arm.
    _leg(canvas, f.hipL, f.kneeL, f.ankleL, f.toeL, unit, far: true, side: true);
    _arm(canvas, f.shoulderL, f.elbowL, f.wristL, f.handTipL, unit, far: true);
    _neck(canvas, f, unit);
    _torsoSide(canvas, f, unit);
    _leg(canvas, f.hipR, f.kneeR, f.ankleR, f.toeR, unit, far: false, side: true);
    _headSide(canvas, f, unit);
    _arm(canvas, f.shoulderR, f.elbowR, f.wristR, f.handTipR, unit, far: false);
  }

  /// Torso contour table: (s along spine, back offset, front offset).
  static const _sideContour = <List<double>>[
    [-0.10, -0.075, 0.070],
    [0.00, -0.112, 0.098],
    [0.18, -0.098, 0.100],
    [0.42, -0.082, 0.098],
    [0.66, -0.092, 0.112],
    [0.86, -0.088, 0.100],
    [0.98, -0.060, 0.065],
    [1.04, -0.030, 0.030],
  ];

  List<Offset> _sideOutline(SkeletonFrame f, double from, double to) {
    final chest = pose[P.chestOpen];
    final back = <Offset>[];
    final front = <Offset>[];
    for (final row in _sideContour) {
      final s = row[0];
      if (s < from - 1e-6 || s > to + 1e-6) continue;
      final sc = s.clamp(0.0, 1.0);
      var c = f.spineAt(sc);
      final t = f.spineTangent(sc);
      if (s < 0) c = c - t * (-s * Body.torsoLen);
      if (s > 1) c = c + t * ((s - 1) * Body.torsoLen);
      final n = Offset(-t.dy, t.dx); // forward
      final chestBoost = (s > 0.55 && s < 0.95) ? chest * 0.022 : 0.0;
      back.add(c + n * row[1]);
      front.add(c + n * (row[2] + chestBoost));
    }
    return [...back, ...front.reversed];
  }

  void _torsoSide(Canvas canvas, SkeletonFrame f, double unit) {
    final pantsPts = _sideOutline(f, -0.10, 0.42);
    final shirtPts = _sideOutline(f, 0.18, 1.04);
    final pants = PaintKit.smoothClosed(pantsPts);
    final shirt = PaintKit.smoothClosed(shirtPts);
    final fwd = f.spineFwd;
    final c = f.spineAt(0.5);

    canvas.drawPath(
      pants,
      Paint()
        ..shader = ui.Gradient.linear(
          c - fwd * 0.1,
          c + fwd * 0.1,
          [PaintKit.shade(style.pants, 0.25), style.pants, PaintKit.tint(style.pants, 0.12)],
          const [0, 0.5, 1],
        ),
    );
    canvas.drawPath(pants, PaintKit.stroke(_outline, unit * 1.2));
    canvas.drawPath(
      shirt,
      Paint()
        ..shader = ui.Gradient.linear(
          c - fwd * 0.11,
          c + fwd * 0.12,
          [PaintKit.shade(style.shirt, 0.30), style.shirt, PaintKit.tint(style.shirt, 0.25)],
          const [0, 0.55, 1],
        ),
    );
    // Shirt hem + side seam details.
    final hemA = f.spineAt(0.2) - f.spineTangent(0.2).rot90() * 0.095;
    final hemB = f.spineAt(0.22) + f.spineTangent(0.22).rot90() * 0.1;
    canvas.drawLine(hemA, hemB, PaintKit.stroke(PaintKit.shade(style.shirt, 0.35), unit * 1.4));
    canvas.drawPath(shirt, PaintKit.stroke(_outline, unit * 1.2));
    // Belt hint.
    final beltA = f.spineAt(0.16) - f.spineTangent(0.16).rot90() * 0.1;
    final beltB = f.spineAt(0.16) + f.spineTangent(0.16).rot90() * 0.1;
    canvas.drawLine(beltA, beltB, PaintKit.stroke(const Color(0x33000000), unit * 2));
  }

  // ---------------------------------------------------------------------------
  // Front view
  // ---------------------------------------------------------------------------

  void _paintFront(Canvas canvas, SkeletonFrame f, double unit) {
    final behindL = pose[P.armBehindL] >= 0.5;
    final behindR = pose[P.armBehindR] >= 0.5;
    if (behindL) _arm(canvas, f.shoulderL, f.elbowL, f.wristL, f.handTipL, unit, far: true);
    if (behindR) _arm(canvas, f.shoulderR, f.elbowR, f.wristR, f.handTipR, unit, far: true);
    // A crossed leg (horizontal shin) is drawn on top of the other one.
    void legL() => _leg(canvas, f.hipL, f.kneeL, f.ankleL, f.toeL, unit, far: false, side: false);
    void legR() => _leg(canvas, f.hipR, f.kneeR, f.ankleR, f.toeR, unit, far: false, side: false);
    if (pose[P.shinL].abs() <= pose[P.shinR].abs()) {
      legL();
      legR();
    } else {
      legR();
      legL();
    }
    _neck(canvas, f, unit);
    _torsoFront(canvas, f, unit);
    _headFront(canvas, f, unit);
    if (!behindL) _arm(canvas, f.shoulderL, f.elbowL, f.wristL, f.handTipL, unit, far: false);
    if (!behindR) _arm(canvas, f.shoulderR, f.elbowR, f.wristR, f.handTipR, unit, far: false);
  }

  void _torsoFront(Canvas canvas, SkeletonFrame f, double unit) {
    final yaw = pose[P.torsoYaw];
    final squeeze = math.cos(yaw * 0.9);
    // (s, half width, applies twist?)
    const rows = <List<double>>[
      [-0.06, 0.150, 0],
      [0.05, 0.140, 0],
      [0.22, 0.128, 0.3],
      [0.45, 0.125, 0.6],
      [0.70, 0.150, 1],
      [0.88, 0.180, 1],
      [0.97, 0.150, 1],
      [1.05, 0.060, 1],
    ];
    List<Offset> outline(double from, double to) {
      final left = <Offset>[];
      final right = <Offset>[];
      for (final r in rows) {
        if (r[0] < from - 1e-6 || r[0] > to + 1e-6) continue;
        final s = r[0].clamp(0.0, 1.0);
        var c = f.spineAt(s);
        final t = f.spineTangent(s);
        if (r[0] < 0) c = c - t * (-r[0] * Body.torsoLen);
        final across = Offset(-t.dy, t.dx);
        final w = r[1] * (1 - r[2] + r[2] * squeeze) + (r[0] > 0.55 && r[0] < 0.95 ? pose[P.chestOpen] * 0.012 : 0);
        left.add(c - across * w);
        right.add(c + across * w);
      }
      return [...left, ...right.reversed];
    }

    final pants = PaintKit.smoothClosed(outline(-0.06, 0.45));
    final shirt = PaintKit.smoothClosed(outline(0.22, 1.05));
    final c = f.spineAt(0.5);
    final across = f.spineTangent(0.5).rot90();
    canvas.drawPath(
      pants,
      Paint()
        ..shader = ui.Gradient.linear(
          c - across * 0.15,
          c + across * 0.15,
          [PaintKit.tint(style.pants, 0.1), style.pants, PaintKit.shade(style.pants, 0.3)],
          const [0, 0.5, 1],
        ),
    );
    canvas.drawPath(pants, PaintKit.stroke(_outline, unit * 1.2));
    final light = 0.5 - yaw * 0.35;
    canvas.drawPath(
      shirt,
      Paint()
        ..shader = ui.Gradient.linear(
          c - across * 0.18,
          c + across * 0.18,
          [PaintKit.tint(style.shirt, 0.22), style.shirt, PaintKit.shade(style.shirt, 0.32)],
          [0, light.clamp(0.15, 0.85), 1],
        ),
    );
    // Centre seam / collar shows the twist direction.
    final twist = math.sin(yaw * 0.9) * 0.07;
    final top = f.spineAt(1.0);
    final topT = f.spineTangent(1.0);
    final topA = topT.rot90();
    final collarC = top + topA * twist;
    final collar = Path()
      ..moveTo((collarC - topA * 0.05).dx, (collarC - topA * 0.05).dy)
      ..quadraticBezierTo(
        (collarC - topT * 0.07).dx,
        (collarC - topT * 0.07).dy,
        (collarC + topA * 0.05).dx,
        (collarC + topA * 0.05).dy,
      );
    canvas.drawPath(collar, PaintKit.stroke(PaintKit.shade(style.shirt, 0.4), unit * 2));
    final seamTop = f.spineAt(0.8) + f.spineTangent(0.8).rot90() * twist;
    final seamBot = f.spineAt(0.3) + f.spineTangent(0.3).rot90() * twist * 0.4;
    canvas.drawLine(seamTop, seamBot, PaintKit.stroke(const Color(0x22000000), unit * 1.5));
    canvas.drawPath(shirt, PaintKit.stroke(_outline, unit * 1.2));
    // Belt.
    final bl = f.spineAt(0.2);
    final ba = f.spineTangent(0.2).rot90();
    canvas.drawLine(bl - ba * 0.125, bl + ba * 0.125, PaintKit.stroke(const Color(0x55000000), unit * 2.5));
  }

  // ---------------------------------------------------------------------------
  // Limbs
  // ---------------------------------------------------------------------------

  void _arm(Canvas canvas, Offset s, Offset e, Offset w, Offset tip, double unit, {required bool far}) {
    final k = far ? _farShade : 0.0;
    final skin = PaintKit.shade(style.skin, k);
    final shirt = PaintKit.shade(style.shirt, k);
    // Upper arm (skin under the sleeve), forearm.
    _limb(canvas, s, e, 0.040, 0.033, skin, unit);
    _limb(canvas, e, w, 0.032, 0.024, skin, unit);
    _hand(canvas, w, tip, skin, unit);
    // T-shirt sleeve covering the upper half of the upper arm.
    final sleeveEnd = Offset.lerp(s, e, 0.55)!;
    _limb(canvas, s, sleeveEnd, 0.050, 0.044, shirt, unit);
  }

  void _leg(
    Canvas canvas,
    Offset h,
    Offset k,
    Offset a,
    Offset toe,
    double unit, {
    required bool far,
    required bool side,
  }) {
    final s = far ? _farShade : 0.0;
    final pants = PaintKit.shade(style.pants, s);
    _limb(canvas, h, k, 0.068, 0.050, pants, unit);
    _limb(canvas, k, a, 0.048, 0.036, pants, unit);
    // Knee cap highlight.
    canvas.drawCircle(k, 0.03, PaintKit.fill(PaintKit.tint(pants, 0.08).withValues(alpha: 0.6)));
    // A crossed (horizontal) shin shows the shoe from the side even in front view.
    final shin = a - k;
    final crossed = !side && shin.distance > 0 && shin.dy.abs() < shin.dx.abs();
    if (crossed) {
      final u = shin / shin.distance;
      _shoe(canvas, a, a + Offset(u.dx.sign * 0.05, -0.12), unit, far: far, side: true);
    } else {
      _shoe(canvas, a, toe, unit, far: far, side: side);
    }
  }

  void _limb(Canvas canvas, Offset a, Offset b, double ra, double rb, Color c, double unit) {
    final path = PaintKit.capsule(a, b, ra, rb);
    canvas.drawPath(path, PaintKit.tube(a, b, (ra + rb) / 2, PaintKit.tint(c, 0.18), c, PaintKit.shade(c, 0.28)));
    canvas.drawPath(path, PaintKit.stroke(_outline, unit * 1.1));
  }

  void _hand(Canvas canvas, Offset wrist, Offset tip, Color skin, double unit) {
    final d = tip - wrist;
    final len = d.distance;
    if (len < 1e-6) return;
    final u = d / len;
    final n = Offset(-u.dy, u.dx);
    Offset h(double a, double b) => wrist + u * (a * len) + n * b;
    final palm = PaintKit.smoothClosed([
      h(-0.05, 0.021),
      h(0.35, 0.029),
      h(0.75, 0.024),
      h(1.0, 0.012),
      h(1.04, -0.002),
      h(0.95, -0.017),
      h(0.6, -0.025),
      h(0.25, -0.026),
      h(-0.05, -0.020),
    ], tension: 0.55);
    final thumb = PaintKit.capsule(h(0.22, 0.022), h(0.52, 0.042), 0.013, 0.010);
    final path = Path.combine(PathOperation.union, palm, thumb);
    canvas.drawPath(path, PaintKit.tube(wrist, tip, 0.03, PaintKit.tint(skin, 0.2), skin, PaintKit.shade(skin, 0.22)));
    canvas.drawPath(path, PaintKit.stroke(_outline, unit * 0.9));
    // Knuckle crease + finger separation hints.
    final crease = PaintKit.stroke(PaintKit.shade(skin, 0.28), unit * 0.7);
    canvas.drawLine(h(0.62, -0.006), h(0.95, -0.006), crease);
    canvas.drawLine(h(0.6, 0.009), h(0.9, 0.009), crease);
  }

  void _shoe(Canvas canvas, Offset ankle, Offset toe, double unit, {required bool far, required bool side}) {
    final shoe = PaintKit.shade(style.shoe, far ? _farShade : 0.04);
    final sole = PaintKit.shade(style.sole, far ? _farShade : 0);
    if (side) {
      final d = toe - ankle;
      final len = d.distance;
      final u = len < 1e-6 ? const Offset(1, 0) : d / len;
      // "Down" relative to the foot (towards the sole).
      final down = Offset(u.dy, -u.dx).dy > 0 ? Offset(u.dy, -u.dx) : Offset(-u.dy, u.dx);
      final heel = ankle - u * 0.035 + down * 0.045;
      final pts = <Offset>[
        ankle - u * 0.04 - down * 0.03,
        ankle + u * 0.04 - down * 0.02,
        toe - u * 0.03 + down * 0.0,
        toe + u * 0.015 + down * 0.035,
        toe + down * 0.06,
        heel + down * 0.012,
        heel - u * 0.012,
      ];
      final path = PaintKit.smoothClosed(pts, tension: 0.4);
      canvas.drawPath(path, PaintKit.fill(shoe));
      canvas.drawLine(heel + down * 0.008, toe + down * 0.055, PaintKit.stroke(sole, 0.018));
      canvas.drawPath(path, PaintKit.stroke(_outline, unit * 1.1));
      // Lace detail.
      canvas.drawLine(
        ankle + u * 0.035 - down * 0.008,
        ankle + u * 0.075 + down * 0.012,
        PaintKit.stroke(const Color(0x553D7BFF), unit * 1.4),
      );
    } else {
      final r = RRect.fromRectAndRadius(
        Rect.fromCenter(center: ankle + const Offset(0, 0.035), width: 0.095, height: 0.075),
        const Radius.circular(0.03),
      );
      canvas.drawRRect(r, PaintKit.fill(shoe));
      canvas.drawRect(Rect.fromLTRB(r.left + 0.004, r.bottom - 0.016, r.right - 0.004, r.bottom), PaintKit.fill(sole));
      canvas.drawRRect(r, PaintKit.stroke(_outline, unit * 1.1));
    }
  }

  // ---------------------------------------------------------------------------
  // Neck + head
  // ---------------------------------------------------------------------------

  void _neck(Canvas canvas, SkeletonFrame f, double unit) {
    final start = f.neckBase - f.spineUp * 0.03;
    final end = f.headBase + dirOf(f.headAngle) * 0.02;
    _limb(canvas, start, end, 0.042, 0.037, style.skin, unit);
  }

  void _headSide(Canvas canvas, SkeletonFrame f, double unit) {
    const r = Body.headR;
    final up = dirOf(f.headAngle);
    final fwd = perpOf(up);
    final c = f.headCenter;
    Offset l(double x, double y) => PaintKit.local(c, fwd, up, x * r, y * r);

    // Skull + jaw.
    final nosePath = Path()
      ..moveTo(l(0.9, 0.12).dx, l(0.9, 0.12).dy)
      ..quadraticBezierTo(l(1.0, 0.0).dx, l(1.0, 0.0).dy, l(1.16, -0.2).dx, l(1.16, -0.2).dy)
      ..quadraticBezierTo(l(1.08, -0.3).dx, l(1.08, -0.3).dy, l(0.92, -0.3).dx, l(0.92, -0.3).dy)
      ..close();
    final head = Path.combine(
      PathOperation.union,
      Path.combine(
        PathOperation.union,
        Path()..addOval(Rect.fromCircle(center: c, radius: r)),
        PaintKit.smoothClosed([l(0.1, -0.1), l(0.97, -0.2), l(0.92, -0.62), l(0.55, -0.98), l(0.05, -0.9)]),
      ),
      nosePath,
    );
    canvas.drawPath(
      head,
      Paint()
        ..shader = ui.Gradient.radial(
          l(0.35, 0.35),
          r * 1.6,
          [PaintKit.tint(style.skin, 0.2), style.skin, PaintKit.shade(style.skin, 0.2)],
          const [0, 0.55, 1],
        ),
    );
    canvas.drawPath(head, PaintKit.stroke(_outline, unit * 1.1));

    // Hair (clipped to the skull).
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: c, radius: r * 1.07)));
    final hair = Path()
      ..addPolygon([
        l(-1.3, -0.95),
        l(-1.3, 1.3),
        l(1.3, 1.3),
        l(1.3, 0.62),
        l(0.75, 0.58),
        l(0.35, 0.72),
        l(0.05, 0.42),
        l(-0.22, 0.18),
        l(-0.3, -0.35),
        l(-0.62, -0.95),
      ], true);
    canvas.drawPath(
      hair,
      Paint()..shader = ui.Gradient.linear(l(0, 1), l(-0.6, -0.6), [PaintKit.tint(style.hair, 0.18), style.hair]),
    );
    canvas.drawLine(l(-0.1, 0.85), l(0.45, 0.9), PaintKit.stroke(const Color(0x33FFFFFF), unit * 1.6));
    canvas.restore();

    // Ear.
    final ear = Rect.fromCenter(center: l(-0.12, -0.05), width: r * 0.36, height: r * 0.5);
    canvas.save();
    canvas.translate(ear.center.dx, ear.center.dy);
    canvas.rotate(math.atan2(up.dx, -up.dy));
    final earLocal = Rect.fromCenter(center: Offset.zero, width: ear.width, height: ear.height);
    canvas.drawOval(earLocal, PaintKit.fill(PaintKit.shade(style.skin, 0.08)));
    canvas.drawOval(earLocal, PaintKit.stroke(_outline, unit * 0.9));
    canvas.drawArc(
      earLocal.deflate(r * 0.08),
      -0.6,
      2.4,
      false,
      PaintKit.stroke(PaintKit.shade(style.skin, 0.3), unit * 0.9),
    );
    canvas.restore();

    // Eye, brow, mouth.
    final closed = pose[P.eyesClosed];
    final eye = l(0.6, 0.08);
    if (closed > 0.5) {
      canvas.drawArc(
        Rect.fromCenter(center: eye, width: r * 0.24, height: r * 0.14),
        0.2,
        2.6,
        false,
        PaintKit.stroke(style.hair, unit * 1.5),
      );
    } else {
      canvas.drawOval(
        Rect.fromCenter(center: eye, width: r * 0.16, height: r * 0.22 * (1 - closed)),
        PaintKit.fill(style.hair),
      );
      canvas.drawCircle(eye + (fwd + up) * (r * 0.03), r * 0.03, PaintKit.fill(const Color(0xCCFFFFFF)));
    }
    canvas.drawLine(l(0.45, 0.32), l(0.78, 0.30), PaintKit.stroke(style.hair, unit * 1.8));
    final smile = pose[P.smile];
    canvas.drawPath(
      Path()
        ..moveTo(l(0.62, -0.5).dx, l(0.62, -0.5).dy)
        ..quadraticBezierTo(
          l(0.78, -0.52 - smile * 0.1).dx,
          l(0.78, -0.52 - smile * 0.1).dy,
          l(0.9, -0.45).dx,
          l(0.9, -0.45).dy,
        ),
      PaintKit.stroke(PaintKit.shade(const Color(0xFFD9786A), 0.1), unit * 1.5),
    );
    // Cheek blush.
    canvas.drawCircle(l(0.45, -0.3), r * 0.16, PaintKit.fill(const Color(0x33FF7A7A)));
  }

  void _headFront(Canvas canvas, SkeletonFrame f, double unit) {
    const r = Body.headR;
    final up = dirOf(pose[P.head]);
    final right = perpOf(up);
    final c = f.headCenter;
    final yaw = pose[P.headYaw].clamp(-1.0, 1.0);
    Offset l(double x, double y) => PaintKit.local(c, right, up, x * r, y * r);
    final shift = yaw * 0.42;
    final pitch = pose[P.headPitch];
    Offset lf(double x, double y) => l(x, y - pitch * 0.3);

    // Ears (behind the face), hidden progressively when turning.
    for (final s in [-1.0, 1.0]) {
      final hide = (s * yaw).clamp(0.0, 1.0); // turning towards this side hides it
      final ex = s * (0.93 - hide * 0.35) + shift * 0.2;
      final ear = Rect.fromCenter(center: l(ex, -0.02), width: r * 0.28 * (1 - hide * 0.5), height: r * 0.42);
      canvas.drawOval(ear, PaintKit.fill(PaintKit.shade(style.skin, 0.1)));
      canvas.drawOval(ear, PaintKit.stroke(_outline, unit * 0.9));
    }
    // Face.
    final face = PaintKit.smoothClosed([
      l(0, 1.0),
      l(0.88, 0.62),
      l(0.95, 0.0),
      l(0.72, -0.62),
      l(0.0 + shift * 0.25, -1.02),
      l(-0.72, -0.62),
      l(-0.95, 0.0),
      l(-0.88, 0.62),
    ]);
    canvas.drawPath(
      face,
      Paint()
        ..shader = ui.Gradient.radial(
          l(-0.25 + shift * 0.5, 0.3),
          r * 1.5,
          [PaintKit.tint(style.skin, 0.22), style.skin, PaintKit.shade(style.skin, 0.2)],
          const [0, 0.55, 1],
        ),
    );
    canvas.drawPath(face, PaintKit.stroke(_outline, unit * 1.1));

    // Hair.
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: c, radius: r * 1.1)));
    final hair = PaintKit.smoothClosed([
      l(-1.05, -0.05),
      l(-1.1, 0.8),
      l(-0.3, 1.25),
      l(0.6, 1.2),
      l(1.1, 0.75),
      l(1.05, -0.05),
      lf(0.86, 0.32),
      lf(0.35 + shift * 0.3, 0.52),
      lf(-0.15 + shift * 0.3, 0.70),
      lf(-0.55 + shift * 0.3, 0.45),
      lf(-0.86, 0.32),
    ], tension: 0.35);
    canvas.drawPath(
      hair,
      Paint()..shader = ui.Gradient.linear(l(0, 1.2), l(0, 0.2), [PaintKit.tint(style.hair, 0.2), style.hair]),
    );
    canvas.drawLine(l(-0.35, 0.92), l(0.2, 1.0), PaintKit.stroke(const Color(0x33FFFFFF), unit * 1.6));
    canvas.restore();

    // Eyes.
    final closed = pose[P.eyesClosed];
    for (final s in [-1.0, 1.0]) {
      final squeeze = 1 - (s * yaw).clamp(0.0, 1.0) * 0.35;
      final e = lf(s * 0.38 * squeeze + shift, 0.08);
      if (closed > 0.5) {
        canvas.drawArc(
          Rect.fromCenter(center: e, width: r * 0.26, height: r * 0.16),
          0.3,
          2.5,
          false,
          PaintKit.stroke(style.hair, unit * 1.5),
        );
      } else {
        canvas.drawOval(
          Rect.fromCenter(center: e, width: r * 0.15 * squeeze, height: r * 0.22 * (1 - closed)),
          PaintKit.fill(style.hair),
        );
        canvas.drawCircle(e + (right + up) * (r * 0.03), r * 0.028, PaintKit.fill(const Color(0xCCFFFFFF)));
      }
      canvas.drawLine(
        lf(s * 0.25 * squeeze + shift, 0.34),
        lf(s * 0.52 * squeeze + shift, 0.36),
        PaintKit.stroke(style.hair, unit * 1.8),
      );
      canvas.drawCircle(lf(s * 0.55 + shift * 0.8, -0.32), r * 0.14, PaintKit.fill(const Color(0x30FF7A7A)));
    }
    // Nose + mouth.
    canvas.drawPath(
      Path()
        ..moveTo(lf(shift * 1.1, 0.0).dx, lf(shift * 1.1, 0.0).dy)
        ..quadraticBezierTo(
          lf(shift * 1.25 + 0.06, -0.2).dx,
          lf(shift * 1.25 + 0.06, -0.2).dy,
          lf(shift * 1.1 - 0.04, -0.24).dx,
          lf(shift * 1.1 - 0.04, -0.24).dy,
        ),
      PaintKit.stroke(PaintKit.shade(style.skin, 0.3), unit * 1.2),
    );
    final smile = pose[P.smile];
    canvas.drawPath(
      Path()
        ..moveTo(lf(shift - 0.22, -0.5).dx, lf(shift - 0.22, -0.5).dy)
        ..quadraticBezierTo(
          lf(shift, -0.56 - smile * 0.14).dx,
          lf(shift, -0.56 - smile * 0.14).dy,
          lf(shift + 0.22, -0.5).dx,
          lf(shift + 0.22, -0.5).dy,
        ),
      PaintKit.stroke(const Color(0xFFC96A5E), unit * 1.6),
    );
  }

  // ---------------------------------------------------------------------------
  // Focus glow
  // ---------------------------------------------------------------------------

  void _paintFocusGlow(Canvas canvas, SkeletonFrame f, {required bool behind}) {
    if (focus.isEmpty) return;
    final wave = 0.5 + 0.5 * math.sin(pulse * math.pi * 2);
    for (final area in focus) {
      final p = f.areaCenter(area);
      final radius = behind ? 0.16 + wave * 0.04 : 0.07 + wave * 0.02;
      final alpha = behind ? 0.35 + wave * 0.25 : 0.07 + wave * 0.07;
      canvas.drawCircle(
        p,
        radius,
        Paint()
          ..blendMode = behind ? BlendMode.srcOver : BlendMode.plus
          ..shader = ui.Gradient.radial(p, radius, [
            style.glow.withValues(alpha: alpha),
            style.glow.withValues(alpha: 0),
          ]),
      );
    }
  }

  @override
  bool shouldRepaint(FigurePainter old) =>
      old.pose != pose || old.pulse != pulse || old.scene != scene || old.focus != focus;
}

extension on Offset {
  Offset rot90() => Offset(-dy, dx);
}
