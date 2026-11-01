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
import '../../../core/widgets/responsive_grid.dart';
import '../../figure/widgets/exercise_thumbnail.dart';
import '../../workout_player/presentation/workout_player_screen.dart';
import '../data/routine_catalog.dart';
import '../domain/routine.dart';
import 'exercise_detail_screen.dart';
import 'widgets/routine_card.dart';

/// Program overview: header card + ordered exercise list + start button.
class RoutineDetailScreen extends StatelessWidget {
  const RoutineDetailScreen({super.key, required this.routine});

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final rs = context.rs;
    final t = Theme.of(context).textTheme;
    final exercises = RoutineCatalog.exercisesOf(routine);
    return Scaffold(
      body: AppBackground(
        colors: [routine.gradient.colors.first, routine.gradient.colors.last, AppColors.violet],
        child: SafeArea(
          child: Column(
            children: [
              const AppTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(rs.pad, 0, rs.pad, 20),
                  child: MaxWidth(
                    maxWidth: 1000,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Entrance(
                          child: RoutineCard(routine: routine, height: rs.isCompact ? 200 : 240),
                        ),
                        const SizedBox(height: 24),
                        Text(l.routineIncludes, style: t.headlineSmall),
                        const SizedBox(height: 14),
                        ResponsiveGrid(
                          minItemWidth: 420,
                          maxColumns: 2,
                          spacing: 12,
                          children: [
                            for (var i = 0; i < exercises.length; i++)
                              Entrance(
                                index: i + 1,
                                child: GlassCard(
                                  padding: const EdgeInsets.all(10),
                                  radius: 22,
                                  onTap: () => Navigator.of(
                                    context,
                                  ).push(AppRoutes.fade(ExerciseDetailScreen(exercise: exercises[i]))),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 84,
                                        height: 84,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: exercises[i].category.color.withValues(alpha: 0.12),
                                        ),
                                        child: Hero(
                                          tag: 'ex-${exercises[i].id}',
                                          child: ExerciseThumbnail(
                                            visual: exercises[i].visual,
                                            color: exercises[i].category.color,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${i + 1}. ${exercises[i].name(l)}',
                                              style: t.titleMedium,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${exercises[i].dose.label(l)} · ${l.secondsShort(exercises[i].durationSec)}',
                                              style: t.bodySmall!.copyWith(color: exercises[i].category.color),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const DwIcon(DwIcons.chevronRight, color: AppColors.textMuted),
                                      const SizedBox(width: 6),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(rs.pad, 6, rs.pad, 14),
                child: MaxWidth(
                  maxWidth: 560,
                  child: GradientButton(
                    label: l.routineStart,
                    icon: DwIcons.play,
                    gradient: routine.gradient,
                    onTap: () => Navigator.of(
                      context,
                    ).push(AppRoutes.slideUp(WorkoutPlayerScreen(exercises: exercises, title: routine.name(l)))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
