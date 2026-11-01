import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../figure/domain/exercise_visual.dart';
import '../../../figure/domain/motion_clip.dart';
import '../../../figure/widgets/exercise_animation.dart';

extension CueL10n on Cue {
  String label(AppLocalizations l) => switch (this) {
    Cue.inhale => l.cueInhale,
    Cue.hold => l.cueHold,
    Cue.exhale => l.cueExhale,
    Cue.relax => l.cueRelax,
    Cue.leftSide => l.cueLeftSide,
    Cue.rightSide => l.cueRightSide,
    Cue.look => l.cueLook,
    Cue.blink => l.cueBlink,
  };
}

/// Rounded, softly lit stage that plays an exercise animation and shows the
/// current cue ("Breathe in", "Hold"…) as an animated pill.
class AnimationStage extends StatefulWidget {
  const AnimationStage({
    super.key,
    required this.visual,
    required this.color,
    this.playing = true,
    this.heroTag,
    this.radius = 32,
  });

  final ExerciseVisual visual;
  final Color color;
  final bool playing;
  final String? heroTag;
  final double radius;

  @override
  State<AnimationStage> createState() => _AnimationStageState();
}

class _AnimationStageState extends State<AnimationStage> {
  Cue? _cue;

  @override
  void didUpdateWidget(AnimationStage old) {
    super.didUpdateWidget(old);
    if (old.visual != widget.visual) _cue = null;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    Widget anim = ExerciseAnimation(
      key: ValueKey(widget.visual),
      visual: widget.visual,
      playing: widget.playing,
      accent: widget.color,
      onCue: (c) => setState(() => _cue = c),
    );
    if (widget.heroTag != null) anim = Hero(tag: widget.heroTag!, child: anim);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        gradient: RadialGradient(
          center: const Alignment(0, -0.3),
          radius: 1.0,
          colors: [widget.color.withValues(alpha: 0.24), AppColors.bgElevated.withValues(alpha: 0.85)],
        ),
        border: Border.all(color: widget.color.withValues(alpha: 0.25)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(padding: const EdgeInsets.all(10), child: anim),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 14,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, a) => FadeTransition(
                    opacity: a,
                    child: ScaleTransition(scale: Tween(begin: 0.8, end: 1.0).animate(a), child: child),
                  ),
                  child: _cue == null
                      ? const SizedBox.shrink()
                      : Container(
                          key: ValueKey(_cue),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.bg.withValues(alpha: 0.75),
                            border: Border.all(color: widget.color.withValues(alpha: 0.6)),
                          ),
                          child: Text(
                            _cue!.label(l),
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: widget.color),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
