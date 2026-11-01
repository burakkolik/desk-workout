import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/progress_ring.dart';
import '../../../exercises/data/clips/eye_clips.dart';
import '../../../figure/widgets/exercise_animation.dart';

enum _TimerState { idle, working, eyeBreak, done }

/// In-app 20-20-20 timer: 20 min of work, then a guided 20 s look-away.
class TwentyTimerCard extends StatefulWidget {
  const TwentyTimerCard({super.key});

  @override
  State<TwentyTimerCard> createState() => _TwentyTimerCardState();
}

class _TwentyTimerCardState extends State<TwentyTimerCard> {
  static const _work = 20 * 60;
  static const _break = 20;

  _TimerState _state = _TimerState.idle;
  int _left = _work;
  Timer? _timer;

  void _start() {
    _timer?.cancel();
    setState(() {
      _state = _TimerState.working;
      _left = _work;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _stop() {
    _timer?.cancel();
    setState(() {
      _state = _TimerState.idle;
      _left = _work;
    });
  }

  void _tick() {
    if (!mounted) return;
    setState(() {
      _left--;
      if (_left > 0) return;
      switch (_state) {
        case _TimerState.working:
          HapticFeedback.heavyImpact();
          SystemSound.play(SystemSoundType.alert);
          _state = _TimerState.eyeBreak;
          _left = _break;
        case _TimerState.eyeBreak:
          HapticFeedback.mediumImpact();
          _state = _TimerState.done;
          _left = 3;
        case _TimerState.done:
          _state = _TimerState.working;
          _left = _work;
        case _TimerState.idle:
          break;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final breakMode = _state == _TimerState.eyeBreak;
    final total = breakMode ? _break : _work;
    final color = breakMode ? AppColors.amber : AppColors.violet;
    final ring = ProgressRing(
      progress: _state == _TimerState.idle ? 1 : _left / total,
      size: 170,
      stroke: 14,
      animate: false,
      colors: [color, AppColors.blue, color],
      child: breakMode
          ? Padding(
              padding: const EdgeInsets.all(22),
              child: ExerciseAnimation(visual: EyeClips.twentyTwenty, accent: AppColors.amber),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(clock(_left), style: t.displaySmall!.copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
                if (_state != _TimerState.idle)
                  Text(l.nextEyeBreakIn, style: t.labelSmall!.copyWith(color: AppColors.textMuted)),
              ],
            ),
    );
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l.rule20Title, style: t.headlineSmall),
        const SizedBox(height: 6),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            switch (_state) {
              _TimerState.eyeBreak => '${l.eyeBreakNow} · $_left',
              _TimerState.done => l.eyeBreakDone,
              _ => l.rule20Body,
            },
            key: ValueKey(_state),
            style: t.bodyLarge!.copyWith(color: breakMode ? AppColors.amber : AppColors.textSecondary),
          ),
        ),
        const SizedBox(height: 16),
        GradientButton(
          label: _state == _TimerState.idle ? l.startTimer : l.stopTimer,
          icon: _state == _TimerState.idle ? DwIcons.play : DwIcons.close,
          gradient: _state == _TimerState.idle ? AppGradients.calm : AppGradients.energy,
          expand: false,
          height: 54,
          onTap: _state == _TimerState.idle ? _start : _stop,
        ),
        if (_state != _TimerState.idle) ...[
          const SizedBox(height: 10),
          Text(l.keepAppOpen, style: t.bodySmall!.copyWith(color: AppColors.textMuted)),
        ],
      ],
    );
    return GlassCard(
      glow: color,
      borderColor: color,
      child: LayoutBuilder(
        builder: (context, c) {
          if (c.maxWidth < 460) {
            return Column(children: [ring, const SizedBox(height: 18), text]);
          }
          return Row(
            children: [
              ring,
              const SizedBox(width: 24),
              Expanded(child: text),
            ],
          );
        },
      ),
    );
  }
}
