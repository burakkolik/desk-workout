import 'package:flutter/widgets.dart';

import '../features/progress/application/progress_controller.dart';
import '../features/settings/application/settings_controller.dart';

/// Makes the app-wide controllers available to the widget tree and rebuilds
/// dependents whenever one of them changes.
class AppScope extends InheritedNotifier<Listenable> {
  AppScope({super.key, required this.settings, required this.progress, required super.child})
    : super(notifier: Listenable.merge([settings, progress]));

  final SettingsController settings;
  final ProgressController progress;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in context');
    return scope!;
  }

  /// Read without subscribing to changes (for callbacks).
  static AppScope read(BuildContext context) => context.getInheritedWidgetOfExactType<AppScope>()!;
}

extension AppScopeContext on BuildContext {
  SettingsController get settings => AppScope.of(this).settings;
  ProgressController get progress => AppScope.of(this).progress;
}
