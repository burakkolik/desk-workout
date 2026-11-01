import 'package:flutter/painting.dart';

import '../../../core/icons/dw_icons.dart';
import 'exercise.dart';

/// A guided sequence of exercises.
class Routine {
  const Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.exerciseIds,
    required this.gradient,
    required this.icon,
  });

  final String id;
  final L10nText name;
  final L10nText description;
  final List<String> exerciseIds;
  final LinearGradient gradient;
  final DwIcons icon;
}
