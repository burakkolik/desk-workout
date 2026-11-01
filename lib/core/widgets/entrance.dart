import 'package:flutter/material.dart';

/// Fades + slides its child in once, after an optional [delay].
/// Use [index] for easy staggering in lists.
class Entrance extends StatefulWidget {
  const Entrance({super.key, required this.child, this.index = 0, this.delay = Duration.zero, this.offset = 28});

  final Widget child;
  final int index;
  final Duration delay;
  final double offset;

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 650));

  @override
  void initState() {
    super.initState();
    final d = widget.delay + Duration(milliseconds: 70 * widget.index.clamp(0, 10));
    Future.delayed(d, () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curve = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
    return AnimatedBuilder(
      animation: curve,
      builder: (context, child) => Opacity(
        opacity: curve.value,
        child: Transform.translate(offset: Offset(0, (1 - curve.value) * widget.offset), child: child),
      ),
      child: widget.child,
    );
  }
}
