import 'package:flutter/material.dart';

import '../../../../core/icons/dw_icons.dart';
import '../../../../core/theme/app_colors.dart';

/// Four cups = the 400 mg/day reference, filling one after another.
class CaffeineMeter extends StatefulWidget {
  const CaffeineMeter({super.key});

  @override
  State<CaffeineMeter> createState() => _CaffeineMeterState();
}

class _CaffeineMeterState extends State<CaffeineMeter> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final v = (_c.value * 1.25).clamp(0.0, 1.0) * 4;
        return Row(
          children: [
            for (var i = 0; i < 4; i++)
              Expanded(
                child: Column(
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: v > i ? 1 : 0.3,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutBack,
                        scale: v > i ? 1 : 0.85,
                        child: DwIcon(DwIcons.coffee, size: 40, color: i == 3 ? AppColors.coral : AppColors.amber),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${(i + 1) * 100} mg', style: t.labelSmall!.copyWith(color: AppColors.textMuted)),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
