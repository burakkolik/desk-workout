import 'clip_kit.dart';

/// Hips & legs exercises. Sources: HSS seated stretches, Cleveland Clinic
/// desk exercises, NHS sitting & strength exercises, Harvard Health.
abstract final class LegClips {
  static const _floorAnkle = Body.floorY - Body.ankleH;

  /// Ankle on the opposite knee, then a gentle hinge forward.
  static final figureFour = FigureVisual(
    FigureScene.seatedFront,
    poseClip(() {
      final b = Pose.seatedFront;
      var cross = b.w({P.thighL: -74, P.thighLenL: 0.55, P.shinL: 96, P.shinLenL: 0.95, P.footL: 96});
      final f = cross.frame(front);
      cross = cross
          .reachArm(Side.l, f.kneeL + const Offset(0.02, -0.03), front, bend: -1, hand: -10)
          .reachArm(Side.r, f.ankleL + const Offset(0.02, -0.03), front, bend: 1, hand: 20);
      final lean = cross.w({P.headPitch: 0.5, P.shoulderLiftL: -0.4, P.shoulderLiftR: -0.4, P.hipY: 0.47});
      return [
        k(b, move: 0.8, hold: 0.4),
        k(cross, move: 1.4, hold: 0.8),
        k(lean, move: 1.2, hold: 2.6, cue: Cue.hold),
        k(cross, move: 1.0, hold: 0.3),
        k(b, move: 1.2, hold: 0.3),
        k(cross.mirrored(), move: 1.4, hold: 0.8),
        k(lean.mirrored(), move: 1.2, hold: 2.6, cue: Cue.hold),
        k(cross.mirrored(), move: 1.0, hold: 0.3),
      ];
    }()),
    focus: const [BodyArea.hips],
  );

  /// Straighten the knee with toes pulled up, thigh stays on the seat.
  static final legExtension = FigureVisual(
    FigureScene.seatedSide,
    poseClip([
      k(Pose.seatedSide, move: 0.8, hold: 0.4),
      k(Pose.seatedSide.w({P.thighR: 84, P.shinR: 84, P.footR: 168}), move: 1.2, hold: 1.4, cue: Cue.hold),
    ]),
    focus: const [BodyArea.quads],
  );

  /// One leg straight, heel down, toes up; hinge forward with a flat back.
  static final hamstring = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final b = Pose.seatedSide.w({P.hipX: -0.06});
      final straight = b.reachLeg(Side.r, const Offset(0.62, _floorAnkle), side, bend: 1, foot: 160);
      Pose hands(Pose p) {
        final f = p.frame(side);
        final t = Offset.lerp(f.hipR, f.kneeR, 0.55)! + const Offset(0, -0.07);
        return p
            .reachArm(Side.r, t, side, bend: 1, hand: 70)
            .reachArm(Side.l, t + const Offset(-0.02, 0), side, bend: 1, hand: 70);
      }

