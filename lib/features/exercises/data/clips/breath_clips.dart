import 'clip_kit.dart';

/// Breathing exercises. Sources: Cleveland Clinic (box breathing,
/// diaphragmatic breathing).
abstract final class BreathClips {
  /// 4 s in, 4 s hold, 4 s out, 4 s hold.
  static final box = BreathVisual(
    breathClip([
      k(const BreathPose(0, corner: 0), move: 0, hold: 0),
      k(const BreathPose(1, corner: 1), move: 4, hold: 0, cue: Cue.inhale),
      k(const BreathPose(1, corner: 2), move: 4, hold: 0, cue: Cue.hold),
      k(const BreathPose(0, corner: 3), move: 4, hold: 0, cue: Cue.exhale),
      k(const BreathPose(0, corner: 4), move: 4, hold: 0, cue: Cue.hold),
    ]),
    box: true,
  );

  /// Slow belly breathing: 4 s in through the nose, 6 s out through pursed lips.
  static final belly = BreathVisual(
    breathClip([
      k(const BreathPose(0), move: 0, hold: 0.6, cue: Cue.relax),
      k(const BreathPose(1), move: 4, hold: 0.4, cue: Cue.inhale),
      k(const BreathPose(0), move: 6, hold: 0, cue: Cue.exhale),
    ]),
  );
}
