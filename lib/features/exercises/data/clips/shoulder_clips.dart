import 'clip_kit.dart';

/// Shoulder & upper back exercises. Sources: Harvard Health (shoulder
/// stretches), Cleveland Clinic, HSS, Mayo Clinic.
abstract final class ShoulderClips {
  static final _relaxedFront = Pose.seatedFront.w({
    P.upperArmL: -6,
    P.foreArmL: -2,
    P.handL: 0,
    P.foreArmLenL: 1,
    P.upperArmR: 6,
    P.foreArmR: 2,
    P.handR: 0,
    P.foreArmLenR: 1,
  });

  /// Lift both shoulders straight up, pause, relax down.
  static final shrugs = FigureVisual(
    FigureScene.seatedFront,
    poseClip([
      k(_relaxedFront, move: 0.6, hold: 0.5, cue: Cue.relax),
      k(_relaxedFront.w({P.shoulderLiftL: 1, P.shoulderLiftR: 1, P.smile: 0.1}), move: 0.9, hold: 1.4, cue: Cue.hold),
    ]),
    focus: const [BodyArea.shoulders, BodyArea.neck],
  );

  /// Circles: up, back, down, forward.
  static final rolls = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final b = Pose.seatedSide;
      Pose at(double fwd, double lift) =>
          b.w({P.shoulderFwdL: fwd, P.shoulderFwdR: fwd, P.shoulderLiftL: lift, P.shoulderLiftR: lift});
      return [
        k(at(0.8, 0.1), move: 0.55, hold: 0),
        k(at(0.2, 1.0), move: 0.55, hold: 0),
        k(at(-0.9, 0.5), move: 0.55, hold: 0),
        k(at(-0.4, -0.4), move: 0.55, hold: 0),
      ];
    }()),
    focus: const [BodyArea.shoulders],
  );

  /// Squeeze the shoulder blades back and together, elbows bent at the sides.
  static final scapularSqueeze = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final b = Pose.seatedSide.w({
        P.hipX: -0.12,
        P.upperArmL: 4,
        P.foreArmL: 92,
        P.handL: 92,
        P.upperArmR: 2,
        P.foreArmR: 90,
        P.handR: 90,
      });
      final squeeze = b.w({
        P.shoulderFwdL: -1,
        P.shoulderFwdR: -1,
        P.chestOpen: 1,
        P.spine: 183,
        P.upperArmL: -20,
        P.foreArmL: 84,
        P.upperArmR: -22,
        P.foreArmR: 82,
      });
      return [k(b, move: 0.7, hold: 0.5, cue: Cue.relax), k(squeeze, move: 1.0, hold: 2.2, cue: Cue.hold)];
    }()),
    focus: const [BodyArea.upperBack],
  );

  /// One straight arm across the chest; the other hand pulls at the elbow.
  static final crossBody = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      final b = Pose.seatedFront;
      var s = b.w({P.upperArmR: -84, P.foreArmR: -88, P.handR: -90, P.foreArmLenR: 0.92, P.upperArmLenR: 0.95});
      final elbow = s.frame(front).elbowR;
      s = s.reachArm(Side.l, elbow + const Offset(-0.035, 0.05), front, bend: -1, hand: 60);
      return [
        k(b, move: 0.8, hold: 0.4),
        k(s, move: 1.4, hold: 3.0, cue: Cue.hold),
        k(b, move: 1.2, hold: 0.4),
        k(s.mirrored(), move: 1.4, hold: 3.0, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.shoulders],
  );

  /// Elbow points at the ceiling, hand drops behind the head; the other hand
  /// presses the elbow.
  static final overheadTriceps = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      final b = Pose.seatedFront;
      var s = b.w({P.upperArmR: 194, P.foreArmR: 352, P.handR: 356, P.armBehindR: 1, P.foreArmLenR: 0.85});
      final elbow = s.frame(front).elbowR;
      s = s.reachArm(Side.l, elbow + const Offset(-0.05, -0.01), front, bend: 1, hand: 100);
      return [
        k(b, move: 0.8, hold: 0.4),
        k(s, move: 1.6, hold: 3.0, cue: Cue.hold),
        k(b, move: 1.3, hold: 0.4),
        k(s.mirrored(), move: 1.6, hold: 3.0, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.arms, BodyArea.shoulders],
  );

  /// Fingers interlaced behind, straight arms lift, chest opens.
  static final chestOpener = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final b = Pose.seatedSide.w({P.hipX: -0.08});
      final clasp = b.w({
        P.upperArmL: -22,
        P.foreArmL: -18,
        P.handL: -14,
        P.upperArmR: -24,
        P.foreArmR: -20,
        P.handR: -16,
        P.shoulderFwdL: -0.6,
        P.shoulderFwdR: -0.6,
      });
      final lift = clasp.w({
        P.upperArmL: -38,
        P.foreArmL: -36,
        P.handL: -30,
        P.upperArmR: -40,
        P.foreArmR: -38,
        P.handR: -32,
        P.shoulderFwdL: -1,
        P.shoulderFwdR: -1,
        P.chestOpen: 1,
        P.spine: 184,
        P.neck: 182,
      });
      return [
        k(b, move: 0.8, hold: 0.4),
        k(clasp, move: 1.0, hold: 0.4),
        k(lift, move: 1.3, hold: 2.6, cue: Cue.hold),
        k(clasp, move: 1.0, hold: 0.2),
      ];
    }()),
    focus: const [BodyArea.chest, BodyArea.shoulders],
  );

  /// Hands support the neck, upper back extends over the backrest.
  static final thoracicExtension = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      Pose withHands(Pose p) {
        final f = p.frame(side);
        final up = dirOf(f.headAngle);
        final back = -perpOf(up);
        final target = f.headCenter + back * 0.11 - up * 0.01;
        return p
            .w({P.upperArmL: 150, P.upperArmR: 155})
            .reachArm(Side.r, target, side, bend: 1, hand: -10)
            .reachArm(Side.l, target + const Offset(-0.01, 0), side, bend: 1, hand: -10);
      }

      final b = withHands(Pose.seatedSide.w({P.hipX: -0.16}));
      final ext = withHands(
        Pose.seatedSide.w({P.hipX: -0.16, P.spine: 196, P.spineCurve: -0.55, P.neck: 200, P.head: 206, P.chestOpen: 1}),
      );
      return [
        k(b, move: 0.8, hold: 0.6, cue: Cue.inhale),
        k(ext, move: 1.4, hold: 1.8, cue: Cue.hold),
        k(b, move: 1.2, hold: 0.2, cue: Cue.exhale),
      ];
    }()),
    focus: const [BodyArea.upperBack],
  );

  /// Arms overhead, bend to the side from the waist.
  static final sideBend = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      Pose arms(Pose p) {
        final f = p.frame(front);
        final up = f.spineTangent(1);
        final top = f.neckBase + up * 0.5;
        return p
            .reachArm(Side.l, top + perpOf(up) * -0.02, front, bend: -1, hand: p[P.spine] + 20)
            .reachArm(Side.r, top + perpOf(up) * 0.02, front, bend: 1, hand: p[P.spine] - 20);
      }

      final b = arms(Pose.seatedFront);
      final bend = arms(Pose.seatedFront.w({P.spine: 158, P.neck: 156, P.head: 160}));
      return [
        k(b, move: 0.9, hold: 0.4, cue: Cue.inhale),
        k(bend, move: 1.4, hold: 2.0, cue: Cue.hold),
        k(b, move: 1.2, hold: 0.4, cue: Cue.inhale),
        k(bend.mirrored(), move: 1.4, hold: 2.0, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.core, BodyArea.lowerBack],
  );
}
