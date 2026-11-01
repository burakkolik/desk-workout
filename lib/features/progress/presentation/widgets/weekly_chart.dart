import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/day_log.dart';

/// Animated 7-day bar chart of active minutes.
class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key, required this.days, required this.goalMinutes});

  final List<(DateTime, DayLog)> days;
  final int goalMinutes;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final mins = [for (final d in days) d.$2.seconds / 60];
    final maxV = [goalMinutes.toDouble(), ...mins].reduce((a, b) => a > b ? a : b).clamp(1.0, double.infinity);
    return SizedBox(
      height: 210,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutCubic,
        builder: (context, a, _) => Stack(
          children: [
            // Goal line.
            Positioned(
              left: 0,
              right: 0,
              bottom: 30 + (goalMinutes / maxV) * 160,
              child: Row(
                children: [
                  Expanded(child: Container(height: 1.5, color: AppColors.amber.withValues(alpha: 0.5))),
                  const SizedBox(width: 6),
                  Text('$goalMinutes′', style: t.labelSmall!.copyWith(color: AppColors.amber)),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < days.length; i++)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (mins[i] > 0)
                          Text(
                            mins[i].round().toString(),
                            style: t.labelSmall!.copyWith(color: AppColors.textSecondary),
                          ),
                        const SizedBox(height: 4),
                        Container(
                          width: 26,
                          height: 6 + (mins[i] / maxV) * 154 * a,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: mins[i] > 0
                                ? const LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [AppColors.blue, AppColors.teal],
                                  )
                                : null,
                            color: mins[i] > 0 ? null : Colors.white.withValues(alpha: 0.08),
                            boxShadow: i == days.length - 1 && mins[i] > 0
                                ? [BoxShadow(color: AppColors.teal.withValues(alpha: 0.5), blurRadius: 14)]
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.E(locale).format(days[i].$1),
                          style: t.labelSmall!.copyWith(
                            color: i == days.length - 1 ? AppColors.teal : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
