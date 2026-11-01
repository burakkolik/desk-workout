import 'package:flutter/material.dart';

import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/progress_ring.dart';
import '../../../figure/widgets/exercise_thumbnail.dart';
import '../../application/workout_session.dart';

/// Close button, title, "Exercise x of y" and the segmented progress bar.
class PlayerHeader extends StatelessWidget {
  const PlayerHeader({super.key, required this.title, required this.session, required this.onClose});

  final String title;
  final WorkoutSession session;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final n = session.exercises.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 10),
      child: Column(
        children: [
          Row(
            children: [
              CircleIconButton(icon: DwIcons.close, onTap: onClose, size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: t.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(
                      l.exerciseOf(session.index + 1, n),
                      style: t.bodySmall!.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < n; i++)
                Expanded(
                  child: Container(
                    height: 6,
                    margin: EdgeInsets.only(right: i == n - 1 ? 0 : 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: (session.overallProgress * n - i).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          gradient: AppGradients.of(session.exercises[i].category.color),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Get-ready / rest overlay with a big countdown and the next exercise.
class PhaseOverlay extends StatelessWidget {
  const PhaseOverlay({super.key, required this.session, required this.color});

  final WorkoutSession session;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rest = session.phase == SessionPhase.rest;
    final ex = session.current;
    final secs = session.remainingSeconds;
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        color: AppColors.bg.withValues(alpha: 0.82),
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, c) {
            final ring = (c.biggest.shortestSide * 0.42).clamp(110.0, 240.0);
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rest ? l.restLabel : l.getReady,
                      style: t.headlineMedium!.copyWith(color: color, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 16),
                    ProgressRing(
                      progress: 1 - session.phaseProgress,
                      size: ring,
                      stroke: 12,
                      animate: false,
                      colors: [color, AppColors.blue, color],
                      child: TweenAnimationBuilder<double>(
                        key: ValueKey(secs),
                        tween: Tween(begin: 1.35, end: 1),
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutBack,
                        builder: (context, s, child) => Transform.scale(scale: s, child: child),
                        child: Text('$secs', style: t.displayLarge!.copyWith(fontSize: ring * 0.36)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      l.upNext.toUpperCase(),
                      style: t.labelSmall!.copyWith(color: AppColors.textMuted, letterSpacing: 2),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 56,
                          height: 56,
                          child: ExerciseThumbnail(visual: ex.visual, color: ex.category.color),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(ex.name(l), style: t.titleLarge, textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    if (session.paused) ...[
                      const SizedBox(height: 10),
                      Text(l.pausedLabel, style: t.titleMedium!.copyWith(color: AppColors.amber)),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Name, dose, timer and the auto-advancing step guide.
class ExerciseInfoPanel extends StatelessWidget {
  const ExerciseInfoPanel({super.key, required this.session, this.showAllSteps = false, this.compact = false});

  final WorkoutSession session;
  final bool showAllSteps;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final ex = session.current;
    final color = ex.category.color;
    final steps = ex.stepList(l);
    final active = session.phase == SessionPhase.active;
    final si = session.stepIndex(steps.length);
    final ringSize = compact ? 78.0 : 96.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ex.name(l),
                    style: compact ? t.headlineSmall : t.headlineMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(ex.dose.label(l), style: t.titleMedium!.copyWith(color: color)),
                  if (session.paused)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(l.pausedLabel, style: t.titleSmall!.copyWith(color: AppColors.amber)),
                    ),
                ],
              ),
            ),
            ProgressRing(
              progress: active ? 1 - session.phaseProgress : 1,
              size: ringSize,
              stroke: 8,
              animate: false,
              colors: [color, AppColors.blue, color],
              child: Text(
                clock(active ? session.remainingSeconds : ex.durationSec),
                style: t.titleLarge!.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (showAllSteps)
          for (var i = 0; i < steps.length; i++)
            _StepRow(n: i + 1, text: steps[i], active: active && i == si, color: color)
        else
          GlassCard(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            radius: 22,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, a) => FadeTransition(
                opacity: a,
                child: SlideTransition(
                  position: Tween(begin: const Offset(0.08, 0), end: Offset.zero).animate(a),
                  child: child,
                ),
              ),
              child: Row(
                key: ValueKey('${ex.id}-$si'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: AppGradients.of(color)),
                    child: Text('${si + 1}', style: t.titleSmall!.copyWith(color: AppColors.bg)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      steps.isEmpty ? '' : steps[si],
                      style: t.bodyLarge,
                      maxLines: compact ? 3 : 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.n, required this.text, required this.active, required this.color});

  final int n;
  final String text;
  final bool active;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: active ? color.withValues(alpha: 0.14) : Colors.transparent,
        border: Border.all(color: active ? color.withValues(alpha: 0.5) : Colors.transparent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$n', style: t.titleMedium!.copyWith(color: active ? color : AppColors.textMuted)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: t.bodyLarge!.copyWith(color: active ? AppColors.textPrimary : AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
