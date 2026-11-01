import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_colors.dart';

/// One story page: big live visual + title + body. Adapts to landscape by
/// placing the visual beside the text. [offset] drives parallax.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.visual,
    required this.title,
    required this.body,
    required this.accent,
    required this.offset,
  });

  final Widget visual;
  final String title;
  final String body;
  final Color accent;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final t = Theme.of(context).textTheme;
    final fade = (1 - offset.abs()).clamp(0.0, 1.0);
    final text = Transform.translate(
      offset: Offset(offset * -120, 0),
      child: Opacity(
        opacity: fade,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(colors: [accent, AppColors.blue]),
              ),
            ),
            const SizedBox(height: 18),
            Text(title, style: (rs.isCompact && !rs.isLandscape ? t.displaySmall : t.displayMedium)),
            const SizedBox(height: 14),
            Text(body, style: t.bodyLarge!.copyWith(color: AppColors.textSecondary, fontSize: 18)),
          ],
        ),
      ),
    );
    final vis = Transform.translate(
      offset: Offset(offset * 60, 0),
      child: Transform.scale(
        scale: 0.85 + 0.15 * fade,
        child: Opacity(opacity: fade, child: visual),
      ),
    );

    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth > c.maxHeight * 1.1;
        if (wide) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: rs.pad * 1.5),
            child: Row(
              children: [
                Expanded(flex: 5, child: vis),
                SizedBox(width: rs.pad),
                Expanded(flex: 5, child: SingleChildScrollView(child: text)),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: rs.pad),
          child: MaxWidth(
            maxWidth: 640,
            child: Column(
              children: [
                Expanded(child: vis),
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerLeft, child: text),
                const SizedBox(height: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}
