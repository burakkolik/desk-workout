import 'package:flutter/material.dart';

import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/entrance.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/icon_badge.dart';
import '../../../core/widgets/responsive_grid.dart';
import '../../../core/widgets/section_header.dart';
import '../../exercises/data/exercise_catalog.dart';
import '../../exercises/domain/exercise_category.dart';
import '../../exercises/presentation/widgets/exercise_card.dart';
import 'widgets/ergonomics_illustration.dart';
import 'widgets/twenty_timer_card.dart';

/// Eye health + posture/ergonomics hub.
class EyeCareScreen extends StatelessWidget {
  const EyeCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rs = context.rs;
    final checklist = <(DwIcons, Color, String)>[
      (DwIcons.monitor, AppColors.amber, l.ergoMonitorDistance),
      (DwIcons.eye, AppColors.sky, l.ergoMonitorHeight),
      (DwIcons.shoulder, AppColors.teal, l.ergoElbows),
      (DwIcons.wrist, AppColors.violet, l.ergoWrists),
      (DwIcons.spine, AppColors.coral, l.ergoBack),
      (DwIcons.legs, AppColors.lime, l.ergoFeet),
    ];
    final checklistWidget = Column(
      children: [
        for (var i = 0; i < checklist.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: checklist[i].$2),
                  child: Text('${i + 1}', style: t.titleSmall!.copyWith(color: AppColors.bg)),
                ),
                const SizedBox(width: 12),
                DwIcon(checklist[i].$1, color: checklist[i].$2, size: 22),
                const SizedBox(width: 10),
                Expanded(child: Text(checklist[i].$3, style: t.bodyMedium)),
              ],
            ),
          ),
      ],
    );
    final illustration = AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: RadialGradient(colors: [AppColors.blue.withValues(alpha: 0.18), Colors.transparent]),
        ),
        child: const ErgonomicsIllustration(),
      ),
    );

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
                    Entrance(child: Text(l.eyeTitle, style: t.displaySmall)),
                    const SizedBox(height: 6),
                    Entrance(
                      index: 1,
                      child: Text(l.eyeSubtitle, style: t.bodyLarge!.copyWith(color: AppColors.textSecondary)),
                    ),
                    const SizedBox(height: 22),
                    const Entrance(index: 2, child: TwentyTimerCard()),
                    const SizedBox(height: 16),
                    Entrance(
                      index: 3,
                      child: GlassCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const IconBadge(icon: DwIcons.sparkle, color: AppColors.sky, size: 48),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l.blinkFactTitle, style: t.titleMedium!.copyWith(color: AppColors.sky)),
                                  const SizedBox(height: 4),
                                  Text(l.blinkFactBody, style: t.bodyMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    SectionHeader(title: l.eyeExercises),
                    ResponsiveGrid(
                      minItemWidth: rs.isCompact ? 150 : 210,
                      maxColumns: 5,
                      spacing: 14,
                      children: [
                        for (final e in ExerciseCatalog.byCategory(ExerciseCategory.eyes)) ExerciseCard(exercise: e),
                      ],
                    ),
                    const SizedBox(height: 26),
                    SectionHeader(title: l.ergoTitle, subtitle: l.ergoSubtitle),
                    GlassCard(
                      child: rs.width >= 760
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: illustration),
                                const SizedBox(width: 20),
                                Expanded(child: checklistWidget),
                              ],
                            )
                          : Column(children: [illustration, const SizedBox(height: 16), checklistWidget]),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DwIcon(DwIcons.info, size: 20, color: AppColors.textMuted),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(l.eyeDisclaimer, style: t.bodySmall!.copyWith(color: AppColors.textMuted)),
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
