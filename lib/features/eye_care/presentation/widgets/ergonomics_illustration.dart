import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../figure/domain/figure_scene.dart';
import '../../../figure/domain/ik.dart';
import '../../../figure/domain/pose.dart';
import '../../../figure/domain/skeleton.dart';
import '../../../figure/rendering/figure_painter.dart';

/// The ideal desk set-up drawn in code with numbered call-outs that match
/// the checklist (OSHA / AAO guidance).
class ErgonomicsIllustration extends StatefulWidget {
  const ErgonomicsIllustration({super.key});

  static final scene = FigureScene(
    view: FigureView.side,
    viewport: const Rect.fromLTRB(-0.7, -0.62, 1.0, 1.0),
    chair: true,
    chairX: Pose.seatedSide[P.hipX],
    desk: true,
    deskX: 0.12,
  );

  static final pose = Pose.seatedSide
      .w({P.neck: 180, P.spine: 181})
      .reachArm(Side.r, const Offset(0.19, 0.196), FigureView.side, bend: -1, hand: 92)
      .reachArm(Side.l, const Offset(0.17, 0.196), FigureView.side, bend: -1, hand: 92);

  @override
  State<ErgonomicsIllustration> createState() => _ErgonomicsIllustrationState();
}

class _ErgonomicsIllustrationState extends State<ErgonomicsIllustration> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) => CustomPaint(painter: _ErgoPainter(_c.value), size: Size.infinite),
    );
  }
}

class _ErgoPainter extends CustomPainter {
  _ErgoPainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final scene = ErgonomicsIllustration.scene;
    final pose = ErgonomicsIllustration.pose;
    FigurePainter(pose: pose, scene: scene).paint(canvas, size);

    final (scale, o) = FigurePainter.sceneTransform(size, scene.viewport);
    Offset map(Offset p) => o + p * scale;
    final f = pose.frame(FigureView.side);
    final eye = map(f.headCenter + const Offset(0.06, -0.01));
    final top = scene.deskTopY;
    final screenX = scene.deskX + 0.48 - 0.045;
    final screenTop = map(Offset(screenX, top - 0.44));
    final screenMid = map(Offset(screenX, top - 0.29));

    final dash = Paint()
      ..color = AppColors.amber.withValues(alpha: 0.85)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    // 1: viewing distance (animated dashes eye -> screen).
    _dashed(canvas, eye, screenMid, dash, t);
    // 2: eye level line to the top of the screen.
    _dashed(
      canvas,
      Offset(eye.dx, eye.dy),
      Offset(screenTop.dx, eye.dy),
      Paint()
        ..color = AppColors.sky.withValues(alpha: 0.8)
        ..strokeWidth = 2,
      t,
    );

    // 3: elbow angle arc.
    final elbow = map(f.elbowR);
    final upDir = (map(f.shoulderR) - elbow);
    final fwdDir = (map(f.wristR) - elbow);
    final a0 = upDir.direction;
    final a1 = fwdDir.direction;
    var sweep = a1 - a0;
    while (sweep > 3.1416) {
      sweep -= 6.2832;
    }
    while (sweep < -3.1416) {
      sweep += 6.2832;
    }
    canvas.drawArc(
      Rect.fromCircle(center: elbow, radius: 0.07 * scale),
      a0,
      sweep,
      false,
      Paint()
        ..color = AppColors.teal
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    final badges = <(int, Offset, Color)>[
      (1, Offset.lerp(eye, screenMid, 0.5)! + Offset(0, 0.06 * scale), AppColors.amber),
      (2, Offset(screenTop.dx - 0.05 * scale, eye.dy - 0.06 * scale), AppColors.sky),
      (3, elbow + Offset(-0.02 * scale, 0.1 * scale), AppColors.teal),
      (4, map(f.wristR) + Offset(0, -0.08 * scale), AppColors.violet),
      (5, map(f.spineAt(0.3) - f.spineFwd * 0.17), AppColors.coral),
      (6, map(f.toeR + const Offset(0.02, -0.12)), AppColors.lime),
    ];
    final pulse = 1 + 0.08 * (0.5 - (t - 0.5).abs()) * 2;
    for (final (n, p, c) in badges) {
      final r = 0.04 * scale * pulse;
      canvas.drawCircle(
        p,
        r * 1.8,
        Paint()..shader = ui.Gradient.radial(p, r * 1.8, [c.withValues(alpha: 0.45), c.withValues(alpha: 0)]),
      );
      canvas.drawCircle(p, r, Paint()..color = c);
      final tp = TextPainter(
        text: TextSpan(
          text: '$n',
          style: TextStyle(color: AppColors.bg, fontWeight: FontWeight.w800, fontSize: r * 1.2),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, p - Offset(tp.width / 2, tp.height / 2));
    }
  }

  void _dashed(Canvas canvas, Offset a, Offset b, Paint p, double t) {
    final d = b - a;
    final len = d.distance;
    if (len == 0) return;
    final u = d / len;
    const dashLen = 8.0;
    const gap = 6.0;
    var s = (t * (dashLen + gap)) % (dashLen + gap);
    while (s < len) {
      final e = (s + dashLen).clamp(0.0, len);
      canvas.drawLine(a + u * s, a + u * e, p..strokeCap = StrokeCap.round);
      s += dashLen + gap;
    }
  }

  @override
  bool shouldRepaint(_ErgoPainter old) => old.t != t;
}
