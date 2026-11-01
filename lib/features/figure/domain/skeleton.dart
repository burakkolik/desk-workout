import 'dart:math' as math;
import 'dart:ui';

import 'pose.dart';

/// Camera angle of the drawn character.
enum FigureView { side, front }

/// Body regions that an exercise targets (rendered as a soft pulsing glow).
enum BodyArea {
  neck,
  shoulders,
  upperBack,
  chest,
  arms,
  wrists,
  lowerBack,
  core,
  hips,
  hamstrings,
  quads,
  calves,
  ankles,
}

/// Body proportions in scene units (~1 unit ≈ 1 metre for a 1.72 m adult).
abstract final class Body {
  static const floorY = 0.95;
  static const headR = 0.105;
  static const torsoLen = 0.50;
  static const neckLen = 0.07;
  static const upperArm = 0.29;
  static const foreArm = 0.255;
  static const hand = 0.095;
  static const thigh = 0.42;
  static const shin = 0.41;
  static const ankleH = 0.06;
  static const foot = 0.17;
  static const shoulderHalf = 0.165;
  static const hipHalf = 0.09;
}

Offset dirOf(double deg) {
  final r = deg * math.pi / 180;
  return Offset(math.sin(r), math.cos(r));
}

/// Perpendicular: for an upward bone this points to screen-right / forward.
Offset perpOf(Offset d) => Offset(-d.dy, d.dx);

/// Resolved joint positions of a [Pose] (forward kinematics).
class SkeletonFrame {
  SkeletonFrame._(this.pose, this.view);

  factory SkeletonFrame.solve(Pose p, FigureView view) {
    final f = SkeletonFrame._(p, view);
    f._solve();
    return f;
  }

  final Pose pose;
  final FigureView view;

  late Offset hip, neckBase, headBase, headCenter;
  late Offset spineUp, spineFwd, spineCtrl;
  late Offset shoulderL, shoulderR, elbowL, elbowR, wristL, wristR;
  late Offset handTipL, handTipR;
  late Offset hipL, hipR, kneeL, kneeR, ankleL, ankleR, toeL, toeR;

  bool get isSide => view == FigureView.side;

  /// Effective head angle (side view folds the pitch into the angle).
  double get headAngle => isSide ? pose[P.head] - pose[P.headPitch] * 28 : pose[P.head];

