import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/entrance.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/icon_badge.dart';
import '../../../core/widgets/tag_chip.dart';
import '../../workout_player/presentation/workout_player_screen.dart';
import '../domain/exercise.dart';
import 'body_area_l10n.dart';
import 'widgets/animation_stage.dart';

/// Everything about one exercise: live animation, steps, tip, safety and
/// source. Two-pane on tablets / landscape.
class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key, required this.exercise});

  final Exercise exercise;

  void _start(BuildContext context) {
    Navigator.of(
      context,
    ).push(AppRoutes.slideUp(WorkoutPlayerScreen(exercises: [exercise], title: exercise.name(context.l10n))));
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final color = exercise.category.color;
    final stage = AnimationStage(visual: exercise.visual, color: color, heroTag: 'ex-${exercise.id}');
    final l = context.l10n;
    final button = GradientButton(
      label: l.startExercise,
      icon: DwIcons.play,
      gradient: AppGradients.of(color),
      onTap: () => _start(context),
    );

    return Scaffold(
      body: AppBackground(
        colors: [color, AppColors.blue, AppColors.violet],
        child: SafeArea(
          child: rs.twoPane
              ? Column(
                  children: [
                    AppTopBar(title: exercise.name(l)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(rs.pad, 0, rs.pad, 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(flex: 11, child: stage),
                            SizedBox(width: rs.pad),
                            Expanded(
                              flex: 10,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(child: _Info(exercise: exercise)),
                                  ),
                                  const SizedBox(height: 12),
                                  button,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const AppTopBar(),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: rs.pad),
                              child: SizedBox(height: (rs.height * 0.42).clamp(260.0, 520.0), child: stage),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(rs.pad, 20, rs.pad, 24),
                              child: _Info(exercise: exercise),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(rs.pad, 6, rs.pad, 14), child: button),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final color = exercise.category.color;
    final steps = exercise.stepList(l);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Entrance(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              TagChip(label: exercise.category.label(l), icon: exercise.category.icon, color: color),
              TagChip(
                label: exercise.standing ? l.standingLabel : l.seatedLabel,
                icon: DwIcons.chair,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Entrance(index: 1, child: Text(exercise.name(l), style: t.displaySmall)),
        const SizedBox(height: 8),
        Entrance(
          index: 2,
          child: Text(exercise.summary(l), style: t.bodyLarge!.copyWith(color: AppColors.textSecondary)),
        ),
        const SizedBox(height: 18),
        Entrance(
          index: 3,
          child: Row(
            children: [
              Expanded(
                child: _Stat(icon: DwIcons.target, value: exercise.dose.label(l), color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Stat(icon: DwIcons.clock, value: l.secondsShort(exercise.durationSec), color: AppColors.blue),
              ),
            ],
          ),
        ),
        if (exercise.focus.isNotEmpty) ...[
          const SizedBox(height: 22),
          Text(l.targetAreas, style: t.titleLarge),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final a in exercise.focus) TagChip(label: a.label(l), color: AppColors.teal)],
          ),
        ],
        const SizedBox(height: 24),
        Text(l.howTo, style: t.titleLarge),
        const SizedBox(height: 12),
        for (var i = 0; i < steps.length; i++)
          Entrance(
            index: 4 + i,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: AppGradients.of(color)),
                    child: Text('${i + 1}', style: t.titleSmall!.copyWith(color: AppColors.bg)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(steps[i], style: t.bodyLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 10),
        GlassCard(
          borderColor: AppColors.amber,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconBadge(icon: DwIcons.bulb, color: AppColors.amber, size: 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.proTip, style: t.titleMedium!.copyWith(color: AppColors.amber)),
                    const SizedBox(height: 4),
                    Text(exercise.tip(l), style: t.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DwIcon(DwIcons.info, size: 20, color: AppColors.textMuted),
            const SizedBox(width: 10),
            Expanded(
              child: Text(l.safetyNote, style: t.bodySmall!.copyWith(color: AppColors.textMuted)),
            ),
          ],
        ),
        if (exercise.source != null) ...[
          const SizedBox(height: 10),
          SelectableText(
            '${l.sourceLabel}: ${exercise.source}',
            style: t.bodySmall!.copyWith(color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value, required this.color});

  final DwIcons icon;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      radius: 20,
      child: Row(
        children: [
          DwIcon(icon, size: 24, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.titleSmall, maxLines: 2)),
        ],
      ),
    );
  }
}
