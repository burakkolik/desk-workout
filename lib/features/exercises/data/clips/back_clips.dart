import 'clip_kit.dart';

/// Back & spine exercises. Sources: NHS sitting exercises, Cleveland Clinic
/// (cat-cow, seated child's pose).
abstract final class BackClips {
  /// Arms crossed on the chest, hips forward, upper body turns.
  static final spinalTwist = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      Pose crossed(Pose p) {
        final f = p.frame(front);
        return p
            .reachArm(Side.l, f.shoulderR + const Offset(-0.03, 0.05), front, bend: -1, hand: 70)
            .reachArm(Side.r, f.shoulderL + const Offset(0.03, 0.08), front, bend: 1, hand: -70);
      }

      final b = crossed(Pose.seatedFront);
      final twist = crossed(Pose.seatedFront.w({P.torsoYaw: 0.85, P.headYaw: 0.9}));
      return [
        k(b, move: 0.8, hold: 0.4, cue: Cue.inhale),
        k(twist, move: 1.5, hold: 2.2, cue: Cue.hold),
        k(b, move: 1.2, hold: 0.4, cue: Cue.inhale),
        k(twist.mirrored(), move: 1.5, hold: 2.2, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.upperBack, BodyArea.core],
  );

  static Pose _handsOnThighs(Pose p, double reach) {
    final target = Offset(p[P.hipX] + reach, p[P.hipY] - 0.075);
    return p
        .reachArm(Side.r, target, side, bend: 1, hand: 100)
        .reachArm(Side.l, target + const Offset(-0.01, 0), side, bend: 1, hand: 100);
  }

  /// Cow (arch, chest up) on the inhale, cat (round, chin down) on the exhale.
  static final catCow = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final base = Pose.seatedSide.w({P.hipX: -0.12});
      final cow = _handsOnThighs(
        base.w({
          P.spine: 186,
          P.spineCurve: -0.75,
          P.chestOpen: 1,
          P.neck: 184,
          P.head: 194,
          P.shoulderFwdL: -0.7,
          P.shoulderFwdR: -0.7,
        }),
        0.27,
      );
      final cat = _handsOnThighs(
        base.w({
          P.spine: 166,
          P.spineCurve: 0.95,
          P.neck: 146,
          P.head: 138,
          P.shoulderFwdL: 0.8,
          P.shoulderFwdR: 0.8,
          P.eyesClosed: 1,
        }),
        0.34,
      );
      return [k(cow, move: 1.6, hold: 0.8, cue: Cue.inhale), k(cat, move: 1.8, hold: 0.8, cue: Cue.exhale)];
    }()),
    focus: const [BodyArea.lowerBack, BodyArea.upperBack],
  );

  /// Fold forward, forearms rest on the thighs, neck in line with the spine.
  static final forwardFold = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final base = Pose.seatedSide.w({P.hipX: -0.12});
      final f0 = _handsOnThighs(base, 0.28);
      var fold = base.w({
        P.spine: 128,
        P.spineCurve: 0.55,
        P.neck: 118,
        P.head: 112,
        P.eyesClosed: 1,
        P.shoulderFwdL: 0.6,
        P.shoulderFwdR: 0.6,
      });
      final knee = fold.frame(side).kneeR;
      fold = fold
          .reachArm(Side.r, knee + const Offset(0.0, -0.09), side, bend: -1, hand: 70)
          .reachArm(Side.l, knee + const Offset(-0.02, -0.09), side, bend: -1, hand: 70);
      return [
        k(f0, move: 0.8, hold: 0.6, cue: Cue.inhale),
        k(fold, move: 2.0, hold: 2.6, cue: Cue.exhale),
        k(f0, move: 1.8, hold: 0.4, cue: Cue.inhale),
      ];
    }()),
    focus: const [BodyArea.lowerBack],
  );
}
