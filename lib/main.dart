import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'core/storage/preferences_service.dart';
import 'features/progress/application/progress_controller.dart';
import 'features/settings/application/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  final prefs = await PreferencesService.create();
  runApp(DeskWorkoutApp(settings: SettingsController(prefs), progress: ProgressController(prefs)));
}
