import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Window size classes (Material 3 guidance).
enum SizeClass { compact, medium, expanded }

/// Responsive helpers derived from the current window size. Use
/// `context.rs` anywhere in the widget tree.
class Responsive {
  Responsive(Size size)
    : width = size.width,
      height = size.height,
      sizeClass = size.width < 600
          ? SizeClass.compact
          : size.width < 1000
          ? SizeClass.medium
          : SizeClass.expanded;

  final double width;
  final double height;
  final SizeClass sizeClass;

  double get shortest => math.min(width, height);
  bool get isLandscape => width > height;
  bool get isCompact => sizeClass == SizeClass.compact;
  bool get isTablet => shortest >= 600;

  /// Navigation rail instead of a bottom bar.
  bool get useRail => width >= 840 || (isLandscape && height < 500);

  /// Two-pane layouts (e.g. animation beside instructions).
  bool get twoPane => width >= 760 || (isLandscape && width >= 560);

  /// General size multiplier for paddings / illustration sizes.
  double get scale => (shortest / 400).clamp(0.82, 1.45);

  /// Horizontal page padding.
  double get pad => isCompact ? 20 * scale.clamp(0.85, 1.0) : (width >= 1000 ? 40 : 28);

  /// Maximum content width so lines stay readable on huge screens.
  double get maxContent => 1240;

  /// Grid columns for items of at least [minItemWidth].
  int columns(double minItemWidth, {int min = 1, int max = 6}) {
    final usable = math.min(width, maxContent) - pad * 2;
    return (usable / minItemWidth).floor().clamp(min, max);
  }
}

extension ResponsiveContext on BuildContext {
  Responsive get rs => Responsive(MediaQuery.sizeOf(this));
}

/// Centers content and caps its width on large screens.
class MaxWidth extends StatelessWidget {
  const MaxWidth({super.key, required this.child, this.maxWidth});

  final Widget child;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? context.rs.maxContent),
        // Always take the full (capped) width so left-aligned content stays left.
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
