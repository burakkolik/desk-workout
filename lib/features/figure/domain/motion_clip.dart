import 'dart:math' as math;

/// Short on-screen cues shown while a clip plays (localized in the UI layer).
enum Cue { inhale, hold, exhale, relax, leftSide, rightSide, look, blink }

/// One keyframe of an animation.
///
/// [move] = seconds spent travelling from the previous keyframe to this one.
/// [hold] = seconds this keyframe is held still.
class Keyframe<T> {
  const Keyframe(this.value, {this.move = 0.8, this.hold = 0.4, this.cue});

  final T value;
  final double move;
  final double hold;
  final Cue? cue;
}

typedef Lerp<T> = T Function(T a, T b, double t);

/// The result of sampling a [MotionClip] at a point in time.
class ClipSample<T> {
  const ClipSample(this.value, this.cue, this.phase);

  final T value;
  final Cue? cue;

  /// 0..1 progress through the current keyframe segment (move + hold).
  final double phase;
}

/// A looping keyframe animation for any interpolatable value.
class MotionClip<T> {
  const MotionClip(this.frames, this.lerp);

  final List<Keyframe<T>> frames;
  final Lerp<T> lerp;

  double get duration => frames.fold(0.0, (sum, f) => sum + f.move + f.hold).clamp(0.001, 1e9);

  ClipSample<T> sample(double seconds) {
    if (frames.length == 1) {
      return ClipSample(frames.first.value, frames.first.cue, 0);
    }
    var t = seconds % duration;
    for (var i = 0; i < frames.length; i++) {
      final f = frames[i];
      final prev = frames[(i - 1 + frames.length) % frames.length];
      final segment = f.move + f.hold;
      if (t <= segment || i == frames.length - 1) {
        final phase = segment <= 0 ? 0.0 : (t / segment).clamp(0.0, 1.0);
        if (t < f.move) {
          final k = _ease(t / f.move);
          return ClipSample(lerp(prev.value, f.value, k), f.cue, phase);
        }
        return ClipSample(f.value, f.cue, phase);
      }
      t -= segment;
    }
    return ClipSample(frames.last.value, frames.last.cue, 1);
  }

  /// Smooth, natural sine ease-in-out.
  static double _ease(double x) => 0.5 - 0.5 * math.cos(math.pi * x);
}
