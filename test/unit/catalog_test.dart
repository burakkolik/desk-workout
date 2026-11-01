import 'dart:ui' as ui;

import 'package:deskworkout/core/l10n/l10n.dart';
import 'package:deskworkout/features/exercises/data/exercise_catalog.dart';
import 'package:deskworkout/features/exercises/data/routine_catalog.dart';
import 'package:deskworkout/features/figure/domain/exercise_visual.dart';
import 'package:deskworkout/features/figure/rendering/breath_painter.dart';
import 'package:deskworkout/features/figure/rendering/eye_painter.dart';
import 'package:deskworkout/features/figure/rendering/figure_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exercise ids are unique and routines reference existing exercises', () {
    final ids = ExerciseCatalog.all.map((e) => e.id).toList();
    expect(ids.toSet().length, ids.length);
    for (final r in RoutineCatalog.all) {
      for (final id in r.exerciseIds) {
        expect(ids, contains(id), reason: 'routine ${r.id}');
      }
    }
  });

  test('every exercise has texts with at least 3 steps in every language', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final l = lookupAppLocalizations(locale);
      for (final e in ExerciseCatalog.all) {
        expect(e.name(l), isNotEmpty);
        expect(e.summary(l), isNotEmpty);
        expect(e.tip(l), isNotEmpty);
        expect(e.stepList(l).length, greaterThanOrEqualTo(3), reason: '${e.id} ${locale.languageCode}');
        expect(e.dose.label(l), isNotEmpty);
      }
    }
  });

  test('every animation renders at many points of its loop', () {
    const size = Size(300, 260);
    for (final e in ExerciseCatalog.all) {
      final v = e.visual;
      for (var i = 0; i <= 12; i++) {
        final time = v.loopSeconds * i / 12;
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        switch (v) {
          case FigureVisual():
            FigurePainter(
              pose: v.clip.sample(time).value,
              scene: v.scene,
              focus: v.focus,
              pulse: 0.3,
            ).paint(canvas, size);
          case EyeVisual():
            EyePainter(pose: v.clip.sample(time).value, showTarget: v.showTarget, time: time).paint(canvas, size);
          case BreathVisual():
            BreathPainter(
              pose: v.clip.sample(time).value,
              box: v.box,
              time: time,
              color: Colors.teal,
            ).paint(canvas, size);
        }
        recorder.endRecording();
      }
    }
  });
}
