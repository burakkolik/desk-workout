import 'package:flutter/widgets.dart';

import '../../l10n/generated/app_localizations.dart';

export '../../l10n/generated/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Language selection logic.
///
/// Supported languages come straight from the ARB files (generated
/// `AppLocalizations.supportedLocales`), so adding `app_xx.arb` is all that
/// is needed to support a new language – it automatically appears in the
/// language picker and is picked when the device uses it.
abstract final class LocaleResolver {
  static const fallback = Locale('en');

  static List<Locale> get supported => AppLocalizations.supportedLocales;

  /// Picks the first device language we support, otherwise English.
  static Locale resolve(List<Locale>? deviceLocales) {
    for (final device in deviceLocales ?? const <Locale>[]) {
      for (final s in supported) {
        if (s.languageCode == device.languageCode) return s;
      }
    }
    return fallback;
  }

  /// The language's own name (e.g. "Türkçe"), read from its ARB file.
  static String nativeName(Locale locale) => lookupAppLocalizations(locale).languageNativeName;
}
