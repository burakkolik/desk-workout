import '../l10n/l10n.dart';

/// Formats seconds as m:ss.
String clock(int seconds) {
  final s = seconds < 0 ? 0 : seconds;
  final m = s ~/ 60;
  final r = s % 60;
  return '$m:${r.toString().padLeft(2, '0')}';
}

/// Human friendly duration ("1 h 5 min" / "12 min").
String humanDuration(AppLocalizations l, Duration d) {
  final h = d.inHours;
  final m = d.inMinutes % 60;
  if (h > 0) return l.hoursMinutes(h, m);
  return l.minutesShort(d.inMinutes);
}
