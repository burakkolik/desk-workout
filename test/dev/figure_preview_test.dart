// Dev tool: renders every keyframe of every figure clip to PNG for visual QA.
// Run with: RENDER_PREVIEWS=1 flutter test test/dev/figure_preview_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:deskworkout/features/exercises/data/clips/back_clips.dart';
import 'package:deskworkout/features/exercises/data/clips/leg_clips.dart';
import 'package:deskworkout/features/exercises/data/clips/neck_clips.dart';
import 'package:deskworkout/features/exercises/data/clips/shoulder_clips.dart';
import 'package:deskworkout/features/exercises/data/clips/wrist_clips.dart';
import 'package:deskworkout/features/figure/domain/exercise_visual.dart';
import 'package:deskworkout/features/figure/rendering/figure_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> renderClip(String name, FigureVisual v) async {
  const cell = Size(300, 280);
  final n = v.clip.frames.length;
  final size = Size(cell.width * n, cell.height);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFF111729));
  for (var i = 0; i < n; i++) {
    canvas.save();
    canvas.translate(cell.width * i, 0);
    canvas.clipRect(Offset.zero & cell);
    FigurePainter(pose: v.clip.frames[i].value, scene: v.scene, focus: v.focus).paint(canvas, cell);
    canvas.drawLine(Offset(cell.width, 0), Offset(cell.width, cell.height), Paint()..color = Colors.white24);
    canvas.restore();
  }
  final img = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
  final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
  final dir = Directory('build/previews')..createSync(recursive: true);
  File('${dir.path}/$name.png').writeAsBytesSync(bytes!.buffer.asUint8List());
}

void main() {
  final enabled = Platform.environment['RENDER_PREVIEWS'] == '1';
  final clips = <String, FigureVisual>{
    'neck_chinTuck': NeckClips.chinTuck,
    'neck_sideTilt': NeckClips.sideTilt,
    'neck_rotation': NeckClips.rotation,
    'neck_levator': NeckClips.levatorScapulae,
    'neck_upperTrap': NeckClips.upperTrap,
    'sh_shrugs': ShoulderClips.shrugs,
    'sh_rolls': ShoulderClips.rolls,
    'sh_squeeze': ShoulderClips.scapularSqueeze,
    'sh_crossBody': ShoulderClips.crossBody,
    'sh_triceps': ShoulderClips.overheadTriceps,
    'sh_chest': ShoulderClips.chestOpener,
    'sh_thoracic': ShoulderClips.thoracicExtension,
    'sh_sideBend': ShoulderClips.sideBend,
    'wr_flexor': WristClips.flexorStretch,
    'wr_extensor': WristClips.extensorStretch,
    'wr_circles': WristClips.circles,
    'wr_prayer': WristClips.prayer,
    'bk_twist': BackClips.spinalTwist,
    'bk_catCow': BackClips.catCow,
    'bk_fold': BackClips.forwardFold,
    'lg_fig4': LegClips.figureFour,
    'lg_ext': LegClips.legExtension,
    'lg_ham': LegClips.hamstring,
    'lg_ankle': LegClips.anklePumps,
    'lg_march': LegClips.marching,
    'lg_calf': LegClips.calfRaises,
    'lg_hipFlex': LegClips.hipFlexor,
    'lg_squat': LegClips.chairSquat,
    'lg_pushup': LegClips.deskPushUp,
  };
  test('render clips', () async {
    final only = Platform.environment['ONLY'];
    for (final e in clips.entries) {
      if (only != null && !e.key.startsWith(only)) continue;
      await renderClip(e.key, e.value);
    }
  }, skip: !enabled);
}
