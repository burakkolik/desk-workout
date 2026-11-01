import 'clip_kit.dart';

/// Wrist & hand exercises. Sources: Cleveland Clinic, Leeds Teaching
/// Hospitals NHS wrist leaflet, Mayo Clinic forearm stretches.
abstract final class WristClips {
  static final _reach = Pose.seatedSide.w({P.upperArmR: 86, P.foreArmR: 88, P.handR: 90});

  /// Palm up, fingers pulled back towards the floor.
  static final flexorStretch = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final pulled = _reach.w({P.handR: 12});
      final f = pulled.frame(side);
      final grab = pulled.reachArm(Side.l, f.handTipR + const Offset(0.035, -0.02), side, bend: -1, hand: 200);
      return [
        k(Pose.seatedSide, move: 0.8, hold: 0.4),
        k(_reach, move: 1.0, hold: 0.4),
        k(grab, move: 1.2, hold: 2.6, cue: Cue.hold),
        k(_reach, move: 0.8, hold: 0.2),
      ];
    }()),
    focus: const [BodyArea.wrists],
  );

  /// Palm down, hand pressed down at the back.
  static final extensorStretch = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final pressed = _reach.w({P.handR: 2});
      final f = pressed.frame(side);
      final grab = pressed.reachArm(Side.l, f.wristR + const Offset(0.02, -0.05), side, bend: -1, hand: 130);
      return [
        k(Pose.seatedSide, move: 0.8, hold: 0.4),
        k(_reach, move: 1.0, hold: 0.4),
        k(grab, move: 1.2, hold: 2.6, cue: Cue.hold),
        k(_reach, move: 0.8, hold: 0.2),
      ];
    }()),
    focus: const [BodyArea.wrists, BodyArea.arms],
  );

  /// Fists, forearms still, hands draw slow circles.
  static final circles = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final b = Pose.seatedSide.w({P.upperArmR: 70, P.foreArmR: 92, P.upperArmL: 72, P.foreArmL: 94});
      Pose h(double a) => b.w({P.handR: a, P.handL: a + 6});
      return [
        k(h(140), move: 0.45, hold: 0),
        k(h(95), move: 0.45, hold: 0),
        k(h(40), move: 0.45, hold: 0),
        k(h(85), move: 0.45, hold: 0),
      ];
    }()),
    focus: const [BodyArea.wrists],
  );

  /// Palms together in front of the chest, lowered while staying pressed.
  static final prayer = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      Pose palms(double y, double spread) => Pose.seatedFront
          .w({P.foreArmLenL: 1, P.foreArmLenR: 1})
          .reachArm(Side.l, Offset(-0.012, y), front, bend: -1, hand: 182)
          .reachArm(Side.r, Offset(0.012, y), front, bend: 1, hand: 178)
          .w({P.shoulderFwdL: spread, P.shoulderFwdR: spread});
      final high = palms(0.06, 0);
      final low = palms(0.26, 0.3);
      return [k(high, move: 1.0, hold: 0.6), k(low, move: 1.6, hold: 2.6, cue: Cue.hold)];
    }()),
    focus: const [BodyArea.wrists],
  );
}
