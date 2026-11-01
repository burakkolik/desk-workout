// Generates the launcher icons, the Play Store icon (512x512) and the
// Play Store feature graphic (1024x500) with the app's own painters.
// Run with: GENERATE_ASSETS=1 flutter test test/dev/generate_assets_test.dart
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:deskworkout/core/icons/dw_icons.dart';
import 'package:deskworkout/core/theme/app_colors.dart';
import 'package:deskworkout/core/widgets/logo_mark.dart';
import 'package:deskworkout/features/exercises/data/clips/shoulder_clips.dart';
import 'package:deskworkout/features/figure/rendering/figure_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _save(String path, Size size, void Function(Canvas c) paint) async {
  final rec = ui.PictureRecorder();
  final canvas = Canvas(rec);
  paint(canvas);
  final img = await rec.endRecording().toImage(size.width.toInt(), size.height.toInt());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(data!.buffer.asUint8List());
}

Future<void> _loadFonts() async {
  final root =
      Platform.environment['FLUTTER_ROOT'] ??
      File(Platform.resolvedExecutable).parent.parent.parent.parent.parent.parent.path;
  final dir = '$root/bin/cache/artifacts/material_fonts';
  final loader = FontLoader('Roboto');
  for (final f in ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf', 'Roboto-Black.ttf']) {
    final file = File('$dir/$f');
    if (file.existsSync()) loader.addFont(Future.value(ByteData.sublistView(file.readAsBytesSync())));
  }
  await loader.load();
}

