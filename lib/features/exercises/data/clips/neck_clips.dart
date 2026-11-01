import 'clip_kit.dart';

/// Neck exercises. Sources: HSS seated stretches, NHS sitting exercises,
/// Mayo Clinic neck stretches.
abstract final class NeckClips {
  // Slightly forward "screen posture" to start from.
  static final _slouch = Pose.seatedSide.w({P.neck: 166, P.head: 180, P.spine: 178});

  /// Chin tuck: head glides straight back, gaze stays level.
  static final chinTuck = FigureVisual(
    FigureScene.seatedSideDesk,
    poseClip([
      k(_slouch, move: 0.8, hold: 0.6),
      k(Pose.seatedSide.w({P.neck: 190, P.head: 178, P.spine: 182}), move: 1.1, hold: 2.2, cue: Cue.hold),
      k(_slouch, move: 1.0, hold: 0.3, cue: Cue.relax),
    ]),
    focus: const [BodyArea.neck],
  );

  /// Ear to shoulder, face keeps looking forward.
  static final sideTilt = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      final base = Pose.seatedFront;
      final tilt = base.w({P.neck: 192, P.head: 216, P.shoulderLiftR: -0.2});
      return [
        k(base, move: 0.8, hold: 0.4),
        k(tilt, move: 1.4, hold: 2.6, cue: Cue.hold),
        k(base, move: 1.2, hold: 0.4),
        k(tilt.mirrored(), move: 1.4, hold: 2.6, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.neck],
  );

  /// Turn the head to look over each shoulder, chin level.
  static final rotation = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      final base = Pose.seatedFront;
      final turn = base.w({P.headYaw: 0.95});
      return [
        k(base, move: 0.8, hold: 0.4),
        k(turn, move: 1.3, hold: 1.8, cue: Cue.hold),
        k(base, move: 1.2, hold: 0.4),
        k(turn.mirrored(), move: 1.3, hold: 1.8, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.neck],
  );

  /// Levator scapulae: head turns ~45° away and nose goes towards the
  /// opposite armpit; that hand rests on the back of the head; the stretched
  /// side's hand holds the seat.
  static final levatorScapulae = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      final base = Pose.seatedFront;
      var stretch = base.w({
        P.neck: 196,
        P.head: 208,
        P.headYaw: -0.55,
        P.headPitch: 0.75,
        P.shoulderLiftR: -0.35,
        P.upperArmR: 12,
        P.foreArmR: 8,
        P.foreArmLenR: 1,
        P.handR: 4,
      });
      final head = stretch.frame(front).headCenter;
      stretch = stretch.reachArm(Side.l, head + const Offset(-0.07, -0.085), front, bend: 1, hand: 112);
      return [
        k(base, move: 0.8, hold: 0.4),
        k(stretch, move: 1.6, hold: 3.0, cue: Cue.hold),
        k(base, move: 1.3, hold: 0.4),
        k(stretch.mirrored(), move: 1.6, hold: 3.0, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.neck, BodyArea.shoulders],
  );

  /// Upper trapezius: ear towards the opposite shoulder, opposite hand over
  /// the head adds light pressure, other hand anchors on the seat.
  static final upperTrap = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      final base = Pose.seatedFront;
      var stretch = base.w({
        P.neck: 194,
        P.head: 214,
        P.shoulderLiftR: -0.4,
        P.upperArmR: 12,
        P.foreArmR: 8,
        P.foreArmLenR: 1,
        P.handR: 4,
      });
      final f = stretch.frame(front);
      final up = dirOf(stretch[P.head]);
      final target = f.headCenter + up * 0.09 + perpOf(up) * 0.01;
      stretch = stretch.reachArm(Side.l, target, front, bend: 1, hand: 70);
      return [
        k(base, move: 0.8, hold: 0.4),
        k(stretch, move: 1.6, hold: 3.0, cue: Cue.hold),
        k(base, move: 1.3, hold: 0.4),
        k(stretch.mirrored(), move: 1.6, hold: 3.0, cue: Cue.hold),
      ];
    }()),
    focus: const [BodyArea.neck, BodyArea.shoulders],
  );
}
