import 'dart:ui' show Offset, lerpDouble;

/// Every animatable degree of freedom of the drawn character.
///
/// Angle convention (degrees, absolute / world space):
///   direction vector = (sin a, cos a) in screen space (y grows downwards)
///   0   -> bone points straight down
///   90  -> bone points to screen-right (= "forward" in side view)
///   180 -> bone points straight up
///   -90 -> bone points to screen-left
///
/// Side view: the character faces screen-right. `R` = near side (drawn in
/// front of the torso), `L` = far side (drawn behind, slightly darker).
/// Front view: `L` = screen-left, `R` = screen-right.
enum P {
  hipX,
  hipY,
  spine, // pelvis -> neck base
  spineCurve, // -1..1 side view: + rounds the back (flexion), - arches it
  // front view: lateral curve towards screen-right (+)
  neck,
  head,
  headYaw, // -1..1 (front view: turn the face left/right)
  headPitch, // -1..1 (+ = looking down). Front view shifts the face, side view
  // tilts the head.
  torsoYaw, // -1..1 (front view: twist the chest)
  chestOpen, // 0..1 breathing / chest lift
  shoulderLiftL,
  shoulderLiftR, // 0..1 shrug height
  shoulderFwdL,
  shoulderFwdR, // -1..1 protraction (+) / retraction (-)
  upperArmL,
  foreArmL,
  handL,
  upperArmR,
  foreArmR,
  handR,
  upperArmLenL,
  foreArmLenL,
  upperArmLenR,
  foreArmLenR, // foreshortening multipliers (1 = full length)
  thighL,
  shinL,
  footL,
  thighR,
  shinR,
  footR,
  thighLenL,
  thighLenR,
  shinLenL,
  shinLenR,
  armBehindL,
  armBehindR, // >= 0.5: arm is drawn behind the torso/head (front view)
  eyesClosed, // 0..1
  smile, // 0..1
}

/// A full-body pose. Immutable; build new poses with [copyWith].
class Pose {
  const Pose._(this._v);

  final List<double> _v;

  double operator [](P p) => _v[p.index];

  Offset get hip => Offset(this[P.hipX], this[P.hipY]);

  /// Creates a pose from a base pose with some parameters overridden.
  Pose copyWith(Map<P, double> changes) {
    final next = List<double>.of(_v);
    changes.forEach((k, v) => next[k.index] = v);
    return Pose._(next);
  }

  /// Shorthand alias of [copyWith] used heavily in the clip catalog.
  Pose w(Map<P, double> changes) => copyWith(changes);

  /// Left/right mirror (front view): swaps sides and flips every angle.
  Pose mirrored() {
    final m = List<double>.of(_v);
    double up(double a) => 360 - a;
    double limb(double a) => -a;
    m[P.hipX.index] = -this[P.hipX];
    m[P.spine.index] = up(this[P.spine]);
    m[P.neck.index] = up(this[P.neck]);
    m[P.head.index] = up(this[P.head]);
    m[P.spineCurve.index] = -this[P.spineCurve];
    m[P.headYaw.index] = -this[P.headYaw];
    m[P.torsoYaw.index] = -this[P.torsoYaw];
    const pairs = [
      [P.shoulderLiftL, P.shoulderLiftR, 0],
      [P.shoulderFwdL, P.shoulderFwdR, 0],
      [P.upperArmL, P.upperArmR, 1],
      [P.foreArmL, P.foreArmR, 1],
      [P.handL, P.handR, 1],
      [P.upperArmLenL, P.upperArmLenR, 0],
      [P.foreArmLenL, P.foreArmLenR, 0],
      [P.thighL, P.thighR, 1],
      [P.shinL, P.shinR, 1],
      [P.footL, P.footR, 1],
      [P.thighLenL, P.thighLenR, 0],
      [P.shinLenL, P.shinLenR, 0],
      [P.armBehindL, P.armBehindR, 0],
    ];
    for (final pair in pairs) {
      final l = pair[0] as P;
      final r = pair[1] as P;
      final isAngle = pair[2] == 1;
      m[l.index] = isAngle ? limb(this[r]) : this[r];
      m[r.index] = isAngle ? limb(this[l]) : this[l];
    }
    return Pose._(m);
  }

  static Pose lerp(Pose a, Pose b, double t) {
    final out = List<double>.filled(P.values.length, 0);
    for (var i = 0; i < out.length; i++) {
      out[i] = lerpDouble(a._v[i], b._v[i], t)!;
    }
    return Pose._(out);
  }

  static Pose _from(Map<P, double> values) {
    final v = List<double>.filled(P.values.length, 0);
    // Neutral defaults.
    v[P.spine.index] = 180;
    v[P.neck.index] = 180;
    v[P.head.index] = 180;
    for (final p in [
      P.upperArmLenL,
      P.foreArmLenL,
      P.upperArmLenR,
      P.foreArmLenR,
      P.thighLenL,
      P.thighLenR,
      P.shinLenL,
      P.shinLenR,
    ]) {
      v[p.index] = 1;
    }
    values.forEach((k, val) => v[k.index] = val);
    return Pose._(v);
  }

  // ---------------------------------------------------------------------------
  // Base poses. Scene units: the floor is at y = Skeleton.floorY.
  // ---------------------------------------------------------------------------

  /// Sitting upright on an office chair, seen from the side, hands resting
  /// on the thighs.
  static final seatedSide = _from({
    P.hipX: -0.18,
    P.hipY: 0.47,
    P.spine: 182,
    P.neck: 176,
    P.head: 180,
    P.upperArmL: 14,
    P.foreArmL: 78,
    P.handL: 92,
    P.upperArmR: 10,
    P.foreArmR: 74,
    P.handR: 90,
    P.thighL: 92,
    P.shinL: 2,
    P.footL: 90,
    P.thighR: 88,
    P.shinR: -2,
    P.footR: 90,
    P.smile: 0.4,
  });

  /// Sitting upright on an office chair, facing the viewer.
  static final seatedFront = _from({
    P.hipX: 0,
    P.hipY: 0.47,
    P.upperArmL: -8,
    P.foreArmL: 22,
    P.handL: 20,
    P.foreArmLenL: 0.8,
    P.upperArmR: 8,
    P.foreArmR: -22,
    P.handR: -20,
    P.foreArmLenR: 0.8,
    P.thighL: -14,
    P.thighLenL: 0.13,
    P.shinL: -3,
    P.shinLenL: 0.9,
    P.thighR: 14,
    P.thighLenR: 0.13,
    P.shinR: 3,
    P.shinLenR: 0.9,
    P.smile: 0.4,
  });

  /// Standing tall, seen from the side.
  static final standingSide = _from({
    P.hipX: -0.05,
    P.hipY: 0.07,
    P.spine: 180,
    P.neck: 178,
    P.head: 180,
    P.upperArmL: 4,
    P.foreArmL: 10,
    P.handL: 10,
    P.upperArmR: -2,
    P.foreArmR: 6,
    P.handR: 6,
    P.thighL: 2,
    P.shinL: 0,
    P.footL: 90,
    P.thighR: -2,
    P.shinR: 0,
    P.footR: 90,
    P.smile: 0.4,
  });

  /// Standing tall, facing the viewer.
  static final standingFront = _from({
    P.hipX: 0,
    P.hipY: 0.07,
    P.upperArmL: -10,
    P.foreArmL: -6,
    P.handL: -4,
    P.upperArmR: 10,
    P.foreArmR: 6,
    P.handR: 4,
    P.thighL: -4,
    P.shinL: -1,
    P.thighR: 4,
    P.shinR: 1,
    P.smile: 0.4,
  });
}
