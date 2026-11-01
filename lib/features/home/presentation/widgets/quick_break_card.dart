import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../exercises/data/clips/shoulder_clips.dart';
import '../../../exercises/data/routine_catalog.dart';
import '../../../figure/widgets/exercise_animation.dart';
import '../../../workout_player/presentation/workout_player_screen.dart';

/// Hero card: live animation + one-tap 2-minute reset.
class QuickBreakCard extends StatelessWidget {
  const QuickBreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final r = RoutineCatalog.quickReset;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF123C4A), Color(0xFF1A2F6B), Color(0xFF2A1F5E)],
        ),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.35)),
        boxShadow: [BoxShadow(color: AppColors.blue.withValues(alpha: 0.3), blurRadius: 40, spreadRadius: -12)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: LayoutBuilder(
          builder: (context, c) {
            final compact = c.maxWidth < 520;
            final animSize = compact ? 120.0 : (c.maxWidth * 0.4).clamp(150.0, 240.0);
            final anim = SizedBox(
              width: animSize,
              height: animSize * 1.05,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: ExerciseAnimation(visual: ShoulderClips.sideBend),
              ),
            );
            final button = GradientButton(
              label: l.startNow,
              icon: DwIcons.play,
              expand: compact,
              height: 54,
              onTap: () => Navigator.of(context).push(
                AppRoutes.slideUp(WorkoutPlayerScreen(exercises: RoutineCatalog.exercisesOf(r), title: r.name(l))),
              ),
            );
            final texts = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const DwIcon(DwIcons.bolt, color: AppColors.amber, size: 20),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        l.quickBreak.toUpperCase(),
                        style: t.labelSmall!.copyWith(color: AppColors.amber, letterSpacing: 1.4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(r.name(l), style: t.headlineSmall),
                const SizedBox(height: 6),
                Text(l.quickBreakDesc, style: t.bodyMedium!.copyWith(color: AppColors.textSecondary)),
              ],
            );
            if (compact) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: texts),
                        anim,
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(padding: const EdgeInsets.only(right: 8), child: button),
                  ],
                ),
              );
            }
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 22, 8, 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [texts, const SizedBox(height: 18), button],
                    ),
                  ),
                ),
                anim,
              ],
            );
          },
        ),
      ),
    );
  }
}
