import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

import '../domain/figure_scene.dart';
import '../domain/pose.dart';
import '../domain/skeleton.dart';
import 'paint_kit.dart';

/// Draws the furniture (office chair, desk, monitor) and floor.
class PropsPainter {
  const PropsPainter(this.scene, this.unit);

  final FigureScene scene;

  /// Stroke width reference (scene units).
  final double unit;

  static const _frame = Color(0xFF3A4260);
  static const _frameLight = Color(0xFF59648C);
  static const _frameDark = Color(0xFF222842);
  static const _cushion = Color(0xFF4B4F7A);
  static const _cushionLight = Color(0xFF6E73A8);
  static const _wood = Color(0xFFB9C3E0);
  static const _woodDark = Color(0xFF7D88AE);

  void paintFloor(Canvas canvas, Rect viewport) {
    final y = Body.floorY;
    final floor = Rect.fromLTRB(viewport.left, y, viewport.right, viewport.bottom + 0.2);
    canvas.drawRect(
      floor,
      Paint()
        ..shader = ui.Gradient.linear(Offset(0, y), Offset(0, viewport.bottom), [
          const Color(0x332EE6C5),
          const Color(0x00000000),
        ]),
    );
    canvas.drawLine(
      Offset(viewport.left, y),
      Offset(viewport.right, y),
      Paint()
        ..strokeWidth = unit * 0.8
        ..shader = ui.Gradient.linear(
          Offset(viewport.left, y),
          Offset(viewport.right, y),
          const [Color(0x002EE6C5), Color(0x882EE6C5), Color(0x002EE6C5)],
          const [0, 0.5, 1],
        ),
    );
  }

  void paintShadow(Canvas canvas, double x, double width) {
    canvas.drawOval(
      Rect.fromCenter(center: Offset(x, Body.floorY + 0.012), width: width, height: 0.05),
      Paint()
        ..shader = ui.Gradient.radial(Offset(x, Body.floorY + 0.012), width / 2, const [
          Color(0x88000000),
          Color(0x00000000),
        ]),
    );
  }

  // ---------------------------------------------------------------------------
  // Chair
  // ---------------------------------------------------------------------------

  void paintChair(Canvas canvas) {
    if (!scene.chair) return;
    if (scene.view == FigureView.side) {
      _chairSide(canvas);
    } else {
      _chairFront(canvas);
    }
  }

  double get _seatY => Pose.seatedSide[P.hipY] + 0.045;

