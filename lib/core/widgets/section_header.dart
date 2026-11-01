import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'pressable.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action, this.onAction, this.subtitle});

  final String title;
  final String? subtitle;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.headlineSmall),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: t.bodyMedium!.copyWith(color: AppColors.textSecondary)),
                ],
              ],
            ),
          ),
          if (action != null)
            Pressable(
              onTap: onAction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Text(action!, style: t.labelLarge!.copyWith(color: AppColors.teal)),
              ),
            ),
        ],
      ),
    );
  }
}
