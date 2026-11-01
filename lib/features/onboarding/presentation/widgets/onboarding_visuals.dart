import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/icons/dw_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/icon_badge.dart';
import '../../../../core/widgets/water_glass.dart';
import '../../../exercises/data/clips/eye_clips.dart';
import '../../../exercises/data/clips/neck_clips.dart';
import '../../../exercises/data/clips/shoulder_clips.dart';
import '../../../figure/widgets/exercise_animation.dart';

/// Glowing circular stage with icons orbiting around a live animation.
class VisualStage extends StatefulWidget {
  const VisualStage({super.key, required this.child, required this.color, this.orbit = const []});

  final Widget child;
  final Color color;
  final List<(DwIcons, Color)> orbit;

  @override
  State<VisualStage> createState() => _VisualStageState();
}

class _VisualStageState extends State<VisualStage> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 18))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final s = math.min(box.maxWidth, box.maxHeight);
        return Center(
          child: SizedBox.square(
            dimension: s,
            child: AnimatedBuilder(
              animation: _c,
              builder: (context, child) {
                final a = _c.value * math.pi * 2;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Halo + rings
                    Container(
                      width: s * 0.86,
                      height: s * 0.86,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            widget.color.withValues(alpha: 0.22),
                            widget.color.withValues(alpha: 0.04),
                            Colors.transparent,
                          ],
                          stops: const [0, 0.7, 1],
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: a,
                      child: CustomPaint(size: Size.square(s * 0.9), painter: _DashedRing(widget.color)),
                    ),
                    SizedBox.square(
                      dimension: s * 0.78,
                      child: ClipOval(child: child),
                    ),
                    for (var i = 0; i < widget.orbit.length; i++)
                      Builder(
                        builder: (context) {
                          final ang = a * 0.6 + i / widget.orbit.length * math.pi * 2;
                          final r = s * 0.44;
                          final bob = math.sin(a * 3 + i) * 6;
                          return Transform.translate(
                            offset: Offset(math.cos(ang) * r, math.sin(ang) * r + bob),
                            child: IconBadge(
                              icon: widget.orbit[i].$1,
                              color: widget.orbit[i].$2,
                              size: s * 0.13,
                              solid: true,
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
              child: Container(color: AppColors.bgElevated.withValues(alpha: 0.6), child: widget.child),
            ),
          ),
        );
      },
    );
  }
}

class _DashedRing extends CustomPainter {
  _DashedRing(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    final p = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 48; i++) {
      final a = i / 48 * math.pi * 2;
      if (i % 4 == 0) continue;
      final d = Offset(math.cos(a), math.sin(a));
      canvas.drawLine(c + d * (r - 3), c + d * r, p);
    }
  }

  @override
  bool shouldRepaint(_DashedRing old) => false;
}

class WelcomeVisual extends StatelessWidget {
  const WelcomeVisual({super.key});

  @override
  Widget build(BuildContext context) => VisualStage(
    color: AppColors.teal,
    orbit: const [
      (DwIcons.neck, AppColors.teal),
      (DwIcons.wrist, AppColors.amber),
      (DwIcons.spine, AppColors.coral),
      (DwIcons.eye, AppColors.violet),
    ],
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: ExerciseAnimation(visual: ShoulderClips.sideBend),
    ),
  );
}

class PostureVisual extends StatelessWidget {
  const PostureVisual({super.key});

  @override
  Widget build(BuildContext context) => VisualStage(
    color: AppColors.coral,
    orbit: const [(DwIcons.chair, AppColors.coral), (DwIcons.monitor, AppColors.blue), (DwIcons.check, AppColors.lime)],
    child: Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 0),
      child: ExerciseAnimation(visual: NeckClips.chinTuck),
    ),
  );
}

class EyesVisual extends StatelessWidget {
  const EyesVisual({super.key});

  @override
  Widget build(BuildContext context) => VisualStage(
    color: AppColors.violet,
    orbit: const [(DwIcons.clock, AppColors.violet), (DwIcons.eye, AppColors.sky), (DwIcons.monitor, AppColors.teal)],
    child: Padding(
      padding: const EdgeInsets.all(26),
      child: ExerciseAnimation(visual: EyeClips.twentyTwenty, accent: AppColors.violet),
    ),
  );
}

class NutritionVisual extends StatefulWidget {
  const NutritionVisual({super.key});

  @override
  State<NutritionVisual> createState() => _NutritionVisualState();
}

class _NutritionVisualState extends State<NutritionVisual> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => VisualStage(
    color: AppColors.sky,
    orbit: const [
      (DwIcons.apple, AppColors.lime),
      (DwIcons.coffee, AppColors.amber),
      (DwIcons.leaf, AppColors.teal),
      (DwIcons.drop, AppColors.sky),
    ],
    child: Padding(
      padding: const EdgeInsets.all(40),
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final v = _c.value;
          final fill = v < 0.75 ? Curves.easeInOut.transform(v / 0.75) : 1 - (v - 0.75) / 0.25;
          return WaterGlass(fill: 0.15 + fill * 0.8);
        },
      ),
    ),
  );
}
