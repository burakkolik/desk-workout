import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Liquid page indicator: the active dot stretches into a gradient pill.
class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.count, required this.page});

  final int count;
  final double page;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          Builder(
            builder: (context) {
              final d = (1 - (page - i).abs()).clamp(0.0, 1.0);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 9 + 22 * d,
                height: 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(AppColors.stroke, AppColors.teal, d)!,
                      Color.lerp(AppColors.stroke, AppColors.blue, d)!,
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
