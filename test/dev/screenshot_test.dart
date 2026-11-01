// Dev tool: captures real-font screenshots of the main screens for visual QA.
// Run with: SCREENSHOTS=1 flutter test test/dev/screenshot_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:deskworkout/app/app.dart';
import 'package:deskworkout/core/storage/preferences_service.dart';
import 'package:deskworkout/features/progress/application/progress_controller.dart';
import 'package:deskworkout/features/settings/application/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT']!;
  final dir = '$root/bin/cache/artifacts/material_fonts';
  final loader = FontLoader('Roboto');
  for (final f in ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf', 'Roboto-Black.ttf']) {
    loader.addFont(Future.value(ByteData.sublistView(File('$dir/$f').readAsBytesSync())));
  }
  await loader.load();
}

final _key = GlobalKey();

Future<void> shot(WidgetTester tester, String name) async {
  await tester.runAsync(() async {
    final b = _key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final img = await b.toImage(pixelRatio: 1);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    File('build/screens/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(data!.buffer.asUint8List());
  });
}

Future<void> pumpFor(WidgetTester tester, int ms) async {
  for (var i = 0; i < ms ~/ 100; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  final enabled = Platform.environment['SCREENSHOTS'] == '1';
  final lang = Platform.environment['LANG_CODE'] ?? 'tr';
  final w = double.parse(Platform.environment['W'] ?? '400');
  final h = double.parse(Platform.environment['H'] ?? '860');
  testWidgets('screens', (tester) async {
    await tester.runAsync(loadFonts);
    tester.view.physicalSize = Size(w, h);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({'settings.locale': lang});
    final prefs = await PreferencesService.create();
    final settings = SettingsController(prefs);
    final progress = ProgressController(prefs);
    await progress.logSession(seconds: 420, exercises: 6);
    await progress.addWater(5);
    await tester.pumpWidget(
      RepaintBoundary(
        key: _key,
        child: DeskWorkoutApp(settings: settings, progress: progress),
      ),
    );
    await pumpFor(tester, 1300);
    await shot(tester, '00_splash');
    await pumpFor(tester, 2400);
    await shot(tester, '01_onboarding1');
    final next = find.text(lang == 'en' ? 'Next' : 'İleri');
    for (var i = 2; i <= 5; i++) {
      await tester.tap(next.evaluate().isEmpty ? find.text(lang == 'en' ? 'Let’s start' : 'Hadi başlayalım') : next);
      await pumpFor(tester, 1500);
      await shot(tester, '0${i}_onboarding$i');
    }
    await tester.tap(find.text(lang == 'en' ? 'Let’s start' : 'Hadi başlayalım'));
    await pumpFor(tester, 2500);
    await shot(tester, '10_home');
    await tester.drag(find.byType(Scrollable).hitTestable().first, Offset(0, -h * 0.8));
    await pumpFor(tester, 1500);
    await shot(tester, '11_home_scrolled');
    final tabs = lang == 'en'
        ? ['Exercises', 'Eyes', 'Nutrition', 'Progress']
        : ['Egzersizler', 'Gözler', 'Beslenme', 'İlerleme'];
    var n = 20;
    for (final t in tabs) {
      await tester.tap(find.text(t).last);
      await pumpFor(tester, 1800);
      await shot(tester, '${n}_$t');
      await tester.drag(find.byType(Scrollable).hitTestable().first, Offset(0, -h * 0.7));
      await pumpFor(tester, 1500);
      await shot(tester, '${n + 1}_${t}_scrolled');
      await tester.drag(find.byType(Scrollable).hitTestable().first, Offset(0, -h * 0.8));
      await pumpFor(tester, 1500);
      await shot(tester, '${n + 2}_${t}_scrolled2');
      n += 10;
    }
    // Exercise detail + player.
    await tester.tap(find.text(tabs.first).last);
    await pumpFor(tester, 800);
    await tester.drag(find.byType(Scrollable).hitTestable().first, const Offset(0, 6000));
    await pumpFor(tester, 800);
    final chin = find.text(lang == 'en' ? 'Chin Tuck' : 'Çene Geri Çekme').first;
    await Scrollable.ensureVisible(tester.element(chin), alignment: 0.4);
    await pumpFor(tester, 600);
    await tester.tap(chin);
    await pumpFor(tester, 1500);
    await shot(tester, '60_detail');
    await tester.tap(find.text(lang == 'en' ? 'Start exercise' : 'Egzersize başla'));
    await pumpFor(tester, 1500);
    await shot(tester, '61_player_ready');
    await pumpFor(tester, 6000);
    await shot(tester, '62_player_active');
  }, skip: !enabled);
}
