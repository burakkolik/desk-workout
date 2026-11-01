import '../../../figure/domain/exercise_visual.dart';
import '../../../figure/domain/motion_clip.dart';
import '../../../figure/domain/pose.dart';
import '../../../figure/domain/skeleton.dart';

export 'dart:ui' show Offset;

export '../../../figure/domain/exercise_visual.dart';
export '../../../figure/domain/figure_scene.dart';
export '../../../figure/domain/ik.dart';
export '../../../figure/domain/motion_clip.dart';
export '../../../figure/domain/pose.dart';
export '../../../figure/domain/skeleton.dart';

/// Authoring helpers for the clip catalog.
const side = FigureView.side;
const front = FigureView.front;

MotionClip<Pose> poseClip(List<Keyframe<Pose>> frames) => MotionClip(frames, Pose.lerp);

MotionClip<EyePose> eyeClip(List<Keyframe<EyePose>> frames) => MotionClip(frames, EyePose.lerp);

MotionClip<BreathPose> breathClip(List<Keyframe<BreathPose>> frames) => MotionClip(frames, BreathPose.lerp);

Keyframe<T> k<T>(T value, {double move = 0.9, double hold = 0.4, Cue? cue}) =>
    Keyframe(value, move: move, hold: hold, cue: cue);
