import 'package:flutter/material.dart';

import '../domain/exercise_visual.dart';
import '../rendering/breath_painter.dart';
import '../rendering/eye_painter.dart';
import '../rendering/figure_painter.dart';

/// Static key-pose preview of an exercise (cheap enough for long grids).
class ExerciseThumbnail extends StatelessWidget {
  const ExerciseThumbnail({super.key, required this.visual, required this.color});

  final ExerciseVisual visual;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final v = visual;
    final CustomPainter painter = switch (v) {
      FigureVisual() => FigurePainter(
        pose: v.clip.frames[v.clip.frames.length > 1 ? 1 : 0].value,
        scene: v.scene,
        focus: v.focus,
        pulse: 0.25,
      ),
      EyeVisual() => EyePainter(
        pose: v.clip.frames[v.clip.frames.length > 1 ? 1 : 0].value,
        showTarget: v.showTarget,
        time: 0.2,
      ),
      BreathVisual() => BreathPainter(pose: const BreathPose(0.7, corner: 1.4), box: v.box, time: 0.3, color: color),
    };
    return RepaintBoundary(
      child: CustomPaint(painter: painter, size: Size.infinite),
    );
  }
}
