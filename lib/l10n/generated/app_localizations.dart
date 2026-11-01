import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('tr')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Desk Workout'**
  String get appName;

  /// No description provided for @languageNativeName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageNativeName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Move better at your desk'**
  String get appTagline;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Stretch · Breathe · Focus'**
  String get splashTagline;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navExercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get navExercises;

  /// No description provided for @navEyes.
  ///
  /// In en, this message translates to:
  /// **'Eyes'**
  String get navEyes;

  /// No description provided for @navNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get navNutrition;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @onbSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onbSkip;

  /// No description provided for @onbNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onbNext;

  /// No description provided for @onbStart.
  ///
  /// In en, this message translates to:
  /// **'Let’s start'**
  String get onbStart;

  /// No description provided for @onb1Title.
  ///
  /// In en, this message translates to:
  /// **'Your desk,\nyour gym'**
  String get onb1Title;

  /// No description provided for @onb1Body.
  ///
  /// In en, this message translates to:
  /// **'Short, science-backed routines designed only for people who sit at a desk all day.'**
  String get onb1Body;

  /// No description provided for @onb2Title.
  ///
  /// In en, this message translates to:
  /// **'Fix the\nscreen posture'**
  String get onb2Title;

  /// No description provided for @onb2Body.
  ///
  /// In en, this message translates to:
  /// **'Neck, shoulders, wrists and back: every move is animated step by step so you do it right.'**
  String get onb2Body;

  /// No description provided for @onb3Title.
  ///
  /// In en, this message translates to:
  /// **'Rest your\neyes'**
  String get onb3Title;

  /// No description provided for @onb3Body.
  ///
  /// In en, this message translates to:
  /// **'The 20-20-20 rule, blinking and focus drills protect your eyes from digital strain.'**
  String get onb3Body;

  /// No description provided for @onb4Title.
  ///
  /// In en, this message translates to:
  /// **'Fuel the\nworkday'**
  String get onb4Title;

  /// No description provided for @onb4Body.
  ///
  /// In en, this message translates to:
  /// **'Track water, keep caffeine in check and pick smart desk snacks.'**
  String get onb4Body;

  /// No description provided for @onbSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Make it yours'**
  String get onbSetupTitle;

  /// No description provided for @onbSetupBody.
  ///
  /// In en, this message translates to:
  /// **'You can change these anytime in settings.'**
  String get onbSetupBody;

  /// No description provided for @onbGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily movement goal'**
  String get onbGoalLabel;

  /// No description provided for @onbBreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Remind me to move'**
  String get onbBreakLabel;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String minutesShort(int count);

  /// No description provided for @everyMinutes.
  ///
  /// In en, this message translates to:
  /// **'Every {count} min'**
  String everyMinutes(int count);

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ready for a quick reset?'**
  String get homeSubtitle;

  /// No description provided for @todayGoal.
  ///
  /// In en, this message translates to:
  /// **'Today’s goal'**
  String get todayGoal;

  /// No description provided for @minutesOfGoal.
  ///
  /// In en, this message translates to:
  /// **'{done} of {goal} min'**
  String minutesOfGoal(int done, int goal);

  /// No description provided for @goalReached.
  ///
  /// In en, this message translates to:
  /// **'Goal reached! 🎉'**
  String get goalReached;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No streak yet} =1{1 day streak} other{{count} day streak}}'**
  String streakDays(int count);

  /// No description provided for @sittingFor.
  ///
  /// In en, this message translates to:
  /// **'Sitting for {time}'**
  String sittingFor(String time);

  /// No description provided for @timeToMove.
  ///
  /// In en, this message translates to:
  /// **'Time to move! Take a 2-minute break.'**
  String get timeToMove;

  /// No description provided for @sittingOk.
  ///
  /// In en, this message translates to:
  /// **'Next break suggested in {time}'**
  String sittingOk(String time);

  /// No description provided for @tookBreak.
  ///
  /// In en, this message translates to:
  /// **'I took a break'**
  String get tookBreak;

  /// No description provided for @quickBreak.
  ///
  /// In en, this message translates to:
  /// **'2-minute reset'**
  String get quickBreak;

  /// No description provided for @quickBreakDesc.
  ///
  /// In en, this message translates to:
  /// **'Neck, shoulders, wrists and back in one quick flow.'**
  String get quickBreakDesc;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get startNow;

  /// No description provided for @programs.
  ///
  /// In en, this message translates to:
  /// **'Programs'**
  String get programs;

  /// No description provided for @programsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Guided routines for every desk problem'**
  String get programsSubtitle;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @tipOfDay.
  ///
  /// In en, this message translates to:
  /// **'Tip of the day'**
  String get tipOfDay;

  /// No description provided for @waterToday.
  ///
  /// In en, this message translates to:
  /// **'Water today'**
  String get waterToday;

  /// No description provided for @glassesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 glass} other{{count} glasses}}'**
  String glassesCount(int count);

  /// No description provided for @glassesOfGoal.
  ///
  /// In en, this message translates to:
  /// **'{count} / {goal} glasses'**
  String glassesOfGoal(int count, int goal);

  /// No description provided for @bodyAreasTitle.
  ///
  /// In en, this message translates to:
  /// **'Target an area'**
  String get bodyAreasTitle;

  /// No description provided for @hoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{h} h {m} min'**
  String hoursMinutes(int h, int m);

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise library'**
  String get libraryTitle;

  /// No description provided for @librarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every movement verified against medical sources'**
  String get librarySubtitle;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @exercisesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 exercise} other{{count} exercises}}'**
  String exercisesCount(int count);

  /// No description provided for @secondsShort.
  ///
  /// In en, this message translates to:
  /// **'{count} s'**
  String secondsShort(int count);

  /// No description provided for @howTo.
  ///
  /// In en, this message translates to:
  /// **'How to do it'**
  String get howTo;

  /// No description provided for @proTip.
  ///
  /// In en, this message translates to:
  /// **'Pro tip'**
  String get proTip;

  /// No description provided for @targetAreas.
  ///
  /// In en, this message translates to:
  /// **'Target areas'**
  String get targetAreas;

  /// No description provided for @startExercise.
  ///
  /// In en, this message translates to:
  /// **'Start exercise'**
  String get startExercise;

  /// No description provided for @sourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get sourceLabel;

  /// No description provided for @standingLabel.
  ///
  /// In en, this message translates to:
  /// **'Standing'**
  String get standingLabel;

  /// No description provided for @seatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Seated'**
  String get seatedLabel;

  /// No description provided for @safetyNote.
  ///
  /// In en, this message translates to:
  /// **'Move gently and stay pain-free. Stop if anything hurts and talk to a health professional if pain persists.'**
  String get safetyNote;

  /// No description provided for @routineStart.
  ///
  /// In en, this message translates to:
  /// **'Start program'**
  String get routineStart;

  /// No description provided for @routineIncludes.
  ///
  /// In en, this message translates to:
  /// **'What’s inside'**
  String get routineIncludes;

  /// No description provided for @areaNeck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get areaNeck;

  /// No description provided for @areaShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get areaShoulders;

  /// No description provided for @areaUpperBack.
  ///
  /// In en, this message translates to:
  /// **'Upper back'**
  String get areaUpperBack;

  /// No description provided for @areaChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get areaChest;

  /// No description provided for @areaArms.
  ///
  /// In en, this message translates to:
  /// **'Arms'**
  String get areaArms;

  /// No description provided for @areaWrists.
  ///
  /// In en, this message translates to:
  /// **'Wrists'**
  String get areaWrists;

  /// No description provided for @areaLowerBack.
  ///
  /// In en, this message translates to:
  /// **'Lower back'**
  String get areaLowerBack;

  /// No description provided for @areaCore.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get areaCore;

  /// No description provided for @areaHips.
  ///
  /// In en, this message translates to:
  /// **'Hips'**
  String get areaHips;

  /// No description provided for @areaHamstrings.
  ///
  /// In en, this message translates to:
  /// **'Hamstrings'**
  String get areaHamstrings;

  /// No description provided for @areaQuads.
  ///
  /// In en, this message translates to:
  /// **'Thighs'**
  String get areaQuads;

  /// No description provided for @areaCalves.
  ///
  /// In en, this message translates to:
  /// **'Calves'**
  String get areaCalves;

  /// No description provided for @areaAnkles.
  ///
  /// In en, this message translates to:
  /// **'Ankles'**
  String get areaAnkles;

  /// No description provided for @areaEyes.
  ///
  /// In en, this message translates to:
  /// **'Eyes'**
  String get areaEyes;

  /// No description provided for @areaLungs.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get areaLungs;

  /// No description provided for @getReady.
  ///
  /// In en, this message translates to:
  /// **'Get ready'**
  String get getReady;

  /// No description provided for @upNext.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get upNext;

  /// No description provided for @restLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get restLabel;

  /// No description provided for @pausedLabel.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get pausedLabel;

  /// No description provided for @exerciseOf.
  ///
  /// In en, this message translates to:
  /// **'Exercise {current} of {total}'**
  String exerciseOf(int current, int total);

  /// No description provided for @workoutComplete.
  ///
  /// In en, this message translates to:
  /// **'Workout complete!'**
  String get workoutComplete;

  /// No description provided for @completeBody.
  ///
  /// In en, this message translates to:
  /// **'Your body thanks you. Small breaks add up to big changes.'**
  String get completeBody;

  /// No description provided for @minutesLabel.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutesLabel;

  /// No description provided for @exercisesLabel.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercisesLabel;

  /// No description provided for @streakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streakLabel;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get backHome;

  /// No description provided for @doAgain.
  ///
  /// In en, this message translates to:
  /// **'Do it again'**
  String get doAgain;

  /// No description provided for @exitTitle.
  ///
  /// In en, this message translates to:
  /// **'End workout?'**
  String get exitTitle;

  /// No description provided for @exitBody.
  ///
  /// In en, this message translates to:
  /// **'Your progress for this session won’t be saved.'**
  String get exitBody;

  /// No description provided for @exitConfirm.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get exitConfirm;

  /// No description provided for @keepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get keepGoing;

  /// No description provided for @stepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get stepsLabel;

  /// No description provided for @cueInhale.
  ///
  /// In en, this message translates to:
  /// **'Breathe in'**
  String get cueInhale;

  /// No description provided for @cueHold.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get cueHold;

  /// No description provided for @cueExhale.
  ///
  /// In en, this message translates to:
  /// **'Breathe out'**
  String get cueExhale;

  /// No description provided for @cueRelax.
  ///
  /// In en, this message translates to:
  /// **'Relax'**
  String get cueRelax;

  /// No description provided for @cueLeftSide.
  ///
  /// In en, this message translates to:
  /// **'Left side'**
  String get cueLeftSide;

  /// No description provided for @cueRightSide.
  ///
  /// In en, this message translates to:
  /// **'Right side'**
  String get cueRightSide;

  /// No description provided for @cueLook.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get cueLook;

  /// No description provided for @cueBlink.
  ///
  /// In en, this message translates to:
  /// **'Close your eyes'**
  String get cueBlink;

  /// No description provided for @eyeTitle.
  ///
  /// In en, this message translates to:
  /// **'Eye & posture care'**
  String get eyeTitle;

  /// No description provided for @eyeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Protect your eyes and set up your desk right'**
  String get eyeSubtitle;

  /// No description provided for @rule20Title.
  ///
  /// In en, this message translates to:
  /// **'20-20-20 timer'**
  String get rule20Title;

  /// No description provided for @rule20Body.
  ///
  /// In en, this message translates to:
  /// **'Every 20 minutes, look 6 m (20 ft) away for 20 seconds.'**
  String get rule20Body;

  /// No description provided for @startTimer.
  ///
  /// In en, this message translates to:
  /// **'Start timer'**
  String get startTimer;

  /// No description provided for @stopTimer.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopTimer;

  /// No description provided for @nextEyeBreakIn.
  ///
  /// In en, this message translates to:
  /// **'Next eye break in'**
  String get nextEyeBreakIn;

  /// No description provided for @eyeBreakNow.
  ///
  /// In en, this message translates to:
  /// **'Eye break! Look far away'**
  String get eyeBreakNow;

  /// No description provided for @eyeBreakDone.
  ///
  /// In en, this message translates to:
  /// **'Great, eyes refreshed!'**
  String get eyeBreakDone;

  /// No description provided for @keepAppOpen.
  ///
  /// In en, this message translates to:
  /// **'Keep the app open while the timer runs.'**
  String get keepAppOpen;

  /// No description provided for @eyeExercises.
  ///
  /// In en, this message translates to:
  /// **'Eye exercises'**
  String get eyeExercises;

  /// No description provided for @ergoTitle.
  ///
  /// In en, this message translates to:
  /// **'Ergonomic desk setup'**
  String get ergoTitle;

  /// No description provided for @ergoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Small adjustments, less strain all day'**
  String get ergoSubtitle;

  /// No description provided for @ergoMonitorDistance.
  ///
  /// In en, this message translates to:
  /// **'Screen 50–100 cm away – about an arm’s length'**
  String get ergoMonitorDistance;

  /// No description provided for @ergoMonitorHeight.
  ///
  /// In en, this message translates to:
  /// **'Top of the screen at or slightly below eye level'**
  String get ergoMonitorHeight;

  /// No description provided for @ergoElbows.
  ///
  /// In en, this message translates to:
  /// **'Elbows close to the body, bent 90–120°'**
  String get ergoElbows;

  /// No description provided for @ergoWrists.
  ///
  /// In en, this message translates to:
  /// **'Wrists straight, roughly parallel to the floor'**
  String get ergoWrists;

  /// No description provided for @ergoBack.
  ///
  /// In en, this message translates to:
  /// **'Back fully supported with lumbar support'**
  String get ergoBack;

  /// No description provided for @ergoFeet.
  ///
  /// In en, this message translates to:
  /// **'Feet flat on the floor, knees about hip height'**
  String get ergoFeet;

  /// No description provided for @blinkFactTitle.
  ///
  /// In en, this message translates to:
  /// **'Did you know?'**
  String get blinkFactTitle;

  /// No description provided for @blinkFactBody.
  ///
  /// In en, this message translates to:
  /// **'We normally blink about 15 times a minute, but at a screen this drops by about half. That’s why screen eyes feel dry.'**
  String get blinkFactBody;

  /// No description provided for @eyeDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Eye exercises are comfort routines, not medical treatment. See an eye doctor if symptoms persist.'**
  String get eyeDisclaimer;

  /// No description provided for @nutritionTitle.
  ///
  /// In en, this message translates to:
  /// **'Desk nutrition'**
  String get nutritionTitle;

  /// No description provided for @nutritionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Steady energy without the afternoon crash'**
  String get nutritionSubtitle;

  /// No description provided for @waterTitle.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get waterTitle;

  /// No description provided for @waterBody.
  ///
  /// In en, this message translates to:
  /// **'EFSA advises about 2.0 L (women) to 2.5 L (men) of water a day from all drinks and food.'**
  String get waterBody;

  /// No description provided for @glassSize.
  ///
  /// In en, this message translates to:
  /// **'1 glass = 250 ml'**
  String get glassSize;

  /// No description provided for @waterGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get waterGoalLabel;

  /// No description provided for @caffeineTitle.
  ///
  /// In en, this message translates to:
  /// **'Caffeine check'**
  String get caffeineTitle;

  /// No description provided for @caffeineBody.
  ///
  /// In en, this message translates to:
  /// **'Up to 400 mg a day is considered safe for most healthy adults (FDA, EFSA) – roughly 4 cups of filter coffee. Keep single doses to about 200 mg.'**
  String get caffeineBody;

  /// No description provided for @caffeineTip.
  ///
  /// In en, this message translates to:
  /// **'Avoid caffeine late in the day to protect your sleep.'**
  String get caffeineTip;

  /// No description provided for @snacksTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart desk snacks'**
  String get snacksTitle;

  /// No description provided for @snacksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Protein + fibre keep you full and focused'**
  String get snacksSubtitle;

  /// No description provided for @snackNuts.
  ///
  /// In en, this message translates to:
  /// **'Unsalted nuts'**
  String get snackNuts;

  /// No description provided for @snackNutsDesc.
  ///
  /// In en, this message translates to:
  /// **'A small handful – healthy fats and protein.'**
  String get snackNutsDesc;

  /// No description provided for @snackFruit.
  ///
  /// In en, this message translates to:
  /// **'Whole fruit'**
  String get snackFruit;

  /// No description provided for @snackFruitDesc.
  ///
  /// In en, this message translates to:
  /// **'An apple or pear brings fibre and natural sweetness.'**
  String get snackFruitDesc;

  /// No description provided for @snackYogurt.
  ///
  /// In en, this message translates to:
  /// **'Greek yogurt & berries'**
  String get snackYogurt;

  /// No description provided for @snackYogurtDesc.
  ///
  /// In en, this message translates to:
  /// **'Plain yogurt with berries for protein and antioxidants.'**
  String get snackYogurtDesc;

  /// No description provided for @snackVeggies.
  ///
  /// In en, this message translates to:
  /// **'Veggies & hummus'**
  String get snackVeggies;

  /// No description provided for @snackVeggiesDesc.
  ///
  /// In en, this message translates to:
  /// **'Carrot or cucumber sticks with hummus.'**
  String get snackVeggiesDesc;

  /// No description provided for @snackEggs.
  ///
  /// In en, this message translates to:
  /// **'Boiled eggs'**
  String get snackEggs;

  /// No description provided for @snackEggsDesc.
  ///
  /// In en, this message translates to:
  /// **'Easy to prepare, high-quality protein.'**
  String get snackEggsDesc;

  /// No description provided for @snackChickpeas.
  ///
  /// In en, this message translates to:
  /// **'Roasted chickpeas'**
  String get snackChickpeas;

  /// No description provided for @snackChickpeasDesc.
  ///
  /// In en, this message translates to:
  /// **'Crunchy fibre and plant protein.'**
  String get snackChickpeasDesc;

  /// No description provided for @habitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Healthy work habits'**
  String get habitsTitle;

  /// No description provided for @habit1Title.
  ///
  /// In en, this message translates to:
  /// **'Drink water first'**
  String get habit1Title;

  /// No description provided for @habit1Body.
  ///
  /// In en, this message translates to:
  /// **'Feeling peckish? Thirst is often mistaken for hunger.'**
  String get habit1Body;

  /// No description provided for @habit2Title.
  ///
  /// In en, this message translates to:
  /// **'Eat away from the desk'**
  String get habit2Title;

  /// No description provided for @habit2Body.
  ///
  /// In en, this message translates to:
  /// **'Step away from emails and eat mindfully – it’s also a movement break.'**
  String get habit2Body;

  /// No description provided for @habit3Title.
  ///
  /// In en, this message translates to:
  /// **'Pre-portion snacks'**
  String get habit3Title;

  /// No description provided for @habit3Body.
  ///
  /// In en, this message translates to:
  /// **'Pack small portions ahead so you don’t eat straight from the bag.'**
  String get habit3Body;

  /// No description provided for @habit4Title.
  ///
  /// In en, this message translates to:
  /// **'Skip sugary drinks'**
  String get habit4Title;

  /// No description provided for @habit4Body.
  ///
  /// In en, this message translates to:
  /// **'Choose water, tea or coffee; keep juice to one small glass a day.'**
  String get habit4Body;

  /// No description provided for @habit5Title.
  ///
  /// In en, this message translates to:
  /// **'Protein + fibre'**
  String get habit5Title;

  /// No description provided for @habit5Body.
  ///
  /// In en, this message translates to:
  /// **'Combining them keeps blood sugar steady and focus sharp.'**
  String get habit5Body;

  /// No description provided for @habit6Title.
  ///
  /// In en, this message translates to:
  /// **'Watch the bars'**
  String get habit6Title;

  /// No description provided for @habit6Body.
  ///
  /// In en, this message translates to:
  /// **'Many “protein” bars are packed with sugar – read the label.'**
  String get habit6Body;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get progressTitle;

  /// No description provided for @progressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Consistency beats intensity'**
  String get progressSubtitle;

  /// No description provided for @statStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get statStreak;

  /// No description provided for @statBest.
  ///
  /// In en, this message translates to:
  /// **'Best streak'**
  String get statBest;

  /// No description provided for @statMinutes.
  ///
  /// In en, this message translates to:
  /// **'Active minutes'**
  String get statMinutes;

  /// No description provided for @statSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get statSessions;

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String daysCount(int count);

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// No description provided for @weekMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count} min this week'**
  String weekMinutes(int count);

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @badgeFirst.
  ///
  /// In en, this message translates to:
  /// **'First step'**
  String get badgeFirst;

  /// No description provided for @badgeFirstDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first session'**
  String get badgeFirstDesc;

  /// No description provided for @badgeStreak3.
  ///
  /// In en, this message translates to:
  /// **'On a roll'**
  String get badgeStreak3;

  /// No description provided for @badgeStreak3Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a 3-day streak'**
  String get badgeStreak3Desc;

  /// No description provided for @badgeStreak7.
  ///
  /// In en, this message translates to:
  /// **'Unstoppable'**
  String get badgeStreak7;

  /// No description provided for @badgeStreak7Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a 7-day streak'**
  String get badgeStreak7Desc;

  /// No description provided for @badgeSessions10.
  ///
  /// In en, this message translates to:
  /// **'Desk athlete'**
  String get badgeSessions10;

  /// No description provided for @badgeSessions10Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 10 sessions'**
  String get badgeSessions10Desc;

  /// No description provided for @badgeMinutes60.
  ///
  /// In en, this message translates to:
  /// **'Hour of power'**
  String get badgeMinutes60;

  /// No description provided for @badgeMinutes60Desc.
  ///
  /// In en, this message translates to:
  /// **'Move for 60 minutes in total'**
  String get badgeMinutes60Desc;

  /// No description provided for @badgeWater.
  ///
  /// In en, this message translates to:
  /// **'Hydration hero'**
  String get badgeWater;

  /// No description provided for @badgeWaterDesc.
  ///
  /// In en, this message translates to:
  /// **'Drink 8 glasses in one day'**
  String get badgeWaterDesc;

  /// No description provided for @emptyProgress.
  ///
  /// In en, this message translates to:
  /// **'Finish your first routine to start your streak.'**
  String get emptyProgress;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'Device language'**
  String get languageSystem;

  /// No description provided for @dailyGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily movement goal'**
  String get dailyGoalLabel;

  /// No description provided for @breakReminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Break interval'**
  String get breakReminderLabel;

  /// No description provided for @breakReminderDesc.
  ///
  /// In en, this message translates to:
  /// **'Used by the sitting timer on the Today screen.'**
  String get breakReminderDesc;

  /// No description provided for @waterGoalSetting.
  ///
  /// In en, this message translates to:
  /// **'Water goal'**
  String get waterGoalSetting;

  /// No description provided for @resetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset progress'**
  String get resetProgress;

  /// No description provided for @resetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset all progress?'**
  String get resetConfirmTitle;

  /// No description provided for @resetConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Streaks, minutes and water logs will be deleted.'**
  String get resetConfirmBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @resetAction.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetAction;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'Desk Workout helps desk workers move, stretch and rest their eyes with short, guided routines. All illustrations and animations are drawn in code.'**
  String get aboutBody;

  /// No description provided for @disclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Health disclaimer'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'This app provides general wellness information and is not medical advice. Consult a professional if you have an injury, pain or a medical condition.'**
  String get disclaimerBody;

  /// No description provided for @sourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get sourcesTitle;

  /// No description provided for @sourcesBody.
  ///
  /// In en, this message translates to:
  /// **'Mayo Clinic, Harvard Health, Cleveland Clinic, NHS, HSS, OSHA, American Academy of Ophthalmology, WHO, EFSA, FDA.'**
  String get sourcesBody;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @catNeck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get catNeck;

  /// No description provided for @catNeckDesc.
  ///
  /// In en, this message translates to:
  /// **'Release screen neck'**
  String get catNeckDesc;

  /// No description provided for @catShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get catShoulders;

  /// No description provided for @catShouldersDesc.
  ///
  /// In en, this message translates to:
  /// **'Open rounded shoulders'**
  String get catShouldersDesc;

  /// No description provided for @catWrists.
  ///
  /// In en, this message translates to:
  /// **'Wrists & hands'**
  String get catWrists;

  /// No description provided for @catWristsDesc.
  ///
  /// In en, this message translates to:
  /// **'For typing and mouse work'**
  String get catWristsDesc;

  /// No description provided for @catBack.
  ///
  /// In en, this message translates to:
  /// **'Back & spine'**
  String get catBack;

  /// No description provided for @catBackDesc.
  ///
  /// In en, this message translates to:
  /// **'Mobilise a stiff back'**
  String get catBackDesc;

  /// No description provided for @catLegs.
  ///
  /// In en, this message translates to:
  /// **'Hips & legs'**
  String get catLegs;

  /// No description provided for @catLegsDesc.
  ///
  /// In en, this message translates to:
  /// **'Wake up your circulation'**
  String get catLegsDesc;

  /// No description provided for @catEyes.
  ///
  /// In en, this message translates to:
  /// **'Eyes'**
  String get catEyes;

  /// No description provided for @catEyesDesc.
  ///
  /// In en, this message translates to:
  /// **'Beat digital eye strain'**
  String get catEyesDesc;

  /// No description provided for @catBreathing.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get catBreathing;

  /// No description provided for @catBreathingDesc.
  ///
  /// In en, this message translates to:
  /// **'Calm and refocus'**
  String get catBreathingDesc;

  /// No description provided for @rtQuickName.
  ///
  /// In en, this message translates to:
  /// **'2-Minute Reset'**
  String get rtQuickName;

  /// No description provided for @rtQuickDesc.
  ///
  /// In en, this message translates to:
  /// **'The perfect micro-break between meetings.'**
  String get rtQuickDesc;

  /// No description provided for @rtNeckName.
  ///
  /// In en, this message translates to:
  /// **'Neck & Shoulder Relief'**
  String get rtNeckName;

  /// No description provided for @rtNeckDesc.
  ///
  /// In en, this message translates to:
  /// **'Melt away tension from hours of screen time.'**
  String get rtNeckDesc;

  /// No description provided for @rtWristName.
  ///
  /// In en, this message translates to:
  /// **'Wrist & Hand Care'**
  String get rtWristName;

  /// No description provided for @rtWristDesc.
  ///
  /// In en, this message translates to:
  /// **'Protect hands that type and click all day.'**
  String get rtWristDesc;

  /// No description provided for @rtBackName.
  ///
  /// In en, this message translates to:
  /// **'Lower Back Rescue'**
  String get rtBackName;

  /// No description provided for @rtBackDesc.
  ///
  /// In en, this message translates to:
  /// **'Decompress the spine and loosen tight hips.'**
  String get rtBackDesc;

  /// No description provided for @rtEyeName.
  ///
  /// In en, this message translates to:
  /// **'Eye Recharge'**
  String get rtEyeName;

  /// No description provided for @rtEyeDesc.
  ///
  /// In en, this message translates to:
  /// **'Refresh tired, dry screen eyes.'**
  String get rtEyeDesc;

  /// No description provided for @rtEnergyName.
  ///
  /// In en, this message translates to:
  /// **'Energy Boost'**
  String get rtEnergyName;

  /// No description provided for @rtEnergyDesc.
  ///
  /// In en, this message translates to:
  /// **'Get your heart rate up and beat the slump.'**
  String get rtEnergyDesc;

  /// No description provided for @rtPostureName.
  ///
  /// In en, this message translates to:
  /// **'Posture Fix'**
  String get rtPostureName;

  /// No description provided for @rtPostureDesc.
  ///
  /// In en, this message translates to:
  /// **'Undo the hunch and stand taller.'**
  String get rtPostureDesc;

  /// No description provided for @rtCalmName.
  ///
  /// In en, this message translates to:
  /// **'Calm Down'**
  String get rtCalmName;

  /// No description provided for @rtCalmDesc.
  ///
  /// In en, this message translates to:
  /// **'Breathing and stretching to reset stress.'**
  String get rtCalmDesc;

  /// No description provided for @rtFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Desk Workout'**
  String get rtFullName;

  /// No description provided for @rtFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A complete head-to-toe session for your lunch break.'**
  String get rtFullDesc;

  /// No description provided for @doseReps.
  ///
  /// In en, this message translates to:
  /// **'{count} reps'**
  String doseReps(int count);

  /// No description provided for @doseRepsEachSide.
  ///
  /// In en, this message translates to:
  /// **'{count} reps each side'**
  String doseRepsEachSide(int count);

  /// No description provided for @doseHold.
  ///
  /// In en, this message translates to:
  /// **'Hold {count} s'**
  String doseHold(int count);

  /// No description provided for @doseHoldEachSide.
  ///
  /// In en, this message translates to:
  /// **'Hold {count} s each side'**
  String doseHoldEachSide(int count);

  /// No description provided for @doseBreaths.
  ///
  /// In en, this message translates to:
  /// **'{count} slow breaths'**
  String doseBreaths(int count);

  /// No description provided for @doseSeconds.
  ///
  /// In en, this message translates to:
  /// **'{count} seconds'**
  String doseSeconds(int count);

  /// No description provided for @doseRounds.
  ///
  /// In en, this message translates to:
  /// **'{count} rounds'**
  String doseRounds(int count);

  /// No description provided for @tip1.
  ///
  /// In en, this message translates to:
  /// **'Break up sitting every 30 minutes – even a short walk helps your blood sugar and blood pressure.'**
  String get tip1;

  /// No description provided for @tip2.
  ///
  /// In en, this message translates to:
  /// **'WHO recommends 150–300 minutes of moderate activity per week for adults.'**
  String get tip2;

  /// No description provided for @tip3.
  ///
  /// In en, this message translates to:
  /// **'Change your position about every 15 minutes, even just shifting how you sit.'**
  String get tip3;

  /// No description provided for @tip4.
  ///
  /// In en, this message translates to:
  /// **'Place the top of your monitor at or slightly below eye level.'**
  String get tip4;

  /// No description provided for @tip5.
  ///
  /// In en, this message translates to:
  /// **'Take phone calls standing up – it’s free movement.'**
  String get tip5;

  /// No description provided for @tip6.
  ///
  /// In en, this message translates to:
  /// **'Keep a water bottle on your desk; every refill is a mini break.'**
  String get tip6;

  /// No description provided for @tip7.
  ///
  /// In en, this message translates to:
  /// **'Use the stairs and walk to a colleague instead of messaging.'**
  String get tip7;

  /// No description provided for @tip8.
  ///
  /// In en, this message translates to:
  /// **'Keep wrists straight while typing and let your elbows rest close to your body.'**
  String get tip8;

  /// No description provided for @exChinTuckName.
  ///
  /// In en, this message translates to:
  /// **'Chin Tuck'**
  String get exChinTuckName;

  /// No description provided for @exChinTuckSummary.
  ///
  /// In en, this message translates to:
  /// **'Undo “screen neck” by gliding your head straight back.'**
  String get exChinTuckSummary;

  /// No description provided for @exChinTuckSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall with your feet flat and shoulders relaxed.\nKeep your eyes level and glide your chin and head straight back, making a gentle double chin.\nHold for 5 seconds, feeling a stretch at the base of the skull.\nRelease slowly and repeat.'**
  String get exChinTuckSteps;

  /// No description provided for @exChinTuckTip.
  ///
  /// In en, this message translates to:
  /// **'It is a small movement: don’t nod up or down.'**
  String get exChinTuckTip;

  /// No description provided for @exNeckSideTiltName.
  ///
  /// In en, this message translates to:
  /// **'Neck Side Tilt'**
  String get exNeckSideTiltName;

  /// No description provided for @exNeckSideTiltSummary.
  ///
  /// In en, this message translates to:
  /// **'Ease tension on the sides of the neck.'**
  String get exNeckSideTiltSummary;

  /// No description provided for @exNeckSideTiltSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall and let your shoulders drop away from your ears.\nSlowly tilt one ear toward the same-side shoulder, face looking forward.\nHold 15–30 seconds while breathing calmly.\nReturn to centre and repeat on the other side.'**
  String get exNeckSideTiltSteps;

  /// No description provided for @exNeckSideTiltTip.
  ///
  /// In en, this message translates to:
  /// **'Don’t lift the shoulder to meet the ear and never bounce.'**
  String get exNeckSideTiltTip;

  /// No description provided for @exNeckRotationName.
  ///
  /// In en, this message translates to:
  /// **'Neck Rotation'**
  String get exNeckRotationName;

  /// No description provided for @exNeckRotationSummary.
  ///
  /// In en, this message translates to:
  /// **'Restore the ability to look over your shoulder.'**
  String get exNeckRotationSummary;

  /// No description provided for @exNeckRotationSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit upright with shoulders down and look straight ahead.\nSlowly turn your head toward one shoulder as far as is comfortable, chin level.\nHold for 5 seconds.\nReturn to centre and turn to the other side.'**
  String get exNeckRotationSteps;

  /// No description provided for @exNeckRotationTip.
  ///
  /// In en, this message translates to:
  /// **'Move slowly and keep your shoulders still.'**
  String get exNeckRotationTip;

  /// No description provided for @exLevatorStretchName.
  ///
  /// In en, this message translates to:
  /// **'Levator Scapulae Stretch'**
  String get exLevatorStretchName;

  /// No description provided for @exLevatorStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Target the stubborn knot between neck and shoulder blade.'**
  String get exLevatorStretchSummary;

  /// No description provided for @exLevatorStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Hold the edge of the seat with the hand of the side you want to stretch.\nTurn your head about 45° away from that side.\nLook down toward the opposite armpit.\nRest the other hand on the back of your head for light support and hold.'**
  String get exLevatorStretchSteps;

  /// No description provided for @exLevatorStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Let the hand only rest on your head – don’t pull.'**
  String get exLevatorStretchTip;

  /// No description provided for @exUpperTrapStretchName.
  ///
  /// In en, this message translates to:
  /// **'Upper Trapezius Stretch'**
  String get exUpperTrapStretchName;

  /// No description provided for @exUpperTrapStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Release the muscles that hold stress on your shoulders.'**
  String get exUpperTrapStretchSummary;

  /// No description provided for @exUpperTrapStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Hold the seat with the hand of the side to stretch to keep that shoulder down.\nTilt your ear toward the opposite shoulder, face forward.\nPlace the opposite hand on top of your head for gentle overpressure.\nHold 10–30 seconds and switch sides.'**
  String get exUpperTrapStretchSteps;

  /// No description provided for @exUpperTrapStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Stop if you feel pain, tingling or numbness.'**
  String get exUpperTrapStretchTip;

  /// No description provided for @exShoulderShrugsName.
  ///
  /// In en, this message translates to:
  /// **'Shoulder Shrugs'**
  String get exShoulderShrugsName;

  /// No description provided for @exShoulderShrugsSummary.
  ///
  /// In en, this message translates to:
  /// **'Wake up tired upper shoulders in seconds.'**
  String get exShoulderShrugsSummary;

  /// No description provided for @exShoulderShrugsSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall with your arms hanging relaxed.\nLift both shoulders straight up toward your ears.\nPause for 1–2 seconds at the top.\nLet them drop fully and relax.'**
  String get exShoulderShrugsSteps;

  /// No description provided for @exShoulderShrugsTip.
  ///
  /// In en, this message translates to:
  /// **'Lift straight up without rolling and keep your neck long.'**
  String get exShoulderShrugsTip;

  /// No description provided for @exShoulderRollsName.
  ///
  /// In en, this message translates to:
  /// **'Shoulder Rolls'**
  String get exShoulderRollsName;

  /// No description provided for @exShoulderRollsSummary.
  ///
  /// In en, this message translates to:
  /// **'Big, slow circles that loosen the whole shoulder girdle.'**
  String get exShoulderRollsSummary;

  /// No description provided for @exShoulderRollsSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall with your arms relaxed.\nDraw large circles with your shoulders: up, back, down and forward.\nMake each circle slow and smooth.\nAfter half the reps, reverse the direction.'**
  String get exShoulderRollsSteps;

  /// No description provided for @exShoulderRollsTip.
  ///
  /// In en, this message translates to:
  /// **'Keep your head still and let only the shoulders move.'**
  String get exShoulderRollsTip;

  /// No description provided for @exScapularSqueezeName.
  ///
  /// In en, this message translates to:
  /// **'Shoulder Blade Squeeze'**
  String get exScapularSqueezeName;

  /// No description provided for @exScapularSqueezeSummary.
  ///
  /// In en, this message translates to:
  /// **'Counter rounded shoulders and activate your upper back.'**
  String get exScapularSqueezeSummary;

  /// No description provided for @exScapularSqueezeSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit upright, away from the backrest, elbows bent at your sides.\nDraw your shoulder blades back and together, slightly down.\nHold for 3–5 seconds with your chest open.\nRelease slowly.'**
  String get exScapularSqueezeSteps;

  /// No description provided for @exScapularSqueezeTip.
  ///
  /// In en, this message translates to:
  /// **'Don’t shrug or arch your lower back.'**
  String get exScapularSqueezeTip;

  /// No description provided for @exCrossBodyStretchName.
  ///
  /// In en, this message translates to:
  /// **'Cross-Body Shoulder Stretch'**
  String get exCrossBodyStretchName;

  /// No description provided for @exCrossBodyStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Stretch the back of the shoulder after long mouse work.'**
  String get exCrossBodyStretchSummary;

  /// No description provided for @exCrossBodyStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit straight with your shoulders down.\nBring one straight arm across your chest at shoulder height.\nCup the elbow with your other hand and gently pull it toward you.\nHold 10–30 seconds and switch arms.'**
  String get exCrossBodyStretchSteps;

  /// No description provided for @exCrossBodyStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Keep your torso facing forward – don’t rotate with the arm.'**
  String get exCrossBodyStretchTip;

  /// No description provided for @exTricepsStretchName.
  ///
  /// In en, this message translates to:
  /// **'Overhead Triceps Stretch'**
  String get exTricepsStretchName;

  /// No description provided for @exTricepsStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Open the back of the arm and the side of the chest.'**
  String get exTricepsStretchSummary;

  /// No description provided for @exTricepsStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Raise one arm and bend the elbow so the hand drops behind your head.\nPoint the elbow to the ceiling, palm toward your upper back.\nWith the other hand, gently press the elbow back.\nHold about 20 seconds per arm.'**
  String get exTricepsStretchSteps;

  /// No description provided for @exTricepsStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Keep your head upright; don’t push it forward.'**
  String get exTricepsStretchTip;

  /// No description provided for @exChestOpenerName.
  ///
  /// In en, this message translates to:
  /// **'Seated Chest Opener'**
  String get exChestOpenerName;

  /// No description provided for @exChestOpenerSummary.
  ///
  /// In en, this message translates to:
  /// **'Reverse the hunch: open the chest and front shoulders.'**
  String get exChestOpenerSummary;

  /// No description provided for @exChestOpenerSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit near the front of the seat and roll your shoulders down and back.\nInterlace your fingers behind you, palms facing your body.\nStraighten your arms and lift your hands gently until you feel a stretch.\nHold 10–30 seconds while breathing deeply.'**
  String get exChestOpenerSteps;

  /// No description provided for @exChestOpenerTip.
  ///
  /// In en, this message translates to:
  /// **'Can’t clasp your hands? Hold your forearms or elbows instead.'**
  String get exChestOpenerTip;

  /// No description provided for @exThoracicExtensionName.
  ///
  /// In en, this message translates to:
  /// **'Thoracic Extension'**
  String get exThoracicExtensionName;

  /// No description provided for @exThoracicExtensionSummary.
  ///
  /// In en, this message translates to:
  /// **'Bend the stiff upper back the other way over your backrest.'**
  String get exThoracicExtensionSummary;

  /// No description provided for @exThoracicExtensionSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit with feet flat and your mid-back against the top of the backrest.\nSupport your neck with your hands, elbows forward.\nLean back over the backrest, lifting your chest and looking up.\nHold 3–5 seconds and come back up slowly.'**
  String get exThoracicExtensionSteps;

  /// No description provided for @exThoracicExtensionTip.
  ///
  /// In en, this message translates to:
  /// **'Move from the upper back, not the neck. Use a stable chair.'**
  String get exThoracicExtensionTip;

  /// No description provided for @exOverheadSideBendName.
  ///
  /// In en, this message translates to:
  /// **'Overhead Side Bend'**
  String get exOverheadSideBendName;

  /// No description provided for @exOverheadSideBendSummary.
  ///
  /// In en, this message translates to:
  /// **'Lengthen the sides of your trunk and breathe deeper.'**
  String get exOverheadSideBendSummary;

  /// No description provided for @exOverheadSideBendSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall with both hips grounded on the seat.\nRaise your arms overhead and clasp your hands.\nBend slowly to one side from the waist.\nReturn to centre and bend to the other side.'**
  String get exOverheadSideBendSteps;

  /// No description provided for @exOverheadSideBendTip.
  ///
  /// In en, this message translates to:
  /// **'Stay in one plane: don’t lean forward and keep both hips on the chair.'**
  String get exOverheadSideBendTip;

  /// No description provided for @exSpinalTwistName.
  ///
  /// In en, this message translates to:
  /// **'Seated Spinal Twist'**
  String get exSpinalTwistName;

  /// No description provided for @exSpinalTwistSummary.
  ///
  /// In en, this message translates to:
  /// **'Mobilise the spine and relieve a stiff back.'**
  String get exSpinalTwistSummary;

  /// No description provided for @exSpinalTwistSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit upright, feet flat, arms crossed over your chest.\nKeep hips and knees facing forward.\nTurn your upper body to one side and hold for 5 seconds.\nReturn to centre and turn the other way.'**
  String get exSpinalTwistSteps;

  /// No description provided for @exSpinalTwistTip.
  ///
  /// In en, this message translates to:
  /// **'Grow tall before you twist and never force the end range.'**
  String get exSpinalTwistTip;

  /// No description provided for @exCatCowName.
  ///
  /// In en, this message translates to:
  /// **'Seated Cat-Cow'**
  String get exCatCowName;

  /// No description provided for @exCatCowSummary.
  ///
  /// In en, this message translates to:
  /// **'A flowing spine wave synced with your breath.'**
  String get exCatCowSummary;

  /// No description provided for @exCatCowSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall, feet flat, hands on your thighs.\nInhale (cow): arch your back, lift your chest and draw your shoulder blades together.\nExhale (cat): round your back, tuck your pelvis and bring your chin toward your chest.\nFlow slowly between the two.'**
  String get exCatCowSteps;

  /// No description provided for @exCatCowTip.
  ///
  /// In en, this message translates to:
  /// **'Don’t jut your chin forward or drop your head back.'**
  String get exCatCowTip;

  /// No description provided for @exForwardFoldName.
  ///
  /// In en, this message translates to:
  /// **'Seated Forward Fold'**
  String get exForwardFoldName;

  /// No description provided for @exForwardFoldSummary.
  ///
  /// In en, this message translates to:
  /// **'Let your back decompress and your mind slow down.'**
  String get exForwardFoldSummary;

  /// No description provided for @exForwardFoldSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall with your feet flat and apart.\nExhale and fold forward, resting your forearms on your thighs.\nLet your head, neck and spine form one long line.\nBreathe slowly, then roll up gradually.'**
  String get exForwardFoldSteps;

  /// No description provided for @exForwardFoldTip.
  ///
  /// In en, this message translates to:
  /// **'Come up slowly – you may feel light-headed.'**
  String get exForwardFoldTip;

  /// No description provided for @exWristFlexorStretchName.
  ///
  /// In en, this message translates to:
  /// **'Wrist Flexor Stretch'**
  String get exWristFlexorStretchName;

  /// No description provided for @exWristFlexorStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Relieve forearms that type and click all day.'**
  String get exWristFlexorStretchSummary;

  /// No description provided for @exWristFlexorStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Extend one arm straight in front, palm facing up.\nWith the other hand, gently pull the fingers down toward the floor.\nKeep the elbow straight and hold 15–30 seconds.\nSwitch hands.'**
  String get exWristFlexorStretchSteps;

  /// No description provided for @exWristFlexorStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Pull gently – you should feel a stretch, never pain.'**
  String get exWristFlexorStretchTip;

  /// No description provided for @exWristExtensorStretchName.
  ///
  /// In en, this message translates to:
  /// **'Wrist Extensor Stretch'**
  String get exWristExtensorStretchName;

  /// No description provided for @exWristExtensorStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Stretch the top of the forearm, a classic mouse-arm fix.'**
  String get exWristExtensorStretchSummary;

  /// No description provided for @exWristExtensorStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Extend one arm straight in front, palm facing down.\nBend the wrist so the fingers point to the floor.\nWith the other hand, gently press the back of the hand toward you.\nHold 15–30 seconds and switch.'**
  String get exWristExtensorStretchSteps;

  /// No description provided for @exWristExtensorStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Keep the elbow straight to feel it along the forearm.'**
  String get exWristExtensorStretchTip;

  /// No description provided for @exWristCirclesName.
  ///
  /// In en, this message translates to:
  /// **'Wrist Circles'**
  String get exWristCirclesName;

  /// No description provided for @exWristCirclesSummary.
  ///
  /// In en, this message translates to:
  /// **'Warm up stiff wrists before and after typing.'**
  String get exWristCirclesSummary;

  /// No description provided for @exWristCirclesSteps.
  ///
  /// In en, this message translates to:
  /// **'Extend both arms in front and make loose fists.\nKeep your forearms still.\nSlowly circle your wrists outward.\nAfter half the reps, circle inward.'**
  String get exWristCirclesSteps;

  /// No description provided for @exWristCirclesTip.
  ///
  /// In en, this message translates to:
  /// **'Only the hands move – keep the movement smooth.'**
  String get exWristCirclesTip;

  /// No description provided for @exPrayerStretchName.
  ///
  /// In en, this message translates to:
  /// **'Prayer Stretch'**
  String get exPrayerStretchName;

  /// No description provided for @exPrayerStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'A gentle stretch for the palms and inner forearms.'**
  String get exPrayerStretchSummary;

  /// No description provided for @exPrayerStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Press your palms together in front of your chest, fingers up.\nKeep the palms together and slowly lower your hands toward your waist.\nLet your elbows spread out to the sides.\nHold 15–30 seconds with a mild stretch.'**
  String get exPrayerStretchSteps;

  /// No description provided for @exPrayerStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Aim for mild tension, never pain.'**
  String get exPrayerStretchTip;

  /// No description provided for @exFigureFourName.
  ///
  /// In en, this message translates to:
  /// **'Seated Figure-4 Stretch'**
  String get exFigureFourName;

  /// No description provided for @exFigureFourSummary.
  ///
  /// In en, this message translates to:
  /// **'Release tight hips and glutes from long sitting.'**
  String get exFigureFourSummary;

  /// No description provided for @exFigureFourSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall near the front edge, both feet flat.\nPlace one ankle on the opposite knee.\nKeep your back flat and hinge slightly forward until you feel the outer hip.\nHold 30–45 seconds and switch legs.'**
  String get exFigureFourSteps;

  /// No description provided for @exFigureFourTip.
  ///
  /// In en, this message translates to:
  /// **'If your knee complains, just hold the crossed position without leaning.'**
  String get exFigureFourTip;

  /// No description provided for @exLegExtensionName.
  ///
  /// In en, this message translates to:
  /// **'Seated Leg Extension'**
  String get exLegExtensionName;

  /// No description provided for @exLegExtensionSummary.
  ///
  /// In en, this message translates to:
  /// **'Fire up your thighs without leaving the chair.'**
  String get exLegExtensionSummary;

  /// No description provided for @exLegExtensionSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall with your thighs parallel to the floor.\nSlowly straighten one knee, toes pulled toward you.\nPause at the top, then lower with control.\nComplete the reps and switch legs.'**
  String get exLegExtensionSteps;

  /// No description provided for @exLegExtensionTip.
  ///
  /// In en, this message translates to:
  /// **'Don’t lock the knee at the top.'**
  String get exLegExtensionTip;

  /// No description provided for @exHamstringStretchName.
  ///
  /// In en, this message translates to:
  /// **'Seated Hamstring Stretch'**
  String get exHamstringStretchName;

  /// No description provided for @exHamstringStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Lengthen the back of the thighs that shorten when sitting.'**
  String get exHamstringStretchSummary;

  /// No description provided for @exHamstringStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit at the front edge of the chair.\nStraighten one leg with the heel on the floor and toes up.\nKeep your back straight and hinge forward from the hips.\nHold 30–45 seconds and switch legs.'**
  String get exHamstringStretchSteps;

  /// No description provided for @exHamstringStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Hinge from the hips – don’t round your back.'**
  String get exHamstringStretchTip;

  /// No description provided for @exAnklePumpsName.
  ///
  /// In en, this message translates to:
  /// **'Ankle Pumps'**
  String get exAnklePumpsName;

  /// No description provided for @exAnklePumpsSummary.
  ///
  /// In en, this message translates to:
  /// **'Help your calves pump blood back up your legs.'**
  String get exAnklePumpsSummary;

  /// No description provided for @exAnklePumpsSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit tall and lift one foot slightly off the floor.\nPoint your toes away from you.\nThen pull your toes back toward you.\nRepeat smoothly and switch feet.'**
  String get exAnklePumpsSteps;

  /// No description provided for @exAnklePumpsTip.
  ///
  /// In en, this message translates to:
  /// **'Only the foot moves – keep the shin still.'**
  String get exAnklePumpsTip;

  /// No description provided for @exSeatedMarchingName.
  ///
  /// In en, this message translates to:
  /// **'Seated Marching'**
  String get exSeatedMarchingName;

  /// No description provided for @exSeatedMarchingSummary.
  ///
  /// In en, this message translates to:
  /// **'A quick cardio boost to beat the afternoon slump.'**
  String get exSeatedMarchingSummary;

  /// No description provided for @exSeatedMarchingSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit upright without leaning on the backrest.\nHold the sides of the chair.\nLift one bent knee as high as is comfortable, then lower it with control.\nAlternate legs at a steady rhythm.'**
  String get exSeatedMarchingSteps;

  /// No description provided for @exSeatedMarchingTip.
  ///
  /// In en, this message translates to:
  /// **'Don’t lean back as you lift.'**
  String get exSeatedMarchingTip;

  /// No description provided for @exCalfRaisesName.
  ///
  /// In en, this message translates to:
  /// **'Standing Calf Raises'**
  String get exCalfRaisesName;

  /// No description provided for @exCalfRaisesSummary.
  ///
  /// In en, this message translates to:
  /// **'Strengthen calves and boost circulation.'**
  String get exCalfRaisesSummary;

  /// No description provided for @exCalfRaisesSteps.
  ///
  /// In en, this message translates to:
  /// **'Stand facing your desk and rest your hands lightly on it.\nRise slowly onto the balls of your feet.\nPause briefly at the top.\nLower your heels with control.'**
  String get exCalfRaisesSteps;

  /// No description provided for @exCalfRaisesTip.
  ///
  /// In en, this message translates to:
  /// **'For more challenge, do it without hand support.'**
  String get exCalfRaisesTip;

  /// No description provided for @exHipFlexorStretchName.
  ///
  /// In en, this message translates to:
  /// **'Standing Hip Flexor Stretch'**
  String get exHipFlexorStretchName;

  /// No description provided for @exHipFlexorStretchSummary.
  ///
  /// In en, this message translates to:
  /// **'Open the front of the hips that tighten from sitting.'**
  String get exHipFlexorStretchSummary;

  /// No description provided for @exHipFlexorStretchSteps.
  ///
  /// In en, this message translates to:
  /// **'Stand in a split stance, the leg to stretch a stride behind.\nSlightly bend the front knee and keep your back straight.\nTuck your tailbone under and gently push the back hip forward.\nHold 20–30 seconds and switch sides.'**
  String get exHipFlexorStretchSteps;

  /// No description provided for @exHipFlexorStretchTip.
  ///
  /// In en, this message translates to:
  /// **'Hold your desk for balance and don’t arch your lower back.'**
  String get exHipFlexorStretchTip;

  /// No description provided for @exChairSquatName.
  ///
  /// In en, this message translates to:
  /// **'Chair Sit-to-Stand'**
  String get exChairSquatName;

  /// No description provided for @exChairSquatSummary.
  ///
  /// In en, this message translates to:
  /// **'The most practical leg exercise for desk workers.'**
  String get exChairSquatSummary;

  /// No description provided for @exChairSquatSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit at the edge of a stable chair, feet hip-width apart.\nCross your arms over your chest and lean slightly forward.\nStand up using your legs, looking forward.\nSit back down slowly and with control.'**
  String get exChairSquatSteps;

  /// No description provided for @exChairSquatTip.
  ///
  /// In en, this message translates to:
  /// **'Use a chair without wheels or lock it against a wall.'**
  String get exChairSquatTip;

  /// No description provided for @exDeskPushUpName.
  ///
  /// In en, this message translates to:
  /// **'Desk Push-Up'**
  String get exDeskPushUpName;

  /// No description provided for @exDeskPushUpSummary.
  ///
  /// In en, this message translates to:
  /// **'Strengthen chest, shoulders and arms using your desk.'**
  String get exDeskPushUpSummary;

  /// No description provided for @exDeskPushUpSteps.
  ///
  /// In en, this message translates to:
  /// **'Place your hands shoulder-width apart on the edge of a stable desk.\nWalk your feet back until your body forms a straight line.\nBend your elbows and lower your chest toward the desk.\nPress back up to straight arms.'**
  String get exDeskPushUpSteps;

  /// No description provided for @exDeskPushUpTip.
  ///
  /// In en, this message translates to:
  /// **'Keep your core tight and make sure the desk can’t slide.'**
  String get exDeskPushUpTip;

  /// No description provided for @exRule202020Name.
  ///
  /// In en, this message translates to:
  /// **'20-20-20 Eye Break'**
  String get exRule202020Name;

  /// No description provided for @exRule202020Summary.
  ///
  /// In en, this message translates to:
  /// **'The ophthalmologists’ rule for tired screen eyes.'**
  String get exRule202020Summary;

  /// No description provided for @exRule202020Steps.
  ///
  /// In en, this message translates to:
  /// **'Every 20 minutes, look away from your screen.\nFocus on something about 6 metres (20 feet) away.\nKeep looking for at least 20 seconds.\nBlink fully a few times before returning to work.'**
  String get exRule202020Steps;

  /// No description provided for @exRule202020Tip.
  ///
  /// In en, this message translates to:
  /// **'A window view is perfect – distant focus relaxes the eye muscles.'**
  String get exRule202020Tip;

  /// No description provided for @exNearFarFocusName.
  ///
  /// In en, this message translates to:
  /// **'Near–Far Focus'**
  String get exNearFarFocusName;

  /// No description provided for @exNearFarFocusSummary.
  ///
  /// In en, this message translates to:
  /// **'Train your eyes to switch focus smoothly.'**
  String get exNearFarFocusSummary;

  /// No description provided for @exNearFarFocusSteps.
  ///
  /// In en, this message translates to:
  /// **'Hold your thumb about 25 cm in front of your face.\nFocus on it for a few seconds.\nThen shift your focus to an object far away.\nKeep switching slowly between near and far.'**
  String get exNearFarFocusSteps;

  /// No description provided for @exNearFarFocusTip.
  ///
  /// In en, this message translates to:
  /// **'Keep your head still and breathe normally.'**
  String get exNearFarFocusTip;

  /// No description provided for @exEyeMovementsName.
  ///
  /// In en, this message translates to:
  /// **'Eye Movements'**
  String get exEyeMovementsName;

  /// No description provided for @exEyeMovementsSummary.
  ///
  /// In en, this message translates to:
  /// **'A gentle comfort routine for stiff, tired eyes.'**
  String get exEyeMovementsSummary;

  /// No description provided for @exEyeMovementsSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit comfortably and keep your head still.\nSlowly look up, then down.\nSlowly look left, then right.\nClose your eyes and relax for a moment.'**
  String get exEyeMovementsSteps;

  /// No description provided for @exEyeMovementsTip.
  ///
  /// In en, this message translates to:
  /// **'This is a comfort routine, not a treatment. Stop if it causes discomfort.'**
  String get exEyeMovementsTip;

  /// No description provided for @exPalmingName.
  ///
  /// In en, this message translates to:
  /// **'Palming'**
  String get exPalmingName;

  /// No description provided for @exPalmingSummary.
  ///
  /// In en, this message translates to:
  /// **'Warm darkness to rest the eyes completely.'**
  String get exPalmingSummary;

  /// No description provided for @exPalmingSteps.
  ///
  /// In en, this message translates to:
  /// **'Rub your hands together to warm them.\nClose your eyes.\nCup your palms gently over your eyes without pressing.\nBreathe slowly for 20–30 seconds.'**
  String get exPalmingSteps;

  /// No description provided for @exPalmingTip.
  ///
  /// In en, this message translates to:
  /// **'No pressure on the eyeballs – the palms only rest on the cheekbones.'**
  String get exPalmingTip;

  /// No description provided for @exBlinkingName.
  ///
  /// In en, this message translates to:
  /// **'Conscious Blinking'**
  String get exBlinkingName;

  /// No description provided for @exBlinkingSummary.
  ///
  /// In en, this message translates to:
  /// **'Restore the tear film that screens dry out.'**
  String get exBlinkingSummary;

  /// No description provided for @exBlinkingSteps.
  ///
  /// In en, this message translates to:
  /// **'Close your eyes gently for 2 seconds.\nOpen them.\nClose again for 2 seconds.\nThen squeeze gently for 2 seconds and open.'**
  String get exBlinkingSteps;

  /// No description provided for @exBlinkingTip.
  ///
  /// In en, this message translates to:
  /// **'At screens we blink about half as often – repeat this every 20 minutes.'**
  String get exBlinkingTip;

  /// No description provided for @exBoxBreathingName.
  ///
  /// In en, this message translates to:
  /// **'Box Breathing'**
  String get exBoxBreathingName;

  /// No description provided for @exBoxBreathingSummary.
  ///
  /// In en, this message translates to:
  /// **'Four equal sides to calm a busy mind.'**
  String get exBoxBreathingSummary;

  /// No description provided for @exBoxBreathingSteps.
  ///
  /// In en, this message translates to:
  /// **'Exhale completely.\nBreathe in through your nose for 4 seconds.\nHold for 4 seconds.\nBreathe out for 4 seconds, then hold for 4 seconds.'**
  String get exBoxBreathingSteps;

  /// No description provided for @exBoxBreathingTip.
  ///
  /// In en, this message translates to:
  /// **'Shorten the counts if you feel any strain.'**
  String get exBoxBreathingTip;

  /// No description provided for @exBellyBreathingName.
  ///
  /// In en, this message translates to:
  /// **'Belly Breathing'**
  String get exBellyBreathingName;

  /// No description provided for @exBellyBreathingSummary.
  ///
  /// In en, this message translates to:
  /// **'Diaphragmatic breathing to release shoulder tension.'**
  String get exBellyBreathingSummary;

  /// No description provided for @exBellyBreathingSteps.
  ///
  /// In en, this message translates to:
  /// **'Sit with your shoulders relaxed.\nPlace one hand on your chest and one just below your ribs.\nBreathe in through your nose so the belly pushes your lower hand out.\nBreathe out slowly through pursed lips.'**
  String get exBellyBreathingSteps;

  /// No description provided for @exBellyBreathingTip.
  ///
  /// In en, this message translates to:
  /// **'Only the lower hand should move; the chest stays quiet.'**
  String get exBellyBreathingTip;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
