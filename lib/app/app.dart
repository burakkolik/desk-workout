import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/l10n/l10n.dart';
import '../core/responsive/responsive.dart';
import '../core/theme/app_theme.dart';
import '../features/progress/application/progress_controller.dart';
import '../features/settings/application/settings_controller.dart';
import '../features/splash/presentation/splash_screen.dart';
import 'app_scope.dart';

class DeskWorkoutApp extends StatelessWidget {
  const DeskWorkoutApp({super.key, required this.settings, required this.progress});

  final SettingsController settings;
  final ProgressController progress;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      settings: settings,
      progress: progress,
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => context.l10n.appName,
          theme: AppTheme.dark(),
          // null = follow the device; resolved below with English fallback.
          locale: settings.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeListResolutionCallback: (deviceLocales, _) => settings.locale ?? LocaleResolver.resolve(deviceLocales),
          builder: (context, child) => _TextScaleGuard(child: child!),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

/// Slightly enlarges text on tablets and keeps extreme accessibility scales
/// from breaking layouts.
class _TextScaleGuard extends StatelessWidget {
  const _TextScaleGuard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final rs = context.rs;
    final deviceFactor = rs.isTablet ? 1.12 : (rs.shortest < 340 ? 0.92 : 1.0);
    final user = mq.textScaler.scale(1);
    final scale = (user * deviceFactor).clamp(0.85, 1.35);
    return MediaQuery(
      data: mq.copyWith(textScaler: TextScaler.linear(scale)),
      child: child,
    );
  }
}