      final start = hands(straight);
      final hinge = hands(straight.w({P.spine: 150, P.neck: 146, P.head: 150, P.chestOpen: 0.6}));
      return [
        k(hands(b), move: 0.8, hold: 0.4),
        k(start, move: 1.2, hold: 0.6),
        k(hinge, move: 1.6, hold: 2.6, cue: Cue.hold),
        k(start, move: 1.2, hold: 0.3),
      ];
    }()),
    focus: const [BodyArea.hamstrings],
  );

  /// Lift the foot; point the toes away, then pull them up.
  static final anklePumps = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final lifted = Pose.seatedSide.w({P.thighR: 86, P.shinR: 56});
      return [
        k(lifted.w({P.footR: 88}), move: 0.6, hold: 0.25),
        k(lifted.w({P.footR: 168}), move: 0.6, hold: 0.25),
      ];
    }()),
    focus: const [BodyArea.calves, BodyArea.ankles],
  );

  /// Alternate knee lifts, upright torso.
  static final marching = FigureVisual(
    FigureScene.seatedSide,
    poseClip(() {
      final b = Pose.seatedSide.w({P.spine: 180});
      final r = b.w({P.thighR: 124, P.shinR: 14, P.footR: 100});
      final l = b.w({P.thighL: 124, P.shinL: 14, P.footL: 100});
      return [
        k(r, move: 0.45, hold: 0.15),
        k(b, move: 0.4, hold: 0),
        k(l, move: 0.45, hold: 0.15),
        k(b, move: 0.4, hold: 0),
      ];
    }()),
    focus: const [BodyArea.hips, BodyArea.quads],
  );

  static Pose _deskHands(Pose p) {
    const t = Offset(0.43, 0.192);
    return p
        .reachArm(Side.r, t, side, bend: -1, hand: 88)
        .reachArm(Side.l, t + const Offset(-0.01, 0), side, bend: -1, hand: 88);
  }

  /// Rise onto the balls of the feet with light hand support on the desk.
  static final calfRaises = FigureVisual(
    FigureScene.standingSideDesk,
    poseClip(() {
      final b = _deskHands(Pose.standingSide.w({P.hipX: 0.06, P.thighL: 0, P.thighR: 0}));
      final up = _deskHands(b.w({P.hipX: 0.075, P.hipY: -0.015, P.footL: 60, P.footR: 60}));
      return [k(b, move: 0.9, hold: 0.4), k(up, move: 0.9, hold: 1.0, cue: Cue.hold)];
    }()),
    focus: const [BodyArea.calves],
  );

  /// Split stance, back knee straight, pelvis tucked, hip pushed forward.
  static final hipFlexor = FigureVisual(
    FigureScene.standingSide,
    poseClip(() {
      Pose stance(double hipX, double hipY, double frontX, double backX, double backFoot) {
        var p = Pose.standingSide.w({P.hipX: hipX, P.hipY: hipY});
        p = p
            .reachLeg(Side.l, Offset(frontX, _floorAnkle), side, bend: 1, foot: 90)
            .reachLeg(Side.r, Offset(backX, _floorAnkle - (backFoot < 85 ? 0.04 : 0)), side, bend: 1, foot: backFoot);
        final f = p.frame(side);
        return p
            .reachArm(Side.r, f.hip + const Offset(0.06, -0.09), side, bend: -1, hand: 150)
            .reachArm(Side.l, f.hip + const Offset(0.05, -0.09), side, bend: -1, hand: 150);
      }

      final start = stance(-0.05, 0.08, 0.2, -0.38, 60);
      final stretch = stance(0.04, 0.13, 0.2, -0.38, 60).w({P.spine: 182});
      return [k(start, move: 1.0, hold: 0.6), k(stretch, move: 1.4, hold: 2.6, cue: Cue.hold)];
    }()),
    focus: const [BodyArea.hips],
  );

  /// Sit-to-stand with arms crossed on the chest.
  static final chairSquat = FigureVisual(
    FigureScene.standingSideChair,
    poseClip(() {
      const ankle = Offset(0.17, _floorAnkle);
      Pose body(double hipX, double hipY, double spine) {
        var p = Pose.standingSide.w({
          P.hipX: hipX,
          P.hipY: hipY,
          P.spine: spine,
          P.neck: spine - 2,
          P.head: 180 - (180 - spine) * 0.3,
        });
        p = p
            .reachLeg(Side.r, ankle, side, bend: 1, foot: 90)
            .reachLeg(Side.l, ankle + const Offset(-0.01, 0), side, bend: 1, foot: 90);
        final f = p.frame(side);
        final chest = f.spineAt(0.8) + f.spineFwd * 0.13;
        return p
            .reachArm(Side.r, chest, side, bend: -1, hand: spine - 170)
            .reachArm(Side.l, chest + f.spineUp * 0.03, side, bend: -1, hand: spine - 170);
      }

      final seated = body(-0.15, 0.47, 178);
      final lean = body(-0.11, 0.45, 150);
      final standing = body(0.12, 0.075, 180);
      return [
        k(seated, move: 1.2, hold: 0.5),
        k(lean, move: 0.6, hold: 0.1),
        k(standing, move: 1.0, hold: 0.6),
        k(lean, move: 1.3, hold: 0.1),
      ];
    }()),
    focus: const [BodyArea.quads, BodyArea.hips],
  );

  /// Incline push-up on the desk edge, body in one straight line.
  static final deskPushUp = FigureVisual(
    FigureScene.standingSideDesk,
    poseClip(() {
      const ankle = Offset(-0.775, _floorAnkle);
      Pose plank(double spine) {
        final up = dirOf(spine);
        final hip = ankle + up * (Body.thigh + Body.shin);
        final leg = spine - 180;
        final p = Pose.standingSide.w({
          P.hipX: hip.dx,
          P.hipY: hip.dy,
          P.spine: spine,
          P.neck: spine,
          P.head: spine + 6,
          P.thighL: leg,
          P.thighR: leg,
          P.shinL: leg,
          P.shinR: leg,
          P.footL: 74,
          P.footR: 74,
        });
        return _deskHands(p.w({P.upperArmL: 20, P.upperArmR: 20}));
      }

      final top = plank(143);
      final bottom = plank(131);
      return [k(top, move: 1.0, hold: 0.4), k(bottom, move: 1.2, hold: 0.3)];
    }()),
    focus: const [BodyArea.chest, BodyArea.arms],
  );
}
