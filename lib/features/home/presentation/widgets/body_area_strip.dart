import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/icon_badge.dart';
import '../../../exercises/domain/exercise_category.dart';
import '../../../exercises/presentation/library_screen.dart';

/// Horizontally scrolling category tiles.
class BodyAreaStrip extends StatelessWidget {
  const BodyAreaStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rs = context.rs;
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: rs.pad),
        itemCount: ExerciseCategory.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final c = ExerciseCategory.values[i];
          return SizedBox(
            width: 138,
            child: GlassCard(
              padding: const EdgeInsets.all(14),
              radius: 24,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [c.color.withValues(alpha: 0.2), AppColors.surface.withValues(alpha: 0.9)],
              ),
              borderColor: c.color,
              onTap: () =>
                  Navigator.of(context).push(AppRoutes.fade(LibraryScreen(initialCategory: c, standalone: true))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconBadge(icon: c.icon, color: c.color, size: 46, solid: true),
                  const Spacer(),
                  Text(c.label(l), style: t.titleSmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
