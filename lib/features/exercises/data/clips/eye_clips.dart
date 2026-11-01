import 'clip_kit.dart';

/// Eye care routines. Sources: American Academy of Ophthalmology (EyeWiki,
/// computer usage), Moorfields Eye Hospital. Presented as comfort routines.
abstract final class EyeClips {
  static const _open = EyePose();

  /// Every 20 min look ~6 m away for 20 s.
  static final twentyTwenty = EyeVisual(
    eyeClip([
      k(_open, move: 0.6, hold: 1.2, cue: Cue.look),
      k(const EyePose(far: 1, gazeY: -0.5), move: 1.4, hold: 4.0, cue: Cue.look),
      k(const EyePose(far: 1, gazeY: -0.5, open: 0), move: 0.15, hold: 0.1, cue: Cue.blink),
      k(const EyePose(far: 1, gazeY: -0.5), move: 0.15, hold: 2.0, cue: Cue.look),
    ]),
    showTarget: true,
  );

  /// Alternate focus between a near finger and a distant object.
  static final nearFar = EyeVisual(
    eyeClip([
      k(const EyePose(far: 0, gazeY: 0.55, gazeX: 0), move: 1.0, hold: 2.2, cue: Cue.look),
      k(const EyePose(far: 1, gazeY: -0.55), move: 1.0, hold: 2.2, cue: Cue.look),
    ]),
    showTarget: true,
  );

  /// Slow gaze up, down, left and right with the head still.
  static final movements = EyeVisual(
    eyeClip([
      k(_open, move: 0.6, hold: 0.5),
      k(const EyePose(gazeY: -1), move: 0.8, hold: 0.9, cue: Cue.look),
      k(const EyePose(gazeY: 1), move: 1.0, hold: 0.9, cue: Cue.look),
      k(_open, move: 0.6, hold: 0.3),
      k(const EyePose(gazeX: -1), move: 0.8, hold: 0.9, cue: Cue.look),
      k(const EyePose(gazeX: 1), move: 1.0, hold: 0.9, cue: Cue.look),
      k(_open, move: 0.6, hold: 0.3),
      k(const EyePose(open: 0), move: 0.4, hold: 1.0, cue: Cue.relax),
    ]),
  );

  /// Warm cupped palms over closed eyes, no pressure.
  static final palming = EyeVisual(
    eyeClip([
      k(_open, move: 0.6, hold: 0.8),
      k(const EyePose(open: 0), move: 0.6, hold: 0.2, cue: Cue.relax),
      k(const EyePose(open: 0, palms: 1), move: 1.2, hold: 5.0, cue: Cue.relax),
      k(const EyePose(open: 0), move: 1.0, hold: 0.3),
    ]),
  );

  /// Close 2 s, open, close 2 s, gentle squeeze 2 s (AAO blink exercise).
  static final blinking = EyeVisual(
    eyeClip([
      k(_open, move: 0.4, hold: 0.8),
      k(const EyePose(open: 0), move: 0.35, hold: 2.0, cue: Cue.blink),
      k(_open, move: 0.35, hold: 0.8),
      k(const EyePose(open: 0), move: 0.35, hold: 2.0, cue: Cue.blink),
      k(const EyePose(open: 0, squeeze: 1), move: 0.4, hold: 2.0, cue: Cue.hold),
      k(_open, move: 0.5, hold: 0.8, cue: Cue.relax),
    ]),
  );
}
