import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../app/routes.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../exercises/domain/exercise.dart';
import '../../exercises/presentation/widgets/animation_stage.dart';
import '../application/workout_session.dart';
import 'widgets/player_widgets.dart';
import 'workout_complete_screen.dart';

/// Full-screen guided workout.
class WorkoutPlayerScreen extends StatefulWidget {
  const WorkoutPlayerScreen({super.key, required this.exercises, required this.title});

  final List<Exercise> exercises;
  final String title;

  @override
  State<WorkoutPlayerScreen> createState() => _WorkoutPlayerScreenState();
}

class _WorkoutPlayerScreenState extends State<WorkoutPlayerScreen> with TickerProviderStateMixin {
  late final WorkoutSession _s = WorkoutSession(exercises: widget.exercises, vsync: this);
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _s.addListener(_onSession);
  }

  void _onSession() {
    _s.tickFeedback();
    if (_s.phase == SessionPhase.complete && !_finished) {
      _finished = true;
      _complete();
    }
  }

  Future<void> _complete() async {
    final progress = AppScope.read(context).progress;
    final seconds = _s.activeSeconds;
    final count = _s.completedCount;
    await progress.logSession(seconds: seconds, exercises: count);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      AppRoutes.fade(
        WorkoutCompleteScreen(
          seconds: seconds,
          exercises: count,
          onRepeat: () => WorkoutPlayerScreen(exercises: widget.exercises, title: widget.title),
        ),
      ),
    );
  }

  Future<bool> _confirmExit() async {
    final l = context.l10n;
    final wasPaused = _s.paused;
    if (!wasPaused) _s.togglePause();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(l.exitTitle),
        content: Text(l.exitBody, style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l.exitConfirm)),
          FilledButton(onPressed: () => Navigator.pop(context, false), child: Text(l.keepGoing)),
        ],
      ),
    );
    if (ok != true && !wasPaused && _s.paused) _s.togglePause();
    return ok == true;
  }

  @override
  void dispose() {
    _s.removeListener(_onSession);
    _s.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final nav = Navigator.of(context);
        if (await _confirmExit()) nav.pop();
      },
      child: Scaffold(
        body: ListenableBuilder(
          listenable: _s,
          builder: (context, _) {
            final ex = _s.current;
            final color = ex.category.color;
            return AppBackground(
              colors: [color, AppColors.blue, AppColors.violet],
              child: SafeArea(
                child: Column(
                  children: [
                    PlayerHeader(
                      title: widget.title,
                      session: _s,
                      onClose: () async {
                        final nav = Navigator.of(context);
                        if (await _confirmExit()) nav.pop();
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(rs.pad, 4, rs.pad, 12),
                        child: rs.twoPane ? _wide(context, ex, color) : _tall(context, ex, color),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _stage(Exercise ex, Color color) => Stack(
    children: [
      Positioned.fill(
        child: AnimationStage(visual: ex.visual, color: color, playing: !_s.paused && _s.phase == SessionPhase.active),
      ),
      if (_s.phase != SessionPhase.active)
        Positioned.fill(
          child: PhaseOverlay(session: _s, color: color),
        ),
    ],
  );

  Widget _controls(Color color) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleIconButton(icon: DwIcons.prev, onTap: _s.previous, size: 56),
      const SizedBox(width: 22),
      CircleIconButton(
        icon: _s.paused ? DwIcons.play : DwIcons.pause,
        onTap: _s.togglePause,
        size: 80,
        color: AppColors.bg,
        gradient: AppGradients.of(color),
      ),
      const SizedBox(width: 22),
      CircleIconButton(icon: DwIcons.next, onTap: _s.skip, size: 56),
    ],
  );

  Widget _tall(BuildContext context, Exercise ex, Color color) {
    final rs = context.rs;
    return Column(
      children: [
        Expanded(child: _stage(ex, color)),
        const SizedBox(height: 14),
        ExerciseInfoPanel(session: _s, compact: rs.height < 700),
        const SizedBox(height: 14),
        _controls(color),
      ],
    );
  }

  Widget _wide(BuildContext context, Exercise ex, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 12, child: _stage(ex, color)),
        SizedBox(width: context.rs.pad),
        Expanded(
          flex: 10,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(child: ExerciseInfoPanel(session: _s, showAllSteps: true)),
              ),
              const SizedBox(height: 12),
              _controls(color),
            ],
          ),
        ),
      ],
    );
  }
}
