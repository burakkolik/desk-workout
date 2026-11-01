import 'package:flutter/material.dart';

import '../icons/dw_icons.dart';
import 'pressable.dart';

/// Small rounded label (dose, duration, body area…), optionally selectable.
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.selected = false,
    this.onTap,
    this.large = false,
  });

  final String label;
  final Color color;
  final DwIcons? icon;
  final bool selected;
  final VoidCallback? onTap;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final chip = AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.symmetric(horizontal: large ? 18 : 12, vertical: large ? 11 : 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: selected ? color : color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: selected ? 0 : 0.35)),
        boxShadow: selected ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 18, spreadRadius: -4)] : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            DwIcon(icon!, size: large ? 20 : 16, color: selected ? const Color(0xFF0B1020) : color),
            SizedBox(width: large ? 8 : 6),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (large ? t.labelLarge : t.labelMedium)!.copyWith(
                color: selected ? const Color(0xFF0B1020) : color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return chip;
    return Pressable(onTap: onTap, child: chip);
  }
}
