import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'pressable.dart';

/// Frosted card with a subtle gradient border.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    this.gradient,
    this.borderColor,
    this.radius = 26,
    this.glow,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final Color? borderColor;
  final double radius;

  /// Optional coloured glow behind the card.
  final Color? glow;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (borderColor ?? Colors.white).withValues(alpha: 0.22),
            (borderColor ?? Colors.white).withValues(alpha: 0.03),
          ],
        ),
        boxShadow: [
          if (glow != null) BoxShadow(color: glow!.withValues(alpha: 0.28), blurRadius: 32, spreadRadius: -6),
          const BoxShadow(color: Color(0x66000000), blurRadius: 24, offset: Offset(0, 12), spreadRadius: -10),
        ],
      ),
      padding: const EdgeInsets.all(1.2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius - 1.2),
          gradient: gradient ?? AppGradients.card,
        ),
        padding: padding,
        child: child,
      ),
    );
    if (onTap == null) return card;
    return Pressable(onTap: onTap, child: card);
  }
}
