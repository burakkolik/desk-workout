import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Lays children out in equal-width columns; the column count adapts to
/// the available width (min [minItemWidth] per item).
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 300,
    this.spacing = 16,
    this.maxColumns = 4,
  });

  final List<Widget> children;
  final double minItemWidth;
  final double spacing;
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = math.max(1, math.min(maxColumns, ((c.maxWidth + spacing) / (minItemWidth + spacing)).floor()));
        final w = (c.maxWidth - spacing * (cols - 1)) / cols;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [for (final child in children) SizedBox(width: w, child: child)],
        );
      },
    );
  }
}
