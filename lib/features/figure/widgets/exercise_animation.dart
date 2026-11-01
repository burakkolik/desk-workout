import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/exercise_visual.dart';
import '../domain/motion_clip.dart';
import '../rendering/breath_painter.dart';
import '../rendering/eye_painter.dart';
import '../rendering/figure_painter.dart';

/// Plays an [ExerciseVisual] in a loop. Reports the current [Cue] so the
/// parent can show "Breathe in" etc.
class ExerciseAnimation extends StatefulWidget {
  const ExerciseAnimation({
    super.key,
    required this.visual,
    this.playing = true,
    this.accent = AppColors.teal,
    this.onCue,
  });

  final ExerciseVisual visual;
  final bool playing;
  final Color accent;
  final ValueChanged<Cue?>? onCue;

  @override
  State<ExerciseAnimation> createState() => _ExerciseAnimationState();
}

class _ExerciseAnimationState extends State<ExerciseAnimation> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _last = Duration.zero;
  double _t = 0;
  Cue? _cue;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    if (widget.playing) _ticker.start();
  }

  @override
  void didUpdateWidget(ExerciseAnimation old) {
    super.didUpdateWidget(old);
    if (old.visual != widget.visual) _t = 0;
    if (widget.playing && !_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    } else if (!widget.playing && _ticker.isActive) {
      _ticker.stop();
    }
  }

  void _tick(Duration elapsed) {
    final dt = _last == Duration.zero ? 0.0 : (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    setState(() => _t += dt.clamp(0.0, 0.1));
  }

  void _reportCue(Cue? cue) {
    if (cue == _cue) return;
    _cue = cue;
    final cb = widget.onCue;
    if (cb != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) cb(cue);
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final v = widget.visual;
    final CustomPainter painter;
    switch (v) {
      case FigureVisual():
        final s = v.clip.sample(_t);
        _reportCue(s.cue);
        painter = FigurePainter(pose: s.value, scene: v.scene, focus: v.focus, pulse: (_t * 0.8) % 1);
      case EyeVisual():
        final s = v.clip.sample(_t);
        _reportCue(s.cue);
        painter = EyePainter(pose: s.value, showTarget: v.showTarget, time: _t);
      case BreathVisual():
        final s = v.clip.sample(_t);
        _reportCue(s.cue);
        painter = BreathPainter(pose: s.value, box: v.box, time: _t, color: widget.accent);
    }
    return RepaintBoundary(
      child: CustomPaint(painter: painter, size: Size.infinite),
    );
  }
}
