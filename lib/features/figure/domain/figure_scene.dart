import 'dart:ui';

import 'pose.dart';
import 'skeleton.dart';

/// Camera + furniture setup of an exercise animation.
class FigureScene {
  const FigureScene({
    required this.view,
    required this.viewport,
    this.chair = false,
    this.chairX = 0,
    this.desk = false,
    this.deskX = 0.24,
    this.deskTopY = 0.22,
  });

  final FigureView view;

  /// Region of scene space that is fitted into the widget.
  final Rect viewport;

  final bool chair;
  final double chairX;
  final bool desk;
  final double deskX;
  final double deskTopY;

  static final _seatedHipX = Pose.seatedSide[P.hipX];

  static final seatedSide = FigureScene(
    view: FigureView.side,
    viewport: const Rect.fromLTRB(-0.78, -0.62, 0.86, 1.0),
    chair: true,
    chairX: _seatedHipX,
  );

  static final seatedSideDesk = FigureScene(
    view: FigureView.side,
    viewport: const Rect.fromLTRB(-0.72, -0.62, 1.02, 1.0),
    chair: true,
    chairX: _seatedHipX,
    desk: true,
    deskX: 0.30,
  );

  static const seatedFront = FigureScene(
    view: FigureView.front,
    viewport: Rect.fromLTRB(-0.82, -0.72, 0.82, 1.0),
    chair: true,
  );

  static const standingSide = FigureScene(view: FigureView.side, viewport: Rect.fromLTRB(-0.9, -1.12, 0.9, 1.0));

  static const standingFront = FigureScene(view: FigureView.front, viewport: Rect.fromLTRB(-0.9, -1.12, 0.9, 1.0));

  /// Standing next to the chair (e.g. sit-to-stand).
  static final standingSideChair = FigureScene(
    view: FigureView.side,
    viewport: const Rect.fromLTRB(-0.9, -1.0, 0.9, 1.0),
    chair: true,
    chairX: _seatedHipX,
  );

  /// Standing in front of the desk, hands on its edge (incline push-ups,
  /// calf raises with support).
  static const standingSideDesk = FigureScene(
    view: FigureView.side,
    viewport: Rect.fromLTRB(-1.0, -1.0, 1.05, 1.0),
    desk: true,
    deskX: 0.42,
    deskTopY: 0.22,
  );
}
