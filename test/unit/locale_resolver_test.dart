import 'package:deskworkout/core/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Turkish device gets Turkish', () {
    expect(LocaleResolver.resolve(const [Locale('tr', 'TR')]).languageCode, 'tr');
  });
  test('English device gets English', () {
    expect(LocaleResolver.resolve(const [Locale('en', 'GB')]).languageCode, 'en');
  });
  test('Unsupported device language falls back to English', () {
    expect(LocaleResolver.resolve(const [Locale('de', 'DE')]).languageCode, 'en');
    expect(LocaleResolver.resolve(null).languageCode, 'en');
  });
  test('First supported preferred language wins', () {
    expect(LocaleResolver.resolve(const [Locale('fr'), Locale('tr')]).languageCode, 'tr');
  });
  test('Every language provides a native name', () {
    for (final l in LocaleResolver.supported) {
      expect(LocaleResolver.nativeName(l), isNotEmpty);
    }
  });
}
