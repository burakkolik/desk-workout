import 'package:flutter/material.dart';

import '../../../../app/app_scope.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/icon_badge.dart';

/// Evidence-based tip that changes every day.
class TipCard extends StatelessWidget {
  const TipCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final tips = [l.tip1, l.tip2, l.tip3, l.tip4, l.tip5, l.tip6, l.tip7, l.tip8];
    final now = context.progress.now;
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    return GlassCard(
      borderColor: AppColors.amber,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.amber.withValues(alpha: 0.14), AppColors.surface.withValues(alpha: 0.9)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconBadge(icon: DwIcons.bulb, color: AppColors.amber, size: 50),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.tipOfDay, style: t.titleMedium!.copyWith(color: AppColors.amber)),
                const SizedBox(height: 6),
                Text(tips[dayOfYear % tips.length], style: t.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
