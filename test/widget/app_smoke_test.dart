import 'package:deskworkout/app/app.dart';
import 'package:deskworkout/core/icons/dw_icons.dart';
import 'package:deskworkout/core/storage/preferences_service.dart';
import 'package:deskworkout/features/progress/application/progress_controller.dart';
import 'package:deskworkout/features/settings/application/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const sizes = <String, Size>{
  'small phone': Size(320, 568),
  'phone': Size(412, 915),
  'phone landscape': Size(915, 412),
  'tablet': Size(1024, 1366),
  'tablet landscape': Size(1366, 1024),
};

Future<void> pumpFor(WidgetTester tester, Duration d) async {
  final steps = d.inMilliseconds ~/ 100;
  for (var i = 0; i < steps; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Scrolls [finder] into the middle of its scrollable (if any).
Future<void> reveal(WidgetTester tester, Finder finder) async {
  await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  for (final lang in ['en', 'tr']) {
    for (final entry in sizes.entries) {
      testWidgets('full flow on ${entry.key} ($lang)', (tester) async {
        tester.view.physicalSize = entry.value * 2;
        tester.view.devicePixelRatio = 2;
        addTearDown(tester.view.reset);
        SharedPreferences.setMockInitialValues({'settings.locale': lang});
        final prefs = await PreferencesService.create();
        final settings = SettingsController(prefs);
        final progress = ProgressController(prefs);

        await tester.pumpWidget(DeskWorkoutApp(settings: settings, progress: progress));
        // Splash.
        await pumpFor(tester, const Duration(milliseconds: 3600));
        // Onboarding: go through every page.
        for (var i = 0; i < 4; i++) {
          await tester.tap(find.text(lang == 'en' ? 'Next' : 'İleri'));
          await pumpFor(tester, const Duration(milliseconds: 900));
        }
        await tester.tap(find.text(lang == 'en' ? 'Let’s start' : 'Hadi başlayalım'));
        await pumpFor(tester, const Duration(milliseconds: 1200));
        expect(settings.onboardingDone, isTrue);

        // Visit every tab.
        final tabs = lang == 'en'
            ? ['Exercises', 'Eyes', 'Nutrition', 'Progress', 'Today']
            : ['Egzersizler', 'Gözler', 'Beslenme', 'İlerleme', 'Bugün'];
        for (final tab in tabs) {
          await tester.tap(find.text(tab).last);
          await pumpFor(tester, const Duration(milliseconds: 700));
          // Scroll the tab to render all of its content.
          final scrollable = find.byType(Scrollable).hitTestable();
          if (scrollable.evaluate().isNotEmpty) {
            await tester.drag(scrollable.first, const Offset(0, -3000));
            await pumpFor(tester, const Duration(milliseconds: 600));
            await tester.drag(scrollable.first, const Offset(0, 3000));
            await pumpFor(tester, const Duration(milliseconds: 400));
          }
        }

        // Start the quick break and skip through it.
        final start = find.text(lang == 'en' ? 'Start now' : 'Hemen başla');
        await reveal(tester, start);
        await pumpFor(tester, const Duration(milliseconds: 500));
        await tester.tap(start);
        await pumpFor(tester, const Duration(milliseconds: 1500));
        final next = find.byWidgetPredicate((w) => w is DwIcon && w.icon == DwIcons.next);
        for (var i = 0; i < 8; i++) {
          expect(next, findsOneWidget);
          await tester.tap(next);
          await pumpFor(tester, const Duration(milliseconds: 1500));
        }
        await pumpFor(tester, const Duration(seconds: 2));
        final done = find.text(lang == 'en' ? 'Done' : 'Tamam');
        expect(done, findsOneWidget);
        await reveal(tester, done);
        expect(progress.totalSessions, 1);
        await tester.tap(done);
        await pumpFor(tester, const Duration(seconds: 1));
      });
    }
  }
}
