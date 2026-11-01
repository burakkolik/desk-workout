import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../app/routes.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/entrance.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/responsive_grid.dart';
import '../../../core/widgets/section_header.dart';
import '../../settings/presentation/settings_screen.dart';
import 'widgets/weekly_chart.dart';

/// Streaks, totals, weekly chart and achievements.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rs = context.rs;
    final p = context.progress;
    final week = p.week;
    final weekMinutes = (week.fold(0, (s, d) => s + d.$2.seconds) / 60).round();
    final totalMinutes = (p.totalSeconds / 60).round();

    final stats = [
      (DwIcons.flame, AppColors.coral, l.statStreak, l.daysCount(p.currentStreak)),
      (DwIcons.trophy, AppColors.amber, l.statBest, l.daysCount(p.bestStreak)),
      (DwIcons.clock, AppColors.teal, l.statMinutes, '$totalMinutes'),
      (DwIcons.check, AppColors.blue, l.statSessions, '${p.totalSessions}'),
    ];
    final badges = [
      (DwIcons.sparkle, AppColors.teal, l.badgeFirst, l.badgeFirstDesc, p.totalSessions >= 1),
      (DwIcons.flame, AppColors.coral, l.badgeStreak3, l.badgeStreak3Desc, p.bestStreak >= 3),
      (DwIcons.bolt, AppColors.amber, l.badgeStreak7, l.badgeStreak7Desc, p.bestStreak >= 7),
      (DwIcons.trophy, AppColors.violet, l.badgeSessions10, l.badgeSessions10Desc, p.totalSessions >= 10),
      (DwIcons.clock, AppColors.blue, l.badgeMinutes60, l.badgeMinutes60Desc, totalMinutes >= 60),
      (DwIcons.drop, AppColors.sky, l.badgeWater, l.badgeWaterDesc, p.bestWaterDay >= 8),
    ];

    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          bottom: false,
          sliver: SliverToBoxAdapter(
            child: MaxWidth(
              child: Padding(
                padding: EdgeInsets.fromLTRB(rs.pad, 20, rs.pad, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Entrance(child: Text(l.progressTitle, style: t.displaySmall)),
                              const SizedBox(height: 6),
                              Entrance(
                                index: 1,
                                child: Text(
                                  l.progressSubtitle,
                                  style: t.bodyLarge!.copyWith(color: AppColors.textSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleIconButton(
                          icon: DwIcons.gear,
                          onTap: () => Navigator.of(context).push(AppRoutes.fade(const SettingsScreen())),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    ResponsiveGrid(
                      minItemWidth: 150,
                      maxColumns: 4,
                      spacing: 12,
                      children: [
                        for (var i = 0; i < stats.length; i++)
                          Entrance(
                            index: 2 + i,
                            child: GlassCard(
                              glow: stats[i].$2,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DwIcon(stats[i].$1, color: stats[i].$2, size: 28),
                                  const SizedBox(height: 12),
                                  FittedBox(child: Text(stats[i].$4, style: t.headlineMedium)),
                                  Text(
                                    stats[i].$3,
                                    style: t.bodySmall!.copyWith(color: AppColors.textSecondary),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Entrance(
                      index: 6,
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(l.thisWeek, style: t.headlineSmall)),
                                Text(l.weekMinutes(weekMinutes), style: t.titleSmall!.copyWith(color: AppColors.teal)),
                              ],
                            ),
                            const SizedBox(height: 18),
                            WeeklyChart(days: week, goalMinutes: context.settings.dailyGoalMin),
                            if (p.totalSessions == 0) ...[
                              const SizedBox(height: 12),
                              Text(l.emptyProgress, style: t.bodyMedium!.copyWith(color: AppColors.textMuted)),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    SectionHeader(title: l.achievements),
                    ResponsiveGrid(
                      minItemWidth: 160,
                      maxColumns: 6,
                      spacing: 12,
                      children: [
                        for (final b in badges)
                          GlassCard(
                            glow: b.$5 ? b.$2 : null,
                            borderColor: b.$5 ? b.$2 : null,
                            padding: const EdgeInsets.all(16),
                            child: Opacity(
                              opacity: b.$5 ? 1 : 0.45,
                              child: Column(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: b.$5
                                          ? AppGradients.of(b.$2)
                                          : const LinearGradient(colors: [AppColors.surfaceHigh, AppColors.surface]),
                                      boxShadow: b.$5
                                          ? [BoxShadow(color: b.$2.withValues(alpha: 0.5), blurRadius: 18)]
                                          : null,
                                    ),
                                    alignment: Alignment.center,
                                    child: DwIcon(b.$1, size: 32, color: b.$5 ? AppColors.bg : AppColors.textMuted),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(b.$3, style: t.titleSmall, textAlign: TextAlign.center, maxLines: 1),
                                  const SizedBox(height: 2),
                                  Text(
                                    b.$4,
                                    style: t.bodySmall!.copyWith(color: AppColors.textSecondary),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
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
        ),
      ],
    );
  }
}
