import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/pressable.dart';
import '../../data/routine_catalog.dart';
import '../../domain/routine.dart';
import '../routine_detail_screen.dart';

/// Colourful program card with decorative background icon.
class RoutineCard extends StatelessWidget {
  const RoutineCard({super.key, required this.routine, this.height = 190});

  final Routine routine;
  final double height;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final minutes = (RoutineCatalog.durationOf(routine) / 60).ceil();
    const ink = Color(0xFF0B1020);
    return Pressable(
      onTap: () => Navigator.of(context).push(AppRoutes.fade(RoutineDetailScreen(routine: routine))),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: routine.gradient,
          boxShadow: [
            BoxShadow(
              color: routine.gradient.colors.first.withValues(alpha: 0.35),
              blurRadius: 26,
              offset: const Offset(0, 12),
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              Positioned(
                right: -24,
                bottom: -24,
                child: Opacity(
                  opacity: 0.18,
                  child: DwIcon(routine.icon, size: height * 0.85, color: ink, strokeWidth: 1.4),
                ),
              ),
              Positioned(
                right: -40,
                top: -40,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: ink.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const DwIcon(DwIcons.clock, size: 15, color: ink),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              '${l.minutesShort(minutes)} · ${l.exercisesCount(routine.exerciseIds.length)}',
                              style: t.labelMedium!.copyWith(color: ink),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      routine.name(l),
                      style: t.headlineSmall!.copyWith(color: ink, fontWeight: FontWeight.w800),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      routine.description(l),
                      style: t.bodyMedium!.copyWith(color: ink.withValues(alpha: 0.75), height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
