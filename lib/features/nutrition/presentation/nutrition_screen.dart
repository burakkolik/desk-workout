import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/entrance.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/icon_badge.dart';
import '../../../core/widgets/responsive_grid.dart';
import '../../../core/widgets/section_header.dart';
import '../../home/presentation/widgets/water_mini_card.dart';
import 'widgets/caffeine_meter.dart';
import 'widgets/food_art.dart';

/// Nutrition for desk workers: hydration, caffeine, snacks and habits.
class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rs = context.rs;
    final settings = context.settings;

    final snacks = <(Food, String, String, Color)>[
      (Food.nuts, l.snackNuts, l.snackNutsDesc, AppColors.violet),
      (Food.fruit, l.snackFruit, l.snackFruitDesc, AppColors.coral),
      (Food.yogurt, l.snackYogurt, l.snackYogurtDesc, AppColors.sky),
      (Food.veggies, l.snackVeggies, l.snackVeggiesDesc, AppColors.amber),
      (Food.eggs, l.snackEggs, l.snackEggsDesc, AppColors.lime),
      (Food.chickpeas, l.snackChickpeas, l.snackChickpeasDesc, AppColors.pink),
    ];
    final habits = <(DwIcons, Color, String, String)>[
      (DwIcons.drop, AppColors.sky, l.habit1Title, l.habit1Body),
      (DwIcons.leaf, AppColors.lime, l.habit2Title, l.habit2Body),
      (DwIcons.target, AppColors.amber, l.habit3Title, l.habit3Body),
      (DwIcons.coffee, AppColors.coral, l.habit4Title, l.habit4Body),
      (DwIcons.bolt, AppColors.teal, l.habit5Title, l.habit5Body),
      (DwIcons.info, AppColors.violet, l.habit6Title, l.habit6Body),
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
                    Entrance(child: Text(l.nutritionTitle, style: t.displaySmall)),
                    const SizedBox(height: 6),
                    Entrance(
                      index: 1,
                      child: Text(l.nutritionSubtitle, style: t.bodyLarge!.copyWith(color: AppColors.textSecondary)),
                    ),
                    const SizedBox(height: 22),
                    Entrance(
                      index: 2,
                      child: ResponsiveGrid(
                        minItemWidth: 340,
                        maxColumns: 2,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const WaterMiniCard(large: true),
                              const SizedBox(height: 12),
                              GlassCard(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(l.waterBody, style: t.bodyMedium),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(child: Text(l.waterGoalLabel, style: t.titleSmall)),
                                        CircleIconButton(
                                          icon: DwIcons.minus,
                                          size: 40,
                                          onTap: () =>
                                              AppScope.read(context).settings.setWaterGoal(settings.waterGoal - 1),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(l.glassesCount(settings.waterGoal), style: t.titleMedium),
                                        ),
                                        CircleIconButton(
                                          icon: DwIcons.plus,
                                          size: 40,
                                          onTap: () =>
                                              AppScope.read(context).settings.setWaterGoal(settings.waterGoal + 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GlassCard(
                            glow: AppColors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const IconBadge(icon: DwIcons.coffee, color: AppColors.amber, size: 48),
                                    const SizedBox(width: 14),
                                    Expanded(child: Text(l.caffeineTitle, style: t.headlineSmall)),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                const CaffeineMeter(),
                                const SizedBox(height: 18),
                                Text(l.caffeineBody, style: t.bodyMedium),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const DwIcon(DwIcons.bulb, size: 20, color: AppColors.amber),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(l.caffeineTip, style: t.bodySmall!.copyWith(color: AppColors.amber)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    SectionHeader(title: l.snacksTitle, subtitle: l.snacksSubtitle),
                    ResponsiveGrid(
                      minItemWidth: rs.isCompact ? 150 : 200,
                      maxColumns: 6,
                      spacing: 14,
                      children: [
                        for (var i = 0; i < snacks.length; i++)
                          Entrance(
                            index: i,
                            child: GlassCard(
                              padding: const EdgeInsets.all(14),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  snacks[i].$4.withValues(alpha: 0.16),
                                  AppColors.surface.withValues(alpha: 0.9),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(aspectRatio: 1.3, child: FoodArt(snacks[i].$1)),
                                  const SizedBox(height: 8),
                                  Text(snacks[i].$2, style: t.titleSmall, maxLines: 2),
                                  const SizedBox(height: 4),
                                  Text(
                                    snacks[i].$3,
                                    style: t.bodySmall!.copyWith(color: AppColors.textSecondary),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    SectionHeader(title: l.habitsTitle),
                    ResponsiveGrid(
                      minItemWidth: 320,
                      maxColumns: 3,
                      spacing: 12,
                      children: [
                        for (final h in habits)
                          GlassCard(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconBadge(icon: h.$1, color: h.$2, size: 44),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(h.$3, style: t.titleMedium),
                                      const SizedBox(height: 4),
                                      Text(h.$4, style: t.bodyMedium!.copyWith(color: AppColors.textSecondary)),
                                    ],
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
            ),
          ),
        ),
      ],
    );
  }
}
