import 'package:flutter/widgets.dart';

import '../../../core/storage/preferences_service.dart';

/// User preferences. `localeCode == null` means "follow the device language".
class SettingsController extends ChangeNotifier {
  SettingsController(this._prefs) {
    _localeCode = _prefs.getString(_kLocale);
    _onboardingDone = _prefs.getBool(_kOnboarding) ?? false;
    _dailyGoalMin = _prefs.getInt(_kGoal) ?? 10;
    _breakIntervalMin = _prefs.getInt(_kBreak) ?? 30;
    _waterGoal = _prefs.getInt(_kWater) ?? 8;
  }

  final PreferencesService _prefs;

  static const _kLocale = 'settings.locale';
  static const _kOnboarding = 'settings.onboardingDone';
  static const _kGoal = 'settings.dailyGoalMin';
  static const _kBreak = 'settings.breakIntervalMin';
  static const _kWater = 'settings.waterGoal';

  static const goalOptions = [5, 10, 15, 20, 30];
  static const breakOptions = [20, 30, 45, 60];

  String? _localeCode;
  bool _onboardingDone = false;
  int _dailyGoalMin = 10;
  int _breakIntervalMin = 30;
  int _waterGoal = 8;

  String? get localeCode => _localeCode;
  Locale? get locale => _localeCode == null ? null : Locale(_localeCode!);
  bool get onboardingDone => _onboardingDone;
  int get dailyGoalMin => _dailyGoalMin;
  int get breakIntervalMin => _breakIntervalMin;
  int get waterGoal => _waterGoal;

  Future<void> setLocaleCode(String? code) async {
    _localeCode = code;
    notifyListeners();
    await _prefs.setString(_kLocale, code);
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    notifyListeners();
    await _prefs.setBool(_kOnboarding, true);
  }

  Future<void> setDailyGoal(int minutes) async {
    _dailyGoalMin = minutes;
    notifyListeners();
    await _prefs.setInt(_kGoal, minutes);
  }

  Future<void> setBreakInterval(int minutes) async {
    _breakIntervalMin = minutes;
    notifyListeners();
    await _prefs.setInt(_kBreak, minutes);
  }

  Future<void> setWaterGoal(int glasses) async {
    _waterGoal = glasses.clamp(4, 16);
    notifyListeners();
    await _prefs.setInt(_kWater, _waterGoal);
  }
}
