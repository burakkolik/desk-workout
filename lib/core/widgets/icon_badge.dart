import 'package:flutter/material.dart';

import '../icons/dw_icons.dart';

/// Rounded square badge with a gradient tint and a [DwIcon].
class IconBadge extends StatelessWidget {
  const IconBadge({super.key, required this.icon, required this.color, this.size = 48, this.solid = false});

  final DwIcons icon;
  final Color color;
  final double size;
  final bool solid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: solid
              ? [color, Color.lerp(color, Colors.black, 0.25)!]
              : [color.withValues(alpha: 0.30), color.withValues(alpha: 0.08)],
        ),
        border: Border.all(color: color.withValues(alpha: solid ? 0 : 0.35)),
      ),
      alignment: Alignment.center,
      child: DwIcon(icon, size: size * 0.52, color: solid ? const Color(0xFF0B1020) : color, strokeWidth: 2),
    );
  }
}
