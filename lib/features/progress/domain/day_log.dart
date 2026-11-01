/// Activity recorded for one calendar day.
class DayLog {
  const DayLog({this.seconds = 0, this.sessions = 0, this.exercises = 0, this.water = 0});

  final int seconds;
  final int sessions;
  final int exercises;
  final int water;

  bool get active => sessions > 0;

  DayLog copyWith({int? seconds, int? sessions, int? exercises, int? water}) => DayLog(
    seconds: seconds ?? this.seconds,
    sessions: sessions ?? this.sessions,
    exercises: exercises ?? this.exercises,
    water: water ?? this.water,
  );

  Map<String, int> toJson() => {'s': seconds, 'n': sessions, 'e': exercises, 'w': water};

  factory DayLog.fromJson(Map<String, dynamic> j) => DayLog(
    seconds: (j['s'] as num?)?.toInt() ?? 0,
    sessions: (j['n'] as num?)?.toInt() ?? 0,
    exercises: (j['e'] as num?)?.toInt() ?? 0,
    water: (j['w'] as num?)?.toInt() ?? 0,
  );
}