  void _solve() {
    final p = pose;
    hip = p.hip;
    spineUp = dirOf(p[P.spine]);
    spineFwd = perpOf(spineUp);
    neckBase = hip + spineUp * Body.torsoLen;
    // Control point of the curved spine (quadratic bezier hip -> neckBase).
    final mid = (hip + neckBase) / 2;
    // Front view: the pelvis stays level, so the lower spine leaves the hips
    // vertically and the torso curves into its lean (side bends, twists).
    spineCtrl = isSide
        ? mid - spineFwd * (p[P.spineCurve] * 0.11)
        : hip + const Offset(0, -Body.torsoLen * 0.5) + const Offset(1, 0) * (p[P.spineCurve] * 0.11);

    final neckDir = dirOf(p[P.neck]);
    headBase = neckBase + neckDir * Body.neckLen;
    headCenter = headBase + dirOf(headAngle) * (Body.headR * 0.92);

    // Shoulders
    final down = -spineUp;
    final base = neckBase + down * 0.05;
    if (isSide) {
      shoulderL = base + spineFwd * (p[P.shoulderFwdL] * 0.05 - 0.012) + spineUp * (p[P.shoulderLiftL] * 0.055);
      shoulderR = base + spineFwd * (p[P.shoulderFwdR] * 0.05) + spineUp * (p[P.shoulderLiftR] * 0.055);
    } else {
      final yaw = p[P.torsoYaw];
      final half = Body.shoulderHalf * math.cos(yaw * 0.9);
      final across = perpOf(spineUp); // screen-right when upright
      shoulderL = base - across * half + spineUp * (p[P.shoulderLiftL] * 0.06) + across * (p[P.shoulderFwdL] * 0.02);
      shoulderR = base + across * half + spineUp * (p[P.shoulderLiftR] * 0.06) - across * (p[P.shoulderFwdR] * 0.02);
    }

    elbowL = shoulderL + dirOf(p[P.upperArmL]) * (Body.upperArm * p[P.upperArmLenL]);
    wristL = elbowL + dirOf(p[P.foreArmL]) * (Body.foreArm * p[P.foreArmLenL]);
    handTipL = wristL + dirOf(p[P.handL]) * Body.hand;
    elbowR = shoulderR + dirOf(p[P.upperArmR]) * (Body.upperArm * p[P.upperArmLenR]);
    wristR = elbowR + dirOf(p[P.foreArmR]) * (Body.foreArm * p[P.foreArmLenR]);
    handTipR = wristR + dirOf(p[P.handR]) * Body.hand;

    // Legs
    if (isSide) {
      hipL = hip + const Offset(-0.01, 0);
      hipR = hip;
    } else {
      hipL = hip - const Offset(Body.hipHalf, 0);
      hipR = hip + const Offset(Body.hipHalf, 0);
    }
    kneeL = hipL + dirOf(p[P.thighL]) * (Body.thigh * p[P.thighLenL]);
    ankleL = kneeL + dirOf(p[P.shinL]) * (Body.shin * p[P.shinLenL]);
    toeL = ankleL + dirOf(p[P.footL]) * Body.foot;
    kneeR = hipR + dirOf(p[P.thighR]) * (Body.thigh * p[P.thighLenR]);
    ankleR = kneeR + dirOf(p[P.shinR]) * (Body.shin * p[P.shinLenR]);
    toeR = ankleR + dirOf(p[P.footR]) * Body.foot;
  }

  /// Point on the (curved) spine; s = 0 at the pelvis, 1 at the neck base.
  Offset spineAt(double s) {
    final u = 1 - s;
    return hip * (u * u) + spineCtrl * (2 * u * s) + neckBase * (s * s);
  }

  /// Unit tangent of the spine at s (pointing up the spine).
  Offset spineTangent(double s) {
    final d = (spineCtrl - hip) * (2 * (1 - s)) + (neckBase - spineCtrl) * (2 * s);
    final len = d.distance;
    return len == 0 ? spineUp : d / len;
  }

  Offset areaCenter(BodyArea area) {
    switch (area) {
      case BodyArea.neck:
        return (neckBase + headBase) / 2;
      case BodyArea.shoulders:
        return isSide ? shoulderR : (shoulderL + shoulderR) / 2;
      case BodyArea.upperBack:
        return spineAt(0.78) - spineTangent(0.78).perp() * (isSide ? 0.07 : 0);
      case BodyArea.chest:
        return spineAt(0.74) + spineTangent(0.74).perp() * (isSide ? 0.08 : 0);
      case BodyArea.arms:
        return (elbowR + shoulderR) / 2;
      case BodyArea.wrists:
        return isSide ? wristR : (wristL + wristR) / 2;
      case BodyArea.lowerBack:
        return spineAt(0.25) - spineTangent(0.25).perp() * (isSide ? 0.08 : 0);
      case BodyArea.core:
        return spineAt(0.35) + spineTangent(0.35).perp() * (isSide ? 0.06 : 0);
      case BodyArea.hips:
        return hip;
      case BodyArea.hamstrings:
        return (hipR + kneeR) / 2 + const Offset(0, 0.04);
      case BodyArea.quads:
        return (hipR + kneeR) / 2;
      case BodyArea.calves:
        return (kneeR + ankleR) / 2;
      case BodyArea.ankles:
        return ankleR;
    }
  }
}

extension on Offset {
  Offset perp() => Offset(-dy, dx);
}
