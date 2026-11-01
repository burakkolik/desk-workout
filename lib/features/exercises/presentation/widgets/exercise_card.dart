import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../figure/widgets/exercise_thumbnail.dart';
import '../../domain/exercise.dart';
import '../exercise_detail_screen.dart';

/// Grid card: key-pose illustration, name, dose and duration.
class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final color = exercise.category.color;
    return GlassCard(
      padding: EdgeInsets.zero,
      onTap: () => Navigator.of(context).push(AppRoutes.fade(ExerciseDetailScreen(exercise: exercise))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.25,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  center: const Alignment(0, -0.2),
                  radius: 0.9,
                  colors: [color.withValues(alpha: 0.20), AppColors.bgElevated.withValues(alpha: 0.4)],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: ExerciseThumbnail(visual: exercise.visual, color: color),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.name(l), style: t.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  children: [
                    DwIcon(DwIcons.clock, size: 16, color: color),
                    const SizedBox(width: 5),
                    Text(
                      l.secondsShort(exercise.durationSec),
                      style: t.labelMedium!.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        exercise.dose.label(l),
                        style: t.labelMedium!.copyWith(color: color),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
