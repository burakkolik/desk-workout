// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Desk Workout';

  @override
  String get languageNativeName => 'English';

  @override
  String get appTagline => 'Move better at your desk';

  @override
  String get splashTagline => 'Stretch · Breathe · Focus';

  @override
  String get navToday => 'Today';

  @override
  String get navExercises => 'Exercises';

  @override
  String get navEyes => 'Eyes';

  @override
  String get navNutrition => 'Nutrition';

  @override
  String get navProgress => 'Progress';

  @override
  String get onbSkip => 'Skip';

  @override
  String get onbNext => 'Next';

  @override
  String get onbStart => 'Let’s start';

  @override
  String get onb1Title => 'Your desk,\nyour gym';

  @override
  String get onb1Body => 'Short, science-backed routines designed only for people who sit at a desk all day.';

  @override
  String get onb2Title => 'Fix the\nscreen posture';

  @override
  String get onb2Body => 'Neck, shoulders, wrists and back: every move is animated step by step so you do it right.';

  @override
  String get onb3Title => 'Rest your\neyes';

  @override
  String get onb3Body => 'The 20-20-20 rule, blinking and focus drills protect your eyes from digital strain.';

  @override
  String get onb4Title => 'Fuel the\nworkday';

  @override
  String get onb4Body => 'Track water, keep caffeine in check and pick smart desk snacks.';

  @override
  String get onbSetupTitle => 'Make it yours';

  @override
  String get onbSetupBody => 'You can change these anytime in settings.';

  @override
  String get onbGoalLabel => 'Daily movement goal';

  @override
  String get onbBreakLabel => 'Remind me to move';

  @override
  String minutesShort(int count) {
    return '$count min';
  }

  @override
  String everyMinutes(int count) {
    return 'Every $count min';
  }

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get homeSubtitle => 'Ready for a quick reset?';

  @override
  String get todayGoal => 'Today’s goal';

  @override
  String minutesOfGoal(int done, int goal) {
    return '$done of $goal min';
  }

  @override
  String get goalReached => 'Goal reached! 🎉';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count day streak',
      one: '1 day streak',
      zero: 'No streak yet',
    );
    return '$_temp0';
  }

  @override
  String sittingFor(String time) {
    return 'Sitting for $time';
  }

  @override
  String get timeToMove => 'Time to move! Take a 2-minute break.';

  @override
  String sittingOk(String time) {
    return 'Next break suggested in $time';
  }

  @override
  String get tookBreak => 'I took a break';

  @override
  String get quickBreak => '2-minute reset';

  @override
  String get quickBreakDesc => 'Neck, shoulders, wrists and back in one quick flow.';

  @override
  String get startNow => 'Start now';

  @override
  String get programs => 'Programs';

  @override
  String get programsSubtitle => 'Guided routines for every desk problem';

  @override
  String get seeAll => 'See all';

  @override
  String get tipOfDay => 'Tip of the day';

  @override
  String get waterToday => 'Water today';

  @override
  String glassesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count glasses', one: '1 glass');
    return '$_temp0';
  }

  @override
  String glassesOfGoal(int count, int goal) {
    return '$count / $goal glasses';
  }

  @override
  String get bodyAreasTitle => 'Target an area';

  @override
  String hoursMinutes(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get libraryTitle => 'Exercise library';

  @override
  String get librarySubtitle => 'Every movement verified against medical sources';

  @override
  String get filterAll => 'All';

  @override
  String exercisesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count exercises', one: '1 exercise');
    return '$_temp0';
  }

  @override
  String secondsShort(int count) {
    return '$count s';
  }

  @override
  String get howTo => 'How to do it';

  @override
  String get proTip => 'Pro tip';

  @override
  String get targetAreas => 'Target areas';

  @override
  String get startExercise => 'Start exercise';

  @override
  String get sourceLabel => 'Source';

  @override
  String get standingLabel => 'Standing';

  @override
  String get seatedLabel => 'Seated';

  @override
  String get safetyNote =>
      'Move gently and stay pain-free. Stop if anything hurts and talk to a health professional if pain persists.';

  @override
  String get routineStart => 'Start program';

  @override
  String get routineIncludes => 'What’s inside';

  @override
  String get areaNeck => 'Neck';

  @override
  String get areaShoulders => 'Shoulders';

  @override
  String get areaUpperBack => 'Upper back';

  @override
  String get areaChest => 'Chest';

  @override
  String get areaArms => 'Arms';

  @override
  String get areaWrists => 'Wrists';

  @override
  String get areaLowerBack => 'Lower back';

  @override
  String get areaCore => 'Core';

  @override
  String get areaHips => 'Hips';

  @override
  String get areaHamstrings => 'Hamstrings';

  @override
  String get areaQuads => 'Thighs';

  @override
  String get areaCalves => 'Calves';

  @override
  String get areaAnkles => 'Ankles';

  @override
  String get areaEyes => 'Eyes';

  @override
  String get areaLungs => 'Breathing';

  @override
  String get getReady => 'Get ready';

  @override
  String get upNext => 'Up next';

  @override
  String get restLabel => 'Rest';

  @override
  String get pausedLabel => 'Paused';

  @override
  String exerciseOf(int current, int total) {
    return 'Exercise $current of $total';
  }

  @override
  String get workoutComplete => 'Workout complete!';

  @override
  String get completeBody => 'Your body thanks you. Small breaks add up to big changes.';

  @override
  String get minutesLabel => 'Minutes';

  @override
  String get exercisesLabel => 'Exercises';

  @override
  String get streakLabel => 'Streak';

  @override
  String get backHome => 'Done';

  @override
  String get doAgain => 'Do it again';

  @override
  String get exitTitle => 'End workout?';

  @override
  String get exitBody => 'Your progress for this session won’t be saved.';

  @override
  String get exitConfirm => 'End';

  @override
  String get keepGoing => 'Keep going';

  @override
  String get stepsLabel => 'Steps';

  @override
  String get cueInhale => 'Breathe in';

  @override
  String get cueHold => 'Hold';

  @override
  String get cueExhale => 'Breathe out';

  @override
  String get cueRelax => 'Relax';

  @override
  String get cueLeftSide => 'Left side';

  @override
  String get cueRightSide => 'Right side';

  @override
  String get cueLook => 'Focus';

  @override
  String get cueBlink => 'Close your eyes';

  @override
  String get eyeTitle => 'Eye & posture care';

  @override
  String get eyeSubtitle => 'Protect your eyes and set up your desk right';

  @override
  String get rule20Title => '20-20-20 timer';

  @override
  String get rule20Body => 'Every 20 minutes, look 6 m (20 ft) away for 20 seconds.';

  @override
  String get startTimer => 'Start timer';

  @override
  String get stopTimer => 'Stop';

  @override
  String get nextEyeBreakIn => 'Next eye break in';

  @override
  String get eyeBreakNow => 'Eye break! Look far away';

  @override
  String get eyeBreakDone => 'Great, eyes refreshed!';

  @override
  String get keepAppOpen => 'Keep the app open while the timer runs.';

  @override
  String get eyeExercises => 'Eye exercises';

  @override
  String get ergoTitle => 'Ergonomic desk setup';

  @override
  String get ergoSubtitle => 'Small adjustments, less strain all day';

  @override
  String get ergoMonitorDistance => 'Screen 50–100 cm away – about an arm’s length';

  @override
  String get ergoMonitorHeight => 'Top of the screen at or slightly below eye level';

  @override
  String get ergoElbows => 'Elbows close to the body, bent 90–120°';

  @override
  String get ergoWrists => 'Wrists straight, roughly parallel to the floor';

  @override
  String get ergoBack => 'Back fully supported with lumbar support';

  @override
  String get ergoFeet => 'Feet flat on the floor, knees about hip height';

  @override
  String get blinkFactTitle => 'Did you know?';

  @override
  String get blinkFactBody =>
      'We normally blink about 15 times a minute, but at a screen this drops by about half. That’s why screen eyes feel dry.';

  @override
  String get eyeDisclaimer =>
      'Eye exercises are comfort routines, not medical treatment. See an eye doctor if symptoms persist.';

  @override
  String get nutritionTitle => 'Desk nutrition';

  @override
  String get nutritionSubtitle => 'Steady energy without the afternoon crash';

  @override
  String get waterTitle => 'Hydration';

  @override
  String get waterBody => 'EFSA advises about 2.0 L (women) to 2.5 L (men) of water a day from all drinks and food.';

  @override
  String get glassSize => '1 glass = 250 ml';

  @override
  String get waterGoalLabel => 'Daily goal';

  @override
  String get caffeineTitle => 'Caffeine check';

  @override
  String get caffeineBody =>
      'Up to 400 mg a day is considered safe for most healthy adults (FDA, EFSA) – roughly 4 cups of filter coffee. Keep single doses to about 200 mg.';

  @override
  String get caffeineTip => 'Avoid caffeine late in the day to protect your sleep.';

  @override
  String get snacksTitle => 'Smart desk snacks';

  @override
  String get snacksSubtitle => 'Protein + fibre keep you full and focused';

  @override
  String get snackNuts => 'Unsalted nuts';

  @override
  String get snackNutsDesc => 'A small handful – healthy fats and protein.';

  @override
  String get snackFruit => 'Whole fruit';

  @override
  String get snackFruitDesc => 'An apple or pear brings fibre and natural sweetness.';

  @override
  String get snackYogurt => 'Greek yogurt & berries';

  @override
  String get snackYogurtDesc => 'Plain yogurt with berries for protein and antioxidants.';

  @override
  String get snackVeggies => 'Veggies & hummus';

  @override
  String get snackVeggiesDesc => 'Carrot or cucumber sticks with hummus.';

  @override
  String get snackEggs => 'Boiled eggs';

  @override
  String get snackEggsDesc => 'Easy to prepare, high-quality protein.';

  @override
  String get snackChickpeas => 'Roasted chickpeas';

  @override
  String get snackChickpeasDesc => 'Crunchy fibre and plant protein.';

  @override
  String get habitsTitle => 'Healthy work habits';

  @override
  String get habit1Title => 'Drink water first';

  @override
  String get habit1Body => 'Feeling peckish? Thirst is often mistaken for hunger.';

  @override
  String get habit2Title => 'Eat away from the desk';

  @override
  String get habit2Body => 'Step away from emails and eat mindfully – it’s also a movement break.';

  @override
  String get habit3Title => 'Pre-portion snacks';

  @override
  String get habit3Body => 'Pack small portions ahead so you don’t eat straight from the bag.';

  @override
  String get habit4Title => 'Skip sugary drinks';

  @override
  String get habit4Body => 'Choose water, tea or coffee; keep juice to one small glass a day.';

  @override
  String get habit5Title => 'Protein + fibre';

  @override
  String get habit5Body => 'Combining them keeps blood sugar steady and focus sharp.';

  @override
  String get habit6Title => 'Watch the bars';

  @override
  String get habit6Body => 'Many “protein” bars are packed with sugar – read the label.';

  @override
  String get progressTitle => 'Your progress';

  @override
  String get progressSubtitle => 'Consistency beats intensity';

  @override
  String get statStreak => 'Current streak';

  @override
  String get statBest => 'Best streak';

  @override
  String get statMinutes => 'Active minutes';

  @override
  String get statSessions => 'Sessions';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count days', one: '1 day');
    return '$_temp0';
  }

  @override
  String get thisWeek => 'This week';

  @override
  String weekMinutes(int count) {
    return '$count min this week';
  }

  @override
  String get achievements => 'Achievements';

  @override
  String get badgeFirst => 'First step';

  @override
  String get badgeFirstDesc => 'Complete your first session';

  @override
  String get badgeStreak3 => 'On a roll';

  @override
  String get badgeStreak3Desc => 'Reach a 3-day streak';

  @override
  String get badgeStreak7 => 'Unstoppable';

  @override
  String get badgeStreak7Desc => 'Reach a 7-day streak';

  @override
  String get badgeSessions10 => 'Desk athlete';

  @override
  String get badgeSessions10Desc => 'Complete 10 sessions';

  @override
  String get badgeMinutes60 => 'Hour of power';

  @override
  String get badgeMinutes60Desc => 'Move for 60 minutes in total';

  @override
  String get badgeWater => 'Hydration hero';

  @override
  String get badgeWaterDesc => 'Drink 8 glasses in one day';

  @override
  String get emptyProgress => 'Finish your first routine to start your streak.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'Device language';

  @override
  String get dailyGoalLabel => 'Daily movement goal';

  @override
  String get breakReminderLabel => 'Break interval';

  @override
  String get breakReminderDesc => 'Used by the sitting timer on the Today screen.';

  @override
  String get waterGoalSetting => 'Water goal';

  @override
  String get resetProgress => 'Reset progress';

  @override
  String get resetConfirmTitle => 'Reset all progress?';

  @override
  String get resetConfirmBody => 'Streaks, minutes and water logs will be deleted.';

  @override
  String get cancel => 'Cancel';

  @override
  String get resetAction => 'Reset';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutBody =>
      'Desk Workout helps desk workers move, stretch and rest their eyes with short, guided routines. All illustrations and animations are drawn in code.';

  @override
  String get disclaimerTitle => 'Health disclaimer';

  @override
  String get disclaimerBody =>
      'This app provides general wellness information and is not medical advice. Consult a professional if you have an injury, pain or a medical condition.';

  @override
  String get sourcesTitle => 'Sources';

  @override
  String get sourcesBody =>
      'Mayo Clinic, Harvard Health, Cleveland Clinic, NHS, HSS, OSHA, American Academy of Ophthalmology, WHO, EFSA, FDA.';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get saved => 'Saved';

  @override
  String get catNeck => 'Neck';

  @override
  String get catNeckDesc => 'Release screen neck';

  @override
  String get catShoulders => 'Shoulders';

  @override
  String get catShouldersDesc => 'Open rounded shoulders';

  @override
  String get catWrists => 'Wrists & hands';

  @override
  String get catWristsDesc => 'For typing and mouse work';

  @override
  String get catBack => 'Back & spine';

  @override
  String get catBackDesc => 'Mobilise a stiff back';

  @override
  String get catLegs => 'Hips & legs';

  @override
  String get catLegsDesc => 'Wake up your circulation';

  @override
  String get catEyes => 'Eyes';

  @override
  String get catEyesDesc => 'Beat digital eye strain';

  @override
  String get catBreathing => 'Breathing';

  @override
  String get catBreathingDesc => 'Calm and refocus';

  @override
  String get rtQuickName => '2-Minute Reset';

  @override
  String get rtQuickDesc => 'The perfect micro-break between meetings.';

  @override
  String get rtNeckName => 'Neck & Shoulder Relief';

  @override
  String get rtNeckDesc => 'Melt away tension from hours of screen time.';

  @override
  String get rtWristName => 'Wrist & Hand Care';

  @override
  String get rtWristDesc => 'Protect hands that type and click all day.';

  @override
  String get rtBackName => 'Lower Back Rescue';

  @override
  String get rtBackDesc => 'Decompress the spine and loosen tight hips.';

  @override
  String get rtEyeName => 'Eye Recharge';

  @override
  String get rtEyeDesc => 'Refresh tired, dry screen eyes.';

  @override
  String get rtEnergyName => 'Energy Boost';

  @override
  String get rtEnergyDesc => 'Get your heart rate up and beat the slump.';

  @override
  String get rtPostureName => 'Posture Fix';

  @override
  String get rtPostureDesc => 'Undo the hunch and stand taller.';

  @override
  String get rtCalmName => 'Calm Down';

  @override
  String get rtCalmDesc => 'Breathing and stretching to reset stress.';

  @override
  String get rtFullName => 'Full Desk Workout';

  @override
  String get rtFullDesc => 'A complete head-to-toe session for your lunch break.';

  @override
  String doseReps(int count) {
    return '$count reps';
  }

  @override
  String doseRepsEachSide(int count) {
    return '$count reps each side';
  }

  @override
  String doseHold(int count) {
    return 'Hold $count s';
  }

  @override
  String doseHoldEachSide(int count) {
    return 'Hold $count s each side';
  }

  @override
  String doseBreaths(int count) {
    return '$count slow breaths';
  }

  @override
  String doseSeconds(int count) {
    return '$count seconds';
  }

  @override
  String doseRounds(int count) {
    return '$count rounds';
  }

  @override
  String get tip1 => 'Break up sitting every 30 minutes – even a short walk helps your blood sugar and blood pressure.';

  @override
  String get tip2 => 'WHO recommends 150–300 minutes of moderate activity per week for adults.';

  @override
  String get tip3 => 'Change your position about every 15 minutes, even just shifting how you sit.';

  @override
  String get tip4 => 'Place the top of your monitor at or slightly below eye level.';

  @override
  String get tip5 => 'Take phone calls standing up – it’s free movement.';

  @override
  String get tip6 => 'Keep a water bottle on your desk; every refill is a mini break.';

  @override
  String get tip7 => 'Use the stairs and walk to a colleague instead of messaging.';

  @override
  String get tip8 => 'Keep wrists straight while typing and let your elbows rest close to your body.';

  @override
  String get exChinTuckName => 'Chin Tuck';

  @override
  String get exChinTuckSummary => 'Undo “screen neck” by gliding your head straight back.';

  @override
  String get exChinTuckSteps =>
      'Sit tall with your feet flat and shoulders relaxed.\nKeep your eyes level and glide your chin and head straight back, making a gentle double chin.\nHold for 5 seconds, feeling a stretch at the base of the skull.\nRelease slowly and repeat.';

  @override
  String get exChinTuckTip => 'It is a small movement: don’t nod up or down.';

  @override
  String get exNeckSideTiltName => 'Neck Side Tilt';

  @override
  String get exNeckSideTiltSummary => 'Ease tension on the sides of the neck.';

  @override
  String get exNeckSideTiltSteps =>
      'Sit tall and let your shoulders drop away from your ears.\nSlowly tilt one ear toward the same-side shoulder, face looking forward.\nHold 15–30 seconds while breathing calmly.\nReturn to centre and repeat on the other side.';

  @override
  String get exNeckSideTiltTip => 'Don’t lift the shoulder to meet the ear and never bounce.';

  @override
  String get exNeckRotationName => 'Neck Rotation';

  @override
  String get exNeckRotationSummary => 'Restore the ability to look over your shoulder.';

  @override
  String get exNeckRotationSteps =>
      'Sit upright with shoulders down and look straight ahead.\nSlowly turn your head toward one shoulder as far as is comfortable, chin level.\nHold for 5 seconds.\nReturn to centre and turn to the other side.';

  @override
  String get exNeckRotationTip => 'Move slowly and keep your shoulders still.';

  @override
  String get exLevatorStretchName => 'Levator Scapulae Stretch';

  @override
  String get exLevatorStretchSummary => 'Target the stubborn knot between neck and shoulder blade.';

  @override
  String get exLevatorStretchSteps =>
      'Hold the edge of the seat with the hand of the side you want to stretch.\nTurn your head about 45° away from that side.\nLook down toward the opposite armpit.\nRest the other hand on the back of your head for light support and hold.';

  @override
  String get exLevatorStretchTip => 'Let the hand only rest on your head – don’t pull.';

  @override
  String get exUpperTrapStretchName => 'Upper Trapezius Stretch';

  @override
  String get exUpperTrapStretchSummary => 'Release the muscles that hold stress on your shoulders.';

  @override
  String get exUpperTrapStretchSteps =>
      'Hold the seat with the hand of the side to stretch to keep that shoulder down.\nTilt your ear toward the opposite shoulder, face forward.\nPlace the opposite hand on top of your head for gentle overpressure.\nHold 10–30 seconds and switch sides.';

  @override
  String get exUpperTrapStretchTip => 'Stop if you feel pain, tingling or numbness.';

  @override
  String get exShoulderShrugsName => 'Shoulder Shrugs';

  @override
  String get exShoulderShrugsSummary => 'Wake up tired upper shoulders in seconds.';

  @override
  String get exShoulderShrugsSteps =>
      'Sit tall with your arms hanging relaxed.\nLift both shoulders straight up toward your ears.\nPause for 1–2 seconds at the top.\nLet them drop fully and relax.';

  @override
  String get exShoulderShrugsTip => 'Lift straight up without rolling and keep your neck long.';

  @override
  String get exShoulderRollsName => 'Shoulder Rolls';

  @override
  String get exShoulderRollsSummary => 'Big, slow circles that loosen the whole shoulder girdle.';

  @override
  String get exShoulderRollsSteps =>
      'Sit tall with your arms relaxed.\nDraw large circles with your shoulders: up, back, down and forward.\nMake each circle slow and smooth.\nAfter half the reps, reverse the direction.';

  @override
  String get exShoulderRollsTip => 'Keep your head still and let only the shoulders move.';

  @override
  String get exScapularSqueezeName => 'Shoulder Blade Squeeze';

  @override
  String get exScapularSqueezeSummary => 'Counter rounded shoulders and activate your upper back.';

  @override
  String get exScapularSqueezeSteps =>
      'Sit upright, away from the backrest, elbows bent at your sides.\nDraw your shoulder blades back and together, slightly down.\nHold for 3–5 seconds with your chest open.\nRelease slowly.';

  @override
  String get exScapularSqueezeTip => 'Don’t shrug or arch your lower back.';

  @override
  String get exCrossBodyStretchName => 'Cross-Body Shoulder Stretch';

  @override
  String get exCrossBodyStretchSummary => 'Stretch the back of the shoulder after long mouse work.';

  @override
  String get exCrossBodyStretchSteps =>
      'Sit straight with your shoulders down.\nBring one straight arm across your chest at shoulder height.\nCup the elbow with your other hand and gently pull it toward you.\nHold 10–30 seconds and switch arms.';

  @override
  String get exCrossBodyStretchTip => 'Keep your torso facing forward – don’t rotate with the arm.';

  @override
  String get exTricepsStretchName => 'Overhead Triceps Stretch';

  @override
  String get exTricepsStretchSummary => 'Open the back of the arm and the side of the chest.';

  @override
  String get exTricepsStretchSteps =>
      'Raise one arm and bend the elbow so the hand drops behind your head.\nPoint the elbow to the ceiling, palm toward your upper back.\nWith the other hand, gently press the elbow back.\nHold about 20 seconds per arm.';

  @override
  String get exTricepsStretchTip => 'Keep your head upright; don’t push it forward.';

  @override
  String get exChestOpenerName => 'Seated Chest Opener';

  @override
  String get exChestOpenerSummary => 'Reverse the hunch: open the chest and front shoulders.';

  @override
  String get exChestOpenerSteps =>
      'Sit near the front of the seat and roll your shoulders down and back.\nInterlace your fingers behind you, palms facing your body.\nStraighten your arms and lift your hands gently until you feel a stretch.\nHold 10–30 seconds while breathing deeply.';

  @override
  String get exChestOpenerTip => 'Can’t clasp your hands? Hold your forearms or elbows instead.';

  @override
  String get exThoracicExtensionName => 'Thoracic Extension';

  @override
  String get exThoracicExtensionSummary => 'Bend the stiff upper back the other way over your backrest.';

  @override
  String get exThoracicExtensionSteps =>
      'Sit with feet flat and your mid-back against the top of the backrest.\nSupport your neck with your hands, elbows forward.\nLean back over the backrest, lifting your chest and looking up.\nHold 3–5 seconds and come back up slowly.';

  @override
  String get exThoracicExtensionTip => 'Move from the upper back, not the neck. Use a stable chair.';

  @override
  String get exOverheadSideBendName => 'Overhead Side Bend';

  @override
  String get exOverheadSideBendSummary => 'Lengthen the sides of your trunk and breathe deeper.';

  @override
  String get exOverheadSideBendSteps =>
      'Sit tall with both hips grounded on the seat.\nRaise your arms overhead and clasp your hands.\nBend slowly to one side from the waist.\nReturn to centre and bend to the other side.';

  @override
  String get exOverheadSideBendTip => 'Stay in one plane: don’t lean forward and keep both hips on the chair.';

  @override
  String get exSpinalTwistName => 'Seated Spinal Twist';

  @override
  String get exSpinalTwistSummary => 'Mobilise the spine and relieve a stiff back.';

  @override
  String get exSpinalTwistSteps =>
      'Sit upright, feet flat, arms crossed over your chest.\nKeep hips and knees facing forward.\nTurn your upper body to one side and hold for 5 seconds.\nReturn to centre and turn the other way.';

  @override
  String get exSpinalTwistTip => 'Grow tall before you twist and never force the end range.';

  @override
  String get exCatCowName => 'Seated Cat-Cow';

  @override
  String get exCatCowSummary => 'A flowing spine wave synced with your breath.';

  @override
  String get exCatCowSteps =>
      'Sit tall, feet flat, hands on your thighs.\nInhale (cow): arch your back, lift your chest and draw your shoulder blades together.\nExhale (cat): round your back, tuck your pelvis and bring your chin toward your chest.\nFlow slowly between the two.';

  @override
  String get exCatCowTip => 'Don’t jut your chin forward or drop your head back.';

  @override
  String get exForwardFoldName => 'Seated Forward Fold';

  @override
  String get exForwardFoldSummary => 'Let your back decompress and your mind slow down.';

  @override
  String get exForwardFoldSteps =>
      'Sit tall with your feet flat and apart.\nExhale and fold forward, resting your forearms on your thighs.\nLet your head, neck and spine form one long line.\nBreathe slowly, then roll up gradually.';

  @override
  String get exForwardFoldTip => 'Come up slowly – you may feel light-headed.';

  @override
  String get exWristFlexorStretchName => 'Wrist Flexor Stretch';

  @override
  String get exWristFlexorStretchSummary => 'Relieve forearms that type and click all day.';

  @override
  String get exWristFlexorStretchSteps =>
      'Extend one arm straight in front, palm facing up.\nWith the other hand, gently pull the fingers down toward the floor.\nKeep the elbow straight and hold 15–30 seconds.\nSwitch hands.';

  @override
  String get exWristFlexorStretchTip => 'Pull gently – you should feel a stretch, never pain.';

  @override
  String get exWristExtensorStretchName => 'Wrist Extensor Stretch';

  @override
  String get exWristExtensorStretchSummary => 'Stretch the top of the forearm, a classic mouse-arm fix.';

  @override
  String get exWristExtensorStretchSteps =>
      'Extend one arm straight in front, palm facing down.\nBend the wrist so the fingers point to the floor.\nWith the other hand, gently press the back of the hand toward you.\nHold 15–30 seconds and switch.';

  @override
  String get exWristExtensorStretchTip => 'Keep the elbow straight to feel it along the forearm.';

  @override
  String get exWristCirclesName => 'Wrist Circles';

  @override
  String get exWristCirclesSummary => 'Warm up stiff wrists before and after typing.';

  @override
  String get exWristCirclesSteps =>
      'Extend both arms in front and make loose fists.\nKeep your forearms still.\nSlowly circle your wrists outward.\nAfter half the reps, circle inward.';

  @override
  String get exWristCirclesTip => 'Only the hands move – keep the movement smooth.';

  @override
  String get exPrayerStretchName => 'Prayer Stretch';

  @override
  String get exPrayerStretchSummary => 'A gentle stretch for the palms and inner forearms.';

  @override
  String get exPrayerStretchSteps =>
      'Press your palms together in front of your chest, fingers up.\nKeep the palms together and slowly lower your hands toward your waist.\nLet your elbows spread out to the sides.\nHold 15–30 seconds with a mild stretch.';

  @override
  String get exPrayerStretchTip => 'Aim for mild tension, never pain.';

  @override
  String get exFigureFourName => 'Seated Figure-4 Stretch';

  @override
  String get exFigureFourSummary => 'Release tight hips and glutes from long sitting.';

  @override
  String get exFigureFourSteps =>
      'Sit tall near the front edge, both feet flat.\nPlace one ankle on the opposite knee.\nKeep your back flat and hinge slightly forward until you feel the outer hip.\nHold 30–45 seconds and switch legs.';

  @override
  String get exFigureFourTip => 'If your knee complains, just hold the crossed position without leaning.';

  @override
  String get exLegExtensionName => 'Seated Leg Extension';

  @override
  String get exLegExtensionSummary => 'Fire up your thighs without leaving the chair.';

  @override
  String get exLegExtensionSteps =>
      'Sit tall with your thighs parallel to the floor.\nSlowly straighten one knee, toes pulled toward you.\nPause at the top, then lower with control.\nComplete the reps and switch legs.';

  @override
  String get exLegExtensionTip => 'Don’t lock the knee at the top.';

  @override
  String get exHamstringStretchName => 'Seated Hamstring Stretch';

  @override
  String get exHamstringStretchSummary => 'Lengthen the back of the thighs that shorten when sitting.';

  @override
  String get exHamstringStretchSteps =>
      'Sit at the front edge of the chair.\nStraighten one leg with the heel on the floor and toes up.\nKeep your back straight and hinge forward from the hips.\nHold 30–45 seconds and switch legs.';

  @override
  String get exHamstringStretchTip => 'Hinge from the hips – don’t round your back.';

  @override
  String get exAnklePumpsName => 'Ankle Pumps';

  @override
  String get exAnklePumpsSummary => 'Help your calves pump blood back up your legs.';

  @override
  String get exAnklePumpsSteps =>
      'Sit tall and lift one foot slightly off the floor.\nPoint your toes away from you.\nThen pull your toes back toward you.\nRepeat smoothly and switch feet.';

  @override
  String get exAnklePumpsTip => 'Only the foot moves – keep the shin still.';

  @override
  String get exSeatedMarchingName => 'Seated Marching';

  @override
  String get exSeatedMarchingSummary => 'A quick cardio boost to beat the afternoon slump.';

  @override
  String get exSeatedMarchingSteps =>
      'Sit upright without leaning on the backrest.\nHold the sides of the chair.\nLift one bent knee as high as is comfortable, then lower it with control.\nAlternate legs at a steady rhythm.';

  @override
  String get exSeatedMarchingTip => 'Don’t lean back as you lift.';

  @override
  String get exCalfRaisesName => 'Standing Calf Raises';

  @override
  String get exCalfRaisesSummary => 'Strengthen calves and boost circulation.';

  @override
  String get exCalfRaisesSteps =>
      'Stand facing your desk and rest your hands lightly on it.\nRise slowly onto the balls of your feet.\nPause briefly at the top.\nLower your heels with control.';

  @override
  String get exCalfRaisesTip => 'For more challenge, do it without hand support.';

  @override
  String get exHipFlexorStretchName => 'Standing Hip Flexor Stretch';

  @override
  String get exHipFlexorStretchSummary => 'Open the front of the hips that tighten from sitting.';

  @override
  String get exHipFlexorStretchSteps =>
      'Stand in a split stance, the leg to stretch a stride behind.\nSlightly bend the front knee and keep your back straight.\nTuck your tailbone under and gently push the back hip forward.\nHold 20–30 seconds and switch sides.';

  @override
  String get exHipFlexorStretchTip => 'Hold your desk for balance and don’t arch your lower back.';

  @override
  String get exChairSquatName => 'Chair Sit-to-Stand';

  @override
  String get exChairSquatSummary => 'The most practical leg exercise for desk workers.';

  @override
  String get exChairSquatSteps =>
      'Sit at the edge of a stable chair, feet hip-width apart.\nCross your arms over your chest and lean slightly forward.\nStand up using your legs, looking forward.\nSit back down slowly and with control.';

  @override
  String get exChairSquatTip => 'Use a chair without wheels or lock it against a wall.';

  @override
  String get exDeskPushUpName => 'Desk Push-Up';

  @override
  String get exDeskPushUpSummary => 'Strengthen chest, shoulders and arms using your desk.';

  @override
  String get exDeskPushUpSteps =>
      'Place your hands shoulder-width apart on the edge of a stable desk.\nWalk your feet back until your body forms a straight line.\nBend your elbows and lower your chest toward the desk.\nPress back up to straight arms.';

  @override
  String get exDeskPushUpTip => 'Keep your core tight and make sure the desk can’t slide.';

  @override
  String get exRule202020Name => '20-20-20 Eye Break';

  @override
  String get exRule202020Summary => 'The ophthalmologists’ rule for tired screen eyes.';

  @override
  String get exRule202020Steps =>
      'Every 20 minutes, look away from your screen.\nFocus on something about 6 metres (20 feet) away.\nKeep looking for at least 20 seconds.\nBlink fully a few times before returning to work.';

  @override
  String get exRule202020Tip => 'A window view is perfect – distant focus relaxes the eye muscles.';

  @override
  String get exNearFarFocusName => 'Near–Far Focus';

  @override
  String get exNearFarFocusSummary => 'Train your eyes to switch focus smoothly.';

  @override
  String get exNearFarFocusSteps =>
      'Hold your thumb about 25 cm in front of your face.\nFocus on it for a few seconds.\nThen shift your focus to an object far away.\nKeep switching slowly between near and far.';

  @override
  String get exNearFarFocusTip => 'Keep your head still and breathe normally.';

  @override
  String get exEyeMovementsName => 'Eye Movements';

  @override
  String get exEyeMovementsSummary => 'A gentle comfort routine for stiff, tired eyes.';

  @override
  String get exEyeMovementsSteps =>
      'Sit comfortably and keep your head still.\nSlowly look up, then down.\nSlowly look left, then right.\nClose your eyes and relax for a moment.';

  @override
  String get exEyeMovementsTip => 'This is a comfort routine, not a treatment. Stop if it causes discomfort.';

  @override
  String get exPalmingName => 'Palming';

  @override
  String get exPalmingSummary => 'Warm darkness to rest the eyes completely.';

  @override
  String get exPalmingSteps =>
      'Rub your hands together to warm them.\nClose your eyes.\nCup your palms gently over your eyes without pressing.\nBreathe slowly for 20–30 seconds.';

  @override
  String get exPalmingTip => 'No pressure on the eyeballs – the palms only rest on the cheekbones.';

  @override
  String get exBlinkingName => 'Conscious Blinking';

  @override
  String get exBlinkingSummary => 'Restore the tear film that screens dry out.';

  @override
  String get exBlinkingSteps =>
      'Close your eyes gently for 2 seconds.\nOpen them.\nClose again for 2 seconds.\nThen squeeze gently for 2 seconds and open.';

  @override
  String get exBlinkingTip => 'At screens we blink about half as often – repeat this every 20 minutes.';

  @override
  String get exBoxBreathingName => 'Box Breathing';

  @override
  String get exBoxBreathingSummary => 'Four equal sides to calm a busy mind.';

  @override
  String get exBoxBreathingSteps =>
      'Exhale completely.\nBreathe in through your nose for 4 seconds.\nHold for 4 seconds.\nBreathe out for 4 seconds, then hold for 4 seconds.';

  @override
  String get exBoxBreathingTip => 'Shorten the counts if you feel any strain.';

  @override
  String get exBellyBreathingName => 'Belly Breathing';

  @override
  String get exBellyBreathingSummary => 'Diaphragmatic breathing to release shoulder tension.';

  @override
  String get exBellyBreathingSteps =>
      'Sit with your shoulders relaxed.\nPlace one hand on your chest and one just below your ribs.\nBreathe in through your nose so the belly pushes your lower hand out.\nBreathe out slowly through pursed lips.';

  @override
  String get exBellyBreathingTip => 'Only the lower hand should move; the chest stays quiet.';
}
