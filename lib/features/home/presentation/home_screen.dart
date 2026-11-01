import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/app_scope.dart';
import '../../../app/routes.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/entrance.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/responsive_grid.dart';
import '../../../core/widgets/section_header.dart';
import '../../exercises/data/routine_catalog.dart';
import '../../exercises/presentation/widgets/routine_card.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../shell/presentation/main_shell.dart';
import 'widgets/body_area_strip.dart';
import 'widgets/daily_summary_card.dart';
import 'widgets/quick_break_card.dart';
import 'widgets/sitting_timer_card.dart';
import 'widgets/tip_card.dart';
import 'widgets/water_mini_card.dart';

/// "Today" dashboard.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting(AppLocalizations l, DateTime now) {
    if (now.hour < 12) return l.greetingMorning;
    if (now.hour < 18) return l.greetingAfternoon;
    return l.greetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rs = context.rs;
    final progress = context.progress;
    final now = progress.now;
    final date = DateFormat.MMMMEEEEd(Localizations.localeOf(context).toLanguageTag()).format(now);
    final wide = rs.width >= 900;

    final header = Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date.toUpperCase(), style: t.labelSmall!.copyWith(color: AppColors.teal, letterSpacing: 1.6)),
              const SizedBox(height: 6),
              Text(_greeting(l, now), style: t.displaySmall),
              const SizedBox(height: 4),
              Text(l.homeSubtitle, style: t.bodyLarge!.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
        CircleIconButton(
          icon: DwIcons.gear,
          onTap: () => Navigator.of(context).push(AppRoutes.fade(const SettingsScreen())),
        ),
      ],
    );

    final summary = const DailySummaryCard();
    final quick = const QuickBreakCard();
    final sitting = const SittingTimerCard();
    final water = const WaterMiniCard();

    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          bottom: false,
          sliver: SliverToBoxAdapter(
            child: MaxWidth(
              child: Padding(
                padding: EdgeInsets.fromLTRB(rs.pad, 18, rs.pad, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Entrance(child: header),
                    const SizedBox(height: 22),
                    if (wide)
                      Entrance(
                        index: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 5, child: summary),
                            const SizedBox(width: 16),
                            Expanded(flex: 6, child: quick),
                          ],
                        ),
                      )
                    else ...[
                      Entrance(index: 1, child: summary),
                      const SizedBox(height: 16),
                      Entrance(index: 2, child: quick),
                    ],
                    const SizedBox(height: 16),
                    Entrance(
                      index: 3,
                      child: ResponsiveGrid(minItemWidth: 320, maxColumns: 2, children: [sitting, water]),
                    ),
                    const SizedBox(height: 26),
                    SectionHeader(title: l.bodyAreasTitle),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: MaxWidth(child: BodyAreaStrip())),
        SliverToBoxAdapter(
          child: MaxWidth(
            child: Padding(
              padding: EdgeInsets.fromLTRB(rs.pad, 26, rs.pad, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: l.programs,
                    subtitle: l.programsSubtitle,
                    action: l.seeAll,
                    onAction: () => MainShell.of(context).goTo(AppTab.exercises),
                  ),
                  ResponsiveGrid(
                    minItemWidth: 280,
                    maxColumns: 4,
                    children: [
                      for (var i = 0; i < RoutineCatalog.all.length; i++)
                        Entrance(
                          index: 4 + i,
                          child: RoutineCard(routine: RoutineCatalog.all[i]),
                        ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  const TipCard(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