  void _chairSide(Canvas canvas) {
    final x = scene.chairX;
    final seatY = _seatY;
    paintShadow(canvas, x + 0.02, 0.62);

    // Star base + wheels.
    final baseY = Body.floorY - 0.045;
    final base = Path()
      ..moveTo(x - 0.27, baseY)
      ..quadraticBezierTo(x, baseY - 0.07, x + 0.27, baseY)
      ..lineTo(x + 0.27, baseY + 0.022)
      ..quadraticBezierTo(x, baseY - 0.045, x - 0.27, baseY + 0.022)
      ..close();
    canvas.drawPath(base, PaintKit.fill(_frameDark));
    for (final wx in [x - 0.25, x + 0.25, x - 0.02]) {
      canvas.drawCircle(Offset(wx, Body.floorY - 0.022), 0.022, PaintKit.fill(const Color(0xFF151A2C)));
      canvas.drawCircle(Offset(wx, Body.floorY - 0.022), 0.009, PaintKit.fill(_frameLight));
    }
    // Gas lift.
    final col = Rect.fromLTRB(x - 0.018, seatY + 0.05, x + 0.018, baseY - 0.03);
    canvas.drawRRect(
      RRect.fromRectAndRadius(col, const Radius.circular(0.01)),
      Paint()
        ..shader = ui.Gradient.linear(
          col.centerLeft,
          col.centerRight,
          const [_frameLight, _frame, _frameDark],
          const [0, 0.5, 1],
        ),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(x - 0.03, seatY + 0.11, x + 0.03, baseY - 0.02),
        const Radius.circular(0.012),
      ),
      PaintKit.fill(_frameDark),
    );
    // Seat mechanism.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(x - 0.09, seatY + 0.045, x + 0.09, seatY + 0.075),
        const Radius.circular(0.012),
      ),
      PaintKit.fill(_frame),
    );
    // Backrest support.
    final support = Path()
      ..moveTo(x - 0.07, seatY + 0.06)
      ..quadraticBezierTo(x - 0.20, seatY + 0.06, x - 0.21, seatY - 0.12)
      ..lineTo(x - 0.235, seatY - 0.30);
    canvas.drawPath(support, PaintKit.stroke(_frameDark, 0.026));
    // Backrest.
    final back = RRect.fromRectAndCorners(
      Rect.fromLTRB(x - 0.275, seatY - 0.56, x - 0.195, seatY - 0.13),
      topLeft: const Radius.circular(0.05),
      topRight: const Radius.circular(0.035),
      bottomLeft: const Radius.circular(0.035),
      bottomRight: const Radius.circular(0.03),
    );
    canvas.drawRRect(
      back,
      Paint()
        ..shader = ui.Gradient.linear(
          back.outerRect.centerLeft,
          back.outerRect.centerRight,
          const [_cushion, _cushionLight, _cushion],
          const [0, 0.5, 1],
        ),
    );
    // Lumbar curve highlight.
    canvas.drawLine(
      Offset(x - 0.205, seatY - 0.36),
      Offset(x - 0.205, seatY - 0.20),
      PaintKit.stroke(const Color(0x55FFFFFF), unit * 0.6),
    );
    // Seat cushion.
    final seat = RRect.fromRectAndRadius(
      Rect.fromLTRB(x - 0.21, seatY - 0.005, x + 0.21, seatY + 0.055),
      const Radius.circular(0.028),
    );
    canvas.drawRRect(
      seat,
      Paint()
        ..shader = ui.Gradient.linear(seat.outerRect.topCenter, seat.outerRect.bottomCenter, const [
          _cushionLight,
          _cushion,
        ]),
    );
    // Armrest.
    canvas.drawPath(
      Path()
        ..moveTo(x - 0.12, seatY + 0.05)
        ..lineTo(x - 0.10, seatY - 0.20)
        ..lineTo(x + 0.10, seatY - 0.20),
      PaintKit.stroke(const Color(0x88222842), 0.018),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(x - 0.13, seatY - 0.225, x + 0.12, seatY - 0.19),
        const Radius.circular(0.015),
      ),
      PaintKit.fill(const Color(0xAA2A3050)),
    );
  }

  void _chairFront(Canvas canvas) {
    final x = scene.chairX;
    final seatY = _seatY;
    paintShadow(canvas, x, 0.7);
    final baseY = Body.floorY - 0.045;
    // Base (two legs visible + centre).
    canvas.drawPath(
      Path()
        ..moveTo(x - 0.28, baseY + 0.02)
        ..lineTo(x, baseY - 0.05)
        ..lineTo(x + 0.28, baseY + 0.02),
      PaintKit.stroke(_frameDark, 0.03),
    );
    for (final wx in [x - 0.28, x + 0.28, x]) {
      canvas.drawCircle(Offset(wx, Body.floorY - 0.022), 0.022, PaintKit.fill(const Color(0xFF151A2C)));
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(x - 0.02, seatY + 0.05, x + 0.02, baseY - 0.04),
        const Radius.circular(0.01),
      ),
      PaintKit.fill(_frame),
    );
    // Backrest (visible behind the torso and around it).
    final back = RRect.fromRectAndRadius(
      Rect.fromLTRB(x - 0.23, seatY - 0.58, x + 0.23, seatY - 0.12),
      const Radius.circular(0.07),
    );
    canvas.drawRRect(
      back,
      Paint()
        ..shader = ui.Gradient.linear(back.outerRect.topCenter, back.outerRect.bottomCenter, const [
          _cushionLight,
          _cushion,
        ]),
    );
    canvas.drawRRect(back.deflate(0.02), PaintKit.stroke(const Color(0x33FFFFFF), unit * 0.5));
    // Armrests.
    for (final s in [-1.0, 1.0]) {
      canvas.drawLine(
        Offset(x + s * 0.27, seatY + 0.04),
        Offset(x + s * 0.27, seatY - 0.18),
        PaintKit.stroke(_frameDark, 0.022),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x + s * 0.27, seatY - 0.19), width: 0.07, height: 0.035),
          const Radius.circular(0.015),
        ),
        PaintKit.fill(_frame),
      );
    }
    // Seat.
    final seat = RRect.fromRectAndRadius(
      Rect.fromLTRB(x - 0.25, seatY - 0.01, x + 0.25, seatY + 0.06),
      const Radius.circular(0.03),
    );
    canvas.drawRRect(
      seat,
      Paint()
        ..shader = ui.Gradient.linear(seat.outerRect.topCenter, seat.outerRect.bottomCenter, const [
          _cushionLight,
          _cushion,
        ]),
    );
  }

  // ---------------------------------------------------------------------------
  // Desk + monitor (side view only)
  // ---------------------------------------------------------------------------

  void paintDesk(Canvas canvas) {
    if (!scene.desk || scene.view != FigureView.side) return;
    final x = scene.deskX;
    final top = scene.deskTopY;
    const depth = 0.72;
    // Legs.
    final legPaint = PaintKit.fill(_frameDark);
    canvas.drawRect(Rect.fromLTRB(x + depth - 0.08, top + 0.03, x + depth - 0.045, Body.floorY), legPaint);
    canvas.drawRect(Rect.fromLTRB(x + 0.03, top + 0.03, x + 0.06, Body.floorY), PaintKit.fill(const Color(0x66222842)));
    canvas.drawRect(Rect.fromLTRB(x + depth - 0.12, Body.floorY - 0.015, x + depth, Body.floorY), legPaint);
    // Monitor.
    final mx = x + 0.48;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTRB(mx - 0.075, top - 0.012, mx + 0.075, top), const Radius.circular(0.006)),
      PaintKit.fill(_frame),
    );
    canvas.drawRect(Rect.fromLTRB(mx - 0.012, top - 0.16, mx + 0.012, top - 0.01), PaintKit.fill(_frame));
    final screen = RRect.fromRectAndRadius(
      Rect.fromLTRB(mx - 0.045, top - 0.44, mx - 0.012, top - 0.13),
      const Radius.circular(0.01),
    );
    canvas.drawRRect(screen, PaintKit.fill(const Color(0xFF161B2E)));
    canvas.drawLine(
      Offset(mx - 0.047, top - 0.43),
      Offset(mx - 0.047, top - 0.14),
      Paint()
        ..strokeWidth = 0.01
        ..strokeCap = StrokeCap.round
        ..shader = ui.Gradient.linear(Offset(mx, top - 0.43), Offset(mx, top - 0.14), const [
          Color(0xFF2EE6C5),
          Color(0xFF3D7BFF),
        ]),
    );
    // Screen glow towards the user.
    canvas.drawCircle(
      Offset(mx - 0.06, top - 0.29),
      0.22,
      Paint()
        ..shader = ui.Gradient.radial(Offset(mx - 0.06, top - 0.29), 0.22, const [
          Color(0x223D7BFF),
          Color(0x003D7BFF),
        ]),
    );
    // Keyboard + mug.
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTRB(x + 0.06, top - 0.016, x + 0.26, top), const Radius.circular(0.006)),
      PaintKit.fill(const Color(0xFF2A3050)),
    );
    final mug = Rect.fromLTRB(x + 0.62, top - 0.075, x + 0.67, top);
    canvas.drawRRect(
      RRect.fromRectAndRadius(mug, const Radius.circular(0.008)),
      PaintKit.fill(const Color(0xFFFF7A59)),
    );
    canvas.drawArc(
      Rect.fromLTRB(x + 0.66, top - 0.06, x + 0.69, top - 0.025),
      -1.6,
      3.2,
      false,
      PaintKit.stroke(const Color(0xFFFF7A59), 0.008),
    );
    // Desk top.
    final slab = RRect.fromRectAndRadius(Rect.fromLTRB(x, top, x + depth, top + 0.035), const Radius.circular(0.01));
    canvas.drawRRect(
      slab,
      Paint()
        ..shader = ui.Gradient.linear(slab.outerRect.topCenter, slab.outerRect.bottomCenter, const [_wood, _woodDark]),
    );
    canvas.drawLine(
      Offset(x + 0.01, top + 0.003),
      Offset(x + depth - 0.01, top + 0.003),
      PaintKit.stroke(const Color(0x88FFFFFF), unit * 0.5),
    );
  }
}
