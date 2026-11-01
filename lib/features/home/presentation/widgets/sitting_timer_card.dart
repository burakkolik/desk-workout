import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/app_scope.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/icon_badge.dart';
import '../../../../core/widgets/tag_chip.dart';

/// Shows how long you have been sitting since the last break and nudges
/// you when the configured break interval is exceeded.
class SittingTimerCard extends StatefulWidget {
  const SittingTimerCard({super.key});

  @override
  State<SittingTimerCard> createState() => _SittingTimerCardState();
}

class _SittingTimerCardState extends State<SittingTimerCard> with SingleTickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
    ..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 20), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final progress = context.progress;
    final interval = Duration(minutes: context.settings.breakIntervalMin);
    var sitting = progress.now.difference(progress.lastBreak);
    if (sitting.isNegative) sitting = Duration.zero;
    final overdue = sitting >= interval;
    final color = overdue ? AppColors.coral : AppColors.lime;
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) => GlassCard(
        glow: overdue ? Color.lerp(AppColors.coral, AppColors.amber, _pulse.value) : null,
        borderColor: overdue ? AppColors.coral : null,
        child: child!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBadge(icon: DwIcons.chair, color: color, size: 46),
              const SizedBox(width: 14),
              Expanded(child: Text(l.sittingFor(humanDuration(l, sitting)), style: t.titleMedium)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (sitting.inSeconds / interval.inSeconds).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            overdue ? l.timeToMove : l.sittingOk(humanDuration(l, interval - sitting)),
            style: t.bodyMedium!.copyWith(color: overdue ? AppColors.coral : AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          TagChip(
            label: l.tookBreak,
            icon: DwIcons.check,
            color: color,
            onTap: () => AppScope.read(context).progress.markBreak(),
          ),
        ],
      ),
    );
  }
}
