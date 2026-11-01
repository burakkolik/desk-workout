import '../../../l10n/generated/app_localizations.dart';
import '../../figure/domain/exercise_visual.dart';
import '../../figure/domain/skeleton.dart';
import 'exercise_category.dart';

typedef L10nText = String Function(AppLocalizations l);

/// How an exercise is dosed (shown to the user, localized in the UI).
enum DoseKind { reps, repsEachSide, hold, holdEachSide, breaths, seconds, rounds }

class Dose {
  const Dose(this.kind, this.amount);

  final DoseKind kind;
  final int amount;

  String label(AppLocalizations l) => switch (kind) {
    DoseKind.reps => l.doseReps(amount),
    DoseKind.repsEachSide => l.doseRepsEachSide(amount),
    DoseKind.hold => l.doseHold(amount),
    DoseKind.holdEachSide => l.doseHoldEachSide(amount),
    DoseKind.breaths => l.doseBreaths(amount),
    DoseKind.seconds => l.doseSeconds(amount),
    DoseKind.rounds => l.doseRounds(amount),
  };
}

enum Difficulty { easy, medium }

/// A single exercise. All user facing text is resolved lazily from the
/// localization bundle so adding a language never touches this file.
class Exercise {
  const Exercise({
    required this.id,
    required this.category,
    required this.name,
    required this.summary,
    required this.steps,
    required this.tip,
    required this.dose,
    required this.durationSec,
    required this.visual,
    this.focus = const [],
    this.standing = false,
    this.difficulty = Difficulty.easy,
    this.source,
  });

  final String id;
  final ExerciseCategory category;
  final L10nText name;
  final L10nText summary;

  /// Newline separated steps.
  final L10nText steps;
  final L10nText tip;
  final Dose dose;

  /// Time slot used by the guided workout player.
  final int durationSec;
  final ExerciseVisual visual;
  final List<BodyArea> focus;
  final bool standing;
  final Difficulty difficulty;

  /// Reference used to verify the movement (shown in the detail page).
  final String? source;

  List<String> stepList(AppLocalizations l) =>
      steps(l).split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
}
