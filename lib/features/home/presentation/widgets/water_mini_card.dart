import 'package:flutter/material.dart';

import '../../../../app/app_scope.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/water_glass.dart';

/// Compact water tracker with a live glass.
class WaterMiniCard extends StatelessWidget {
  const WaterMiniCard({super.key, this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final progress = context.progress;
    final goal = context.settings.waterGoal;
    final count = progress.today.water;
    final glass = large ? 150.0 : 92.0;
    return GlassCard(
      glow: AppColors.sky,
      child: Row(
        children: [
          SizedBox(
            width: glass * 0.8,
            height: glass,
            child: WaterGlass(fill: count / goal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.waterToday, style: t.labelLarge!.copyWith(color: AppColors.sky)),
                const SizedBox(height: 4),
                Text(l.glassesOfGoal(count, goal), style: large ? t.headlineMedium : t.headlineSmall),
                Text(l.glassSize, style: t.bodySmall!.copyWith(color: AppColors.textMuted)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleIconButton(
                      icon: DwIcons.minus,
                      size: 46,
                      onTap: count == 0 ? null : () => AppScope.read(context).progress.addWater(-1),
                    ),
                    const SizedBox(width: 12),
                    CircleIconButton(
                      icon: DwIcons.plus,
                      size: 46,
                      color: AppColors.bg,
                      gradient: const LinearGradient(colors: [AppColors.sky, AppColors.blue]),
                      onTap: () => AppScope.read(context).progress.addWater(1),
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
