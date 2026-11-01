import '../../../core/icons/dw_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/exercise.dart';
import '../domain/routine.dart';
import 'exercise_catalog.dart';

/// Guided programs built from the exercise catalog.
abstract final class RoutineCatalog {
  static final quickReset = Routine(
    id: 'quickReset',
    name: (l) => l.rtQuickName,
    description: (l) => l.rtQuickDesc,
    exerciseIds: const ['chinTuck', 'shoulderRolls', 'wristCircles', 'spinalTwist'],
    gradient: AppGradients.primary,
    icon: DwIcons.bolt,
  );

  static final all = <Routine>[
    quickReset,
    Routine(
      id: 'neckRelief',
      name: (l) => l.rtNeckName,
      description: (l) => l.rtNeckDesc,
      exerciseIds: const [
        'chinTuck',
        'neckSideTilt',
        'neckRotation',
        'upperTrapStretch',
        'levatorStretch',
        'shoulderShrugs',
        'shoulderRolls',
      ],
      gradient: AppGradients.of(AppColors.teal),
      icon: DwIcons.neck,
    ),
    Routine(
      id: 'wristCare',
      name: (l) => l.rtWristName,
      description: (l) => l.rtWristDesc,
      exerciseIds: const ['wristCircles', 'wristFlexorStretch', 'wristExtensorStretch', 'prayerStretch'],
      gradient: AppGradients.sunrise,
      icon: DwIcons.wrist,
    ),
    Routine(
      id: 'backRescue',
      name: (l) => l.rtBackName,
      description: (l) => l.rtBackDesc,
      exerciseIds: const ['catCow', 'spinalTwist', 'overheadSideBend', 'forwardFold', 'figureFour', 'hamstringStretch'],
      gradient: AppGradients.energy,
      icon: DwIcons.spine,
    ),
    Routine(
      id: 'eyeRecharge',
      name: (l) => l.rtEyeName,
      description: (l) => l.rtEyeDesc,
      exerciseIds: const ['rule202020', 'blinking', 'eyeMovements', 'nearFarFocus', 'palming'],
      gradient: AppGradients.calm,
      icon: DwIcons.eye,
    ),
    Routine(
      id: 'energyBoost',
      name: (l) => l.rtEnergyName,
      description: (l) => l.rtEnergyDesc,
      exerciseIds: const ['seatedMarching', 'chairSquat', 'deskPushUp', 'calfRaises', 'legExtension', 'anklePumps'],
      gradient: AppGradients.of(AppColors.coral),
      icon: DwIcons.flame,
    ),
    Routine(
      id: 'postureFix',
      name: (l) => l.rtPostureName,
      description: (l) => l.rtPostureDesc,
      exerciseIds: const [
        'chinTuck',
        'scapularSqueeze',
        'chestOpener',
        'thoracicExtension',
        'crossBodyStretch',
        'hipFlexorStretch',
      ],
      gradient: AppGradients.fresh,
      icon: DwIcons.chair,
    ),
    Routine(
      id: 'calmDown',
      name: (l) => l.rtCalmName,
      description: (l) => l.rtCalmDesc,
      exerciseIds: const ['boxBreathing', 'neckSideTilt', 'overheadSideBend', 'bellyBreathing', 'palming'],
      gradient: AppGradients.of(AppColors.violet),
      icon: DwIcons.lungs,
    ),
    Routine(
      id: 'fullDesk',
      name: (l) => l.rtFullName,
      description: (l) => l.rtFullDesc,
      exerciseIds: const [
        'seatedMarching',
        'chinTuck',
        'shoulderRolls',
        'crossBodyStretch',
        'tricepsStretch',
        'wristFlexorStretch',
        'catCow',
        'spinalTwist',
        'chairSquat',
        'deskPushUp',
        'hamstringStretch',
        'rule202020',
        'boxBreathing',
      ],
      gradient: AppGradients.of(AppColors.blue),
      icon: DwIcons.trophy,
    ),
  ];

  static Routine byId(String id) => all.firstWhere((r) => r.id == id);

  static List<Exercise> exercisesOf(Routine r) => r.exerciseIds.map(ExerciseCatalog.byId).toList();

  static int durationOf(Routine r) => exercisesOf(r).fold(0, (s, e) => s + e.durationSec);
}
