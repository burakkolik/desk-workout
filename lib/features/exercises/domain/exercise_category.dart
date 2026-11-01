import 'package:flutter/painting.dart';

import '../../../core/icons/dw_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Exercise categories, ordered as shown in the library.
enum ExerciseCategory {
  neck(DwIcons.neck, AppColors.teal),
  shoulders(DwIcons.shoulder, AppColors.blue),
  wrists(DwIcons.wrist, AppColors.amber),
  back(DwIcons.spine, AppColors.coral),
  legs(DwIcons.legs, AppColors.lime),
  eyes(DwIcons.eye, AppColors.violet),
  breathing(DwIcons.lungs, AppColors.sky);

  const ExerciseCategory(this.icon, this.color);

  final DwIcons icon;
  final Color color;

  String label(AppLocalizations l) => switch (this) {
    neck => l.catNeck,
    shoulders => l.catShoulders,
    wrists => l.catWrists,
    back => l.catBack,
    legs => l.catLegs,
    eyes => l.catEyes,
    breathing => l.catBreathing,
  };

  String description(AppLocalizations l) => switch (this) {
    neck => l.catNeckDesc,
    shoulders => l.catShouldersDesc,
    wrists => l.catWristsDesc,
    back => l.catBackDesc,
    legs => l.catLegsDesc,
    eyes => l.catEyesDesc,
    breathing => l.catBreathingDesc,
  };
}
