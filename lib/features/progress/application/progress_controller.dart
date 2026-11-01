import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../core/storage/preferences_service.dart';
import '../domain/day_log.dart';

/// Tracks workouts, water and streaks per day (stored locally).
class ProgressController extends ChangeNotifier {
  ProgressController(this._prefs, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now {
    final raw = _prefs.getString(_kLogs);
    if (raw != null) {
      try {
        final map = jsonDecode(raw) as Map<String, dynamic>;
        map.forEach((k, v) => _logs[k] = DayLog.fromJson(v as Map<String, dynamic>));
      } catch (_) {
        // Corrupted data: start fresh rather than crash.
      }
    }
    final last = _prefs.getInt(_kLastBreak);
    _lastBreak = last == null ? _clock() : DateTime.fromMillisecondsSinceEpoch(last);
  }

  final PreferencesService _prefs;
  final DateTime Function() _clock;
  final Map<String, DayLog> _logs = {};
  late DateTime _lastBreak;

  static const _kLogs = 'progress.logs';
  static const _kLastBreak = 'progress.lastBreak';

  static String keyOf(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  DateTime get now => _clock();
  DateTime get lastBreak => _lastBreak;

  DayLog dayLog(DateTime d) => _logs[keyOf(d)] ?? const DayLog();
  DayLog get today => dayLog(now);

  /// Last 7 days, oldest first.
  List<(DateTime, DayLog)> get week {
    final n = now;
    return [
      for (var i = 6; i >= 0; i--)
        () {
          final d = DateTime(n.year, n.month, n.day - i);
          return (d, dayLog(d));
        }(),
    ];
  }

  int get currentStreak {
    final n = now;
    var day = DateTime(n.year, n.month, n.day);
    // Today may still be pending; the streak continues from yesterday.
    if (!dayLog(day).active) day = DateTime(day.year, day.month, day.day - 1);
    var streak = 0;
    while (dayLog(day).active) {
      streak++;
      day = DateTime(day.year, day.month, day.day - 1);
    }
    return streak;
  }

  int get bestStreak {
    final days = _logs.entries.where((e) => e.value.active).map((e) => DateTime.parse('${e.key}T00:00:00Z')).toList()
      ..sort();
    var best = 0;
    var run = 0;
    DateTime? prev;
    for (final d in days) {
      run = (prev != null && d.difference(prev).inDays == 1) ? run + 1 : 1;
      if (run > best) best = run;
      prev = d;
    }
    return best;
  }

  int get totalSeconds => _logs.values.fold(0, (s, l) => s + l.seconds);
  int get totalSessions => _logs.values.fold(0, (s, l) => s + l.sessions);
  int get totalExercises => _logs.values.fold(0, (s, l) => s + l.exercises);
  int get activeDays => _logs.values.where((l) => l.active).length;
  int get bestWaterDay => _logs.values.fold(0, (s, l) => l.water > s ? l.water : s);

  Future<void> logSession({required int seconds, required int exercises}) async {
    final k = keyOf(now);
    final cur = _logs[k] ?? const DayLog();
    _logs[k] = cur.copyWith(
      seconds: cur.seconds + seconds,
      sessions: cur.sessions + 1,
      exercises: cur.exercises + exercises,
    );
    _lastBreak = now;
    notifyListeners();
    await _save();
    await _prefs.setInt(_kLastBreak, _lastBreak.millisecondsSinceEpoch);
  }

  Future<void> addWater(int delta) async {
    final k = keyOf(now);
    final cur = _logs[k] ?? const DayLog();
    _logs[k] = cur.copyWith(water: (cur.water + delta).clamp(0, 30));
    notifyListeners();
    await _save();
  }

  Future<void> markBreak() async {
    _lastBreak = now;
    notifyListeners();
    await _prefs.setInt(_kLastBreak, _lastBreak.millisecondsSinceEpoch);
  }

  Future<void> reset() async {
    _logs.clear();
    _lastBreak = now;
    notifyListeners();
    await _prefs.remove(_kLogs);
    await _prefs.remove(_kLastBreak);
  }

  Future<void> _save() => _prefs.setString(_kLogs, jsonEncode(_logs.map((k, v) => MapEntry(k, v.toJson()))));
}
