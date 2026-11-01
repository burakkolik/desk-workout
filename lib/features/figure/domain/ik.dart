import 'dart:math' as math;
import 'dart:ui';

import 'pose.dart';
import 'skeleton.dart';

enum Side { l, r }

double angleOf(Offset d) => math.atan2(d.dx, d.dy) * 180 / math.pi;

/// Returns [a] shifted by multiples of 360 so it is closest to [ref]
/// (keeps keyframe interpolation on the short path).
double nearAngle(double a, double ref) {
  var x = a;
  while (x - ref > 180) {
    x -= 360;
  }
  while (x - ref < -180) {
    x += 360;
  }
  return x;
}

/// Inverse kinematics helpers used to author poses: place a wrist or an ankle
/// exactly on a target point and let the elbow / knee bend naturally.
extension PoseIk on Pose {
  /// Moves the wrist of [side] to [target]. [bend] (+1 / -1) picks on which
  /// side of the shoulder-wrist line the elbow goes. [hand] optionally sets
  /// the absolute hand angle.
  Pose reachArm(Side side, Offset target, FigureView view, {int bend = 1, double? hand}) {
    final f = SkeletonFrame.solve(this, view);
    final isL = side == Side.l;
    final s = isL ? f.shoulderL : f.shoulderR;
    final a = Body.upperArm * this[isL ? P.upperArmLenL : P.upperArmLenR];
    final b = Body.foreArm * this[isL ? P.foreArmLenL : P.foreArmLenR];
    final (upper, lower) = _twoBone(s, target, a, b, bend);
    final pu = isL ? P.upperArmL : P.upperArmR;
    final pf = isL ? P.foreArmL : P.foreArmR;
    final ph = isL ? P.handL : P.handR;
    final u = nearAngle(upper, this[pu]);
    final lo = nearAngle(lower, u);
    return copyWith({pu: u, pf: lo, ph: hand == null ? lo : nearAngle(hand, lo)});
  }

  /// Moves the ankle of [side] to [target]; [bend] +1 bends the knee forward
  /// (towards screen-right in side view).
  Pose reachLeg(Side side, Offset target, FigureView view, {int bend = 1, double? foot}) {
    final f = SkeletonFrame.solve(this, view);
    final isL = side == Side.l;
    final h = isL ? f.hipL : f.hipR;
    final a = Body.thigh * this[isL ? P.thighLenL : P.thighLenR];
    final b = Body.shin * this[isL ? P.shinLenL : P.shinLenR];
    // A forward knee lies on the counter-clockwise side for a downward leg.
    final (upper, lower) = _twoBone(h, target, a, b, bend);
    final pt = isL ? P.thighL : P.thighR;
    final ps = isL ? P.shinL : P.shinR;
    final pf = isL ? P.footL : P.footR;
    final t = nearAngle(upper, this[pt]);
    return copyWith({pt: t, ps: nearAngle(lower, t), pf: ?foot});
  }

  /// Solved skeleton (handy for computing targets relative to the body).
  SkeletonFrame frame(FigureView view) => SkeletonFrame.solve(this, view);
}

(double, double) _twoBone(Offset root, Offset target, double a, double b, int bend) {
  final v = target - root;
  final d = v.distance.clamp((a - b).abs() + 1e-4, a + b - 1e-4);
  final phi = angleOf(v);
  final cosA = ((a * a + d * d - b * b) / (2 * a * d)).clamp(-1.0, 1.0);
  final alpha = math.acos(cosA) * 180 / math.pi;
  final upper = phi + bend * alpha;
  final mid = root + dirOf(upper) * a;
  final reachPoint = root + (v / v.distance) * d;
  final lower = angleOf(reachPoint - mid);
  return (upper, lower);
}
