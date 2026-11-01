import 'package:flutter/material.dart';

import '../../../../app/app_scope.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/progress_ring.dart';

/// Goal ring + streak.
class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final progress = context.progress;
    final goal = context.settings.dailyGoalMin;
    final minutes = (progress.today.seconds / 60).floor();
    final ratio = goal == 0 ? 0.0 : progress.today.seconds / (goal * 60);
    final streak = progress.currentStreak;
    return GlassCard(
      glow: AppColors.teal,
      child: Row(
        children: [
          ProgressRing(
            progress: ratio,
            size: 118,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: FittedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${(ratio * 100).clamp(0, 999).round()}%', style: t.headlineMedium),
                    Text(l.todayGoal, style: t.labelSmall!.copyWith(color: AppColors.textMuted)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ratio >= 1 ? l.goalReached : l.minutesOfGoal(minutes, goal), style: t.titleLarge, maxLines: 2),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [AppColors.coral.withValues(alpha: 0.25), AppColors.amber.withValues(alpha: 0.12)],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const DwIcon(DwIcons.flame, color: AppColors.coral, size: 24),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(l.streakDays(streak), style: t.titleSmall!.copyWith(color: AppColors.amber)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
