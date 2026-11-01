import 'dart:ui' show lerpDouble;

import 'figure_scene.dart';
import 'motion_clip.dart';
import 'pose.dart';
import 'skeleton.dart';

/// What is drawn for an exercise.
sealed class ExerciseVisual {
  const ExerciseVisual();

  double get loopSeconds;
}

/// Full-body character animation.
class FigureVisual extends ExerciseVisual {
  const FigureVisual(this.scene, this.clip, {this.focus = const []});

  final FigureScene scene;
  final MotionClip<Pose> clip;
  final List<BodyArea> focus;

  @override
  double get loopSeconds => clip.duration;
}

/// Close-up eyes animation (gaze, blinking, palming, focus distance).
class EyeVisual extends ExerciseVisual {
  const EyeVisual(this.clip, {this.showTarget = false});

  final MotionClip<EyePose> clip;

  /// Draws a near/far focus target (thumb / distant object).
  final bool showTarget;

  @override
  double get loopSeconds => clip.duration;
}

/// Breathing guide (expanding orb + path).
class BreathVisual extends ExerciseVisual {
  const BreathVisual(this.clip, {this.box = false});

  final MotionClip<BreathPose> clip;

  /// Draws the square path of box breathing.
  final bool box;

  @override
  double get loopSeconds => clip.duration;
}

class EyePose {
  const EyePose({this.gazeX = 0, this.gazeY = 0, this.open = 1, this.palms = 0, this.far = 0, this.squeeze = 0});

  /// -1..1 iris position.
  final double gazeX, gazeY;

  /// 0 = closed, 1 = open.
  final double open;

  /// 0..1 cupped palms covering the eyes.
  final double palms;

  /// 0 = focusing near, 1 = focusing far (pupil + target blur).
  final double far;

  /// 0..1 gentle squeeze.
  final double squeeze;

  static EyePose lerp(EyePose a, EyePose b, double t) => EyePose(
    gazeX: lerpDouble(a.gazeX, b.gazeX, t)!,
    gazeY: lerpDouble(a.gazeY, b.gazeY, t)!,
    open: lerpDouble(a.open, b.open, t)!,
    palms: lerpDouble(a.palms, b.palms, t)!,
    far: lerpDouble(a.far, b.far, t)!,
    squeeze: lerpDouble(a.squeeze, b.squeeze, t)!,
  );
}

class BreathPose {
  const BreathPose(this.fill, {this.corner = 0});

  /// 0 = empty lungs, 1 = full.
  final double fill;

  /// Box breathing path progress 0..4 (one unit per side).
  final double corner;

  static BreathPose lerp(BreathPose a, BreathPose b, double t) =>
      BreathPose(lerpDouble(a.fill, b.fill, t)!, corner: lerpDouble(a.corner, b.corner, t)!);
}

extension ExerciseVisualFocus on ExerciseVisual {
  /// Body areas highlighted for figure animations (empty for eyes/breathing).
  List<BodyArea> get focusAreas => switch (this) {
    final FigureVisual f => f.focus,
    _ => const <BodyArea>[],
  };
}
