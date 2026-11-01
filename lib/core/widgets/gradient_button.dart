import 'package:flutter/material.dart';

import '../icons/dw_icons.dart';
import '../theme/app_colors.dart';
import 'pressable.dart';

/// Primary call-to-action: gradient pill with a moving light sweep.
class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.gradient = AppGradients.primary,
    this.expand = true,
    this.height = 60,
    this.foreground = AppColors.bg,
  });

  final String label;
  final VoidCallback? onTap;
  final DwIcons? icon;
  final Gradient gradient;
  final bool expand;
  final double height;
  final Color foreground;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> with SingleTickerProviderStateMixin {
  late final AnimationController _shine = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))
    ..repeat();

  @override
  void dispose() {
    _shine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.labelLarge!.copyWith(color: widget.foreground, fontSize: 17, fontWeight: FontWeight.w800);
    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          DwIcon(widget.icon!, size: 22, color: widget.foreground, strokeWidth: 2.2),
          const SizedBox(width: 10),
        ],
        Flexible(
          child: Text(widget.label, style: style, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
    return Opacity(
      opacity: widget.onTap == null ? 0.45 : 1,
      child: Pressable(
        onTap: widget.onTap,
        child: Container(
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 26),
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.height / 2),
            boxShadow: [
              BoxShadow(
                color: widget.gradient.colors.first.withValues(alpha: 0.45),
                blurRadius: 26,
                offset: const Offset(0, 10),
                spreadRadius: -8,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.height / 2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _shine,
                    builder: (context, _) {
                      final x = -1.5 + _shine.value * 4;
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(x - 0.6, -1),
                            end: Alignment(x + 0.6, 1),
                            colors: const [Color(0x00FFFFFF), Color(0x55FFFFFF), Color(0x00FFFFFF)],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Round icon-only button with a glass look.
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 52,
    this.color = AppColors.textPrimary,
    this.filled = false,
    this.gradient,
  });

  final DwIcons icon;
  final VoidCallback? onTap;
  final double size;
  final Color color;
  final bool filled;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      scale: 0.9,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gradient,
          color: gradient == null ? (filled ? AppColors.surfaceHigh : AppColors.surface.withValues(alpha: 0.7)) : null,
          border: Border.all(color: Colors.white.withValues(alpha: gradient == null ? 0.1 : 0)),
          boxShadow: gradient == null
              ? null
              : [BoxShadow(color: gradient!.colors.first.withValues(alpha: 0.5), blurRadius: 24, spreadRadius: -6)],
        ),
        alignment: Alignment.center,
        child: DwIcon(icon, size: size * 0.44, color: color, strokeWidth: 2.2),
      ),
    );
  }
}
