import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../exercises/domain/exercise.dart';

enum SessionPhase { getReady, active, rest, complete }

/// Drives a guided workout: get-ready countdown → exercise → rest → … →
/// complete. A single [AnimationController] per phase gives a smooth timer
/// ring and makes pause/resume trivial.
class WorkoutSession extends ChangeNotifier {
  WorkoutSession({required this.exercises, required TickerProvider vsync})
    : _controller = AnimationController(vsync: vsync) {
    _controller.addListener(notifyListeners);
    _controller.addStatusListener((s) {
      if (s == AnimationStatus.completed) _advance();
    });
    _startPhase(SessionPhase.getReady);
  }

  static const getReadySeconds = 5;
  static const restSeconds = 10;

  final List<Exercise> exercises;
  final AnimationController _controller;

  SessionPhase _phase = SessionPhase.getReady;
  int _index = 0;
  int _activeSeconds = 0;
  int _completed = 0;
  bool _paused = false;
  int _lastWholeSecond = -1;

  SessionPhase get phase => _phase;
  int get index => _index;
  Exercise get current => exercises[_index];
  Exercise? get next => _index + 1 < exercises.length ? exercises[_index + 1] : null;
  bool get paused => _paused;
  int get activeSeconds => _activeSeconds;
  int get completedCount => _completed;
  bool get isFirst => _index == 0;

  /// 0..1 progress of the current phase.
  double get phaseProgress => _controller.value;

  int get phaseSeconds => switch (_phase) {
    SessionPhase.getReady => getReadySeconds,
    SessionPhase.active => current.durationSec,
    SessionPhase.rest => restSeconds,
    SessionPhase.complete => 0,
  };

  int get remainingSeconds => (phaseSeconds * (1 - _controller.value)).ceil();

  /// Overall progress across all exercises (0..1).
  double get overallProgress {
    if (_phase == SessionPhase.complete) return 1;
    final done = _index + (_phase == SessionPhase.active ? _controller.value : (_phase == SessionPhase.rest ? 1 : 0));
    return done / exercises.length;
  }

  /// Index of the step to highlight, spread evenly over the exercise time.
  int stepIndex(int stepCount) {
    if (_phase != SessionPhase.active || stepCount == 0) return 0;
    return (_controller.value * stepCount).floor().clamp(0, stepCount - 1);
  }

  void _startPhase(SessionPhase p) {
    _phase = p;
    _lastWholeSecond = -1;
    if (p == SessionPhase.complete) {
      _controller.stop();
      HapticFeedback.heavyImpact();
      notifyListeners();
      return;
    }
    _controller.duration = Duration(seconds: phaseSeconds);
    _controller.value = 0;
    if (!_paused) _controller.forward();
    if (p == SessionPhase.active) HapticFeedback.mediumImpact();
    notifyListeners();
  }

  void _advance() {
    switch (_phase) {
      case SessionPhase.getReady:
        _startPhase(SessionPhase.active);
      case SessionPhase.active:
        _activeSeconds += current.durationSec;
        _completed++;
        if (next == null) {
          _startPhase(SessionPhase.complete);
        } else {
          _index++;
          _startPhase(SessionPhase.rest);
        }
      case SessionPhase.rest:
        _startPhase(SessionPhase.active);
      case SessionPhase.complete:
        break;
    }
  }

  /// Light haptic tick for the last 3 seconds of a phase.
  void tickFeedback() {
    final r = remainingSeconds;
    if (r != _lastWholeSecond) {
      _lastWholeSecond = r;
      if (r <= 3 && r > 0 && !_paused) HapticFeedback.selectionClick();
    }
  }

  void togglePause() {
    _paused = !_paused;
    if (_paused) {
      _controller.stop();
    } else if (_phase != SessionPhase.complete) {
      _controller.forward();
    }
    notifyListeners();
  }

  void skip() {
    if (_phase == SessionPhase.active) {
      // Credit the time actually spent.
      _activeSeconds += (current.durationSec * _controller.value).round();
      if (_controller.value > 0.5) _completed++;
      if (next == null) {
        _startPhase(SessionPhase.complete);
      } else {
        _index++;
        _startPhase(SessionPhase.rest);
      }
    } else {
      _advance();
    }
  }

  void previous() {
    if (_phase == SessionPhase.active && _controller.value > 0.15) {
      _startPhase(SessionPhase.active); // restart current
    } else if (_index > 0) {
      _index--;
      _startPhase(SessionPhase.active);
    } else {
      _startPhase(SessionPhase.active);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