void _text(
  Canvas c,
  String s,
  Offset o,
  double size,
  FontWeight w,
  Color color, {
  double spacing = 0,
  double maxWidth = 900,
  Shader? shader,
}) {
  final style = TextStyle(
    fontFamily: 'Roboto',
    fontSize: size,
    fontWeight: w,
    letterSpacing: spacing,
    color: shader == null ? color : null,
    foreground: shader == null ? null : (Paint()..shader = shader),
    height: 1.1,
  );
  final tp = TextPainter(
    text: TextSpan(text: s, style: style),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  tp.paint(c, o);
}

void _iconBadge(Canvas c, Offset center, double size, DwIcons icon, Color color) {
  final r = RRect.fromRectAndRadius(
    Rect.fromCenter(center: center, width: size, height: size),
    Radius.circular(size * 0.32),
  );
  c.drawRRect(
    r.inflate(6),
    Paint()
      ..color = color.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
  );
  c.drawRRect(
    r,
    Paint()
      ..shader = ui.Gradient.linear(r.outerRect.topLeft, r.outerRect.bottomRight, [
        color,
        Color.lerp(color, Colors.black, 0.25)!,
      ]),
  );
  c.save();
  c.translate(center.dx - size * 0.27, center.dy - size * 0.27);
  DwIconPainter(icon, AppColors.bg, 2.1).paint(c, Size.square(size * 0.54));
  c.restore();
}

void main() {
  final enabled = Platform.environment['GENERATE_ASSETS'] == '1';

  test('generate icons and store graphics', () async {
    await _loadFonts();

    // Play Store icon: full-bleed square (Play applies its own mask).
    await _save('assets/icon/app_icon.png', const Size(512, 512), (c) {
      LogoPainter(1, glow: false, square: true, figureScale: 0.8).paint(c, const Size(512, 512));
    });

    // Legacy launcher icons (rounded) for each density.
    const densities = {'mdpi': 1.0, 'hdpi': 1.5, 'xhdpi': 2.0, 'xxhdpi': 3.0, 'xxxhdpi': 4.0};
    final res = 'android/app/src/main/res';
    for (final e in densities.entries) {
      final px = 48 * e.value;
      await _save('$res/mipmap-${e.key}/ic_launcher.png', Size(px, px), (c) {
        c.translate(px * 0.04, px * 0.04);
        LogoPainter(1, glow: false, figureScale: 0.92).paint(c, Size.square(px * 0.92));
      });
      // Adaptive icon foreground: 108dp canvas, figure inside the 66dp safe zone.
      final fg = 108 * e.value;
      await _save('$res/drawable-${e.key}/ic_launcher_foreground.png', Size(fg, fg), (c) {
        LogoPainter(1, glow: false, background: false, figureScale: 0.6).paint(c, Size.square(fg));
      });
    }

    // Feature graphic 1024x500.
    const fs = Size(1024, 500);
    await _save('assets/store/feature_graphic.png', fs, (c) {
      final rect = Offset.zero & fs;
      c.drawRect(
        rect,
        Paint()
          ..shader = ui.Gradient.linear(
            rect.topLeft,
            rect.bottomRight,
            [const Color(0xFF0A1024), const Color(0xFF0B1530), const Color(0xFF140F33)],
            [0, 0.5, 1],
          ),
      );
      for (final (o, r, col, a) in [
        (const Offset(120, 40), 420.0, AppColors.teal, 0.20),
        (const Offset(820, 300), 460.0, AppColors.blue, 0.24),
        (const Offset(560, 520), 360.0, AppColors.violet, 0.18),
      ]) {
        c.drawCircle(
          o,
          r,
          Paint()..shader = ui.Gradient.radial(o, r, [col.withValues(alpha: a), col.withValues(alpha: 0)]),
        );
      }
      final rnd = math.Random(4);
      for (var i = 0; i < 90; i++) {
        c.drawCircle(
          Offset(rnd.nextDouble() * fs.width, rnd.nextDouble() * fs.height),
          0.8 + rnd.nextDouble() * 1.6,
          Paint()..color = Colors.white.withValues(alpha: 0.05 + rnd.nextDouble() * 0.12),
        );
      }

      // Right: glowing stage with the illustrated character.
      const stageC = Offset(770, 250);
      c.drawCircle(
        stageC,
        230,
        Paint()
          ..shader = ui.Gradient.radial(stageC, 230, [
            AppColors.teal.withValues(alpha: 0.28),
            AppColors.teal.withValues(alpha: 0.0),
          ]),
      );
      c.drawCircle(stageC, 196, Paint()..color = const Color(0xFF0E1530));
      c.drawCircle(
        stageC,
        196,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..shader = ui.Gradient.sweep(
            stageC,
            [AppColors.teal, AppColors.blue, AppColors.violet, AppColors.teal],
            [0, 0.33, 0.66, 1],
          ),
      );
      for (var i = 0; i < 60; i++) {
        if (i % 5 == 0) continue;
        final a = i / 60 * math.pi * 2;
        final d = Offset(math.cos(a), math.sin(a));
        c.drawLine(
          stageC + d * 212,
          stageC + d * 218,
          Paint()
            ..color = AppColors.teal.withValues(alpha: 0.5)
            ..strokeWidth = 2
            ..strokeCap = StrokeCap.round,
        );
      }
      c.save();
      c.clipPath(Path()..addOval(Rect.fromCircle(center: stageC, radius: 194)));
      final v = ShoulderClips.sideBend;
      final pose = v.clip.frames[1].value;
      c.translate(stageC.dx - 200, stageC.dy - 200);
      FigurePainter(pose: pose, scene: v.scene, focus: v.focus, pulse: 0.25).paint(c, const Size(400, 410));
      c.restore();
      _iconBadge(c, const Offset(585, 120), 62, DwIcons.neck, AppColors.teal);
      _iconBadge(c, const Offset(960, 140), 58, DwIcons.eye, AppColors.violet);
      _iconBadge(c, const Offset(975, 380), 58, DwIcons.leaf, AppColors.lime);
      _iconBadge(c, const Offset(585, 395), 56, DwIcons.drop, AppColors.sky);

      // Left: brand.
      c.save();
      c.translate(64, 70);
      LogoPainter(1, glow: true).paint(c, const Size(96, 96));
      c.restore();
      _text(
        c,
        'Desk Workout',
        const Offset(60, 190),
        70,
        FontWeight.w900,
        Colors.white,
        spacing: -2,
        shader: ui.Gradient.linear(
          const Offset(60, 190),
          const Offset(520, 260),
          [Colors.white, const Color(0xFFBFFCF1), AppColors.teal],
          [0, 0.6, 1],
        ),
      );
      _text(
        c,
        'Stretch  ·  Breathe  ·  Focus',
        const Offset(64, 278),
        26,
        FontWeight.w500,
        AppColors.textSecondary,
        spacing: 1.5,
      );
      var x = 64.0;
      for (final (label, col) in [
        ('Posture', AppColors.teal),
        ('Eye care', AppColors.violet),
        ('Nutrition', AppColors.lime),
      ]) {
        final tp = TextPainter(
          text: TextSpan(
            text: label,
            style: TextStyle(fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.w700, color: col),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        final r = RRect.fromRectAndRadius(Rect.fromLTWH(x, 350, tp.width + 36, 44), const Radius.circular(22));
        c.drawRRect(r, Paint()..color = col.withValues(alpha: 0.14));
        c.drawRRect(
          r,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..color = col.withValues(alpha: 0.6),
        );
        tp.paint(c, Offset(x + 18, 350 + (44 - tp.height) / 2));
        x += tp.width + 50;
      }
      _text(
        c,
        'Animated routines made for desk workers',
        const Offset(64, 418),
        20,
        FontWeight.w400,
        AppColors.textMuted,
      );
    });
  }, skip: !enabled);
}
