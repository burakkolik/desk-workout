import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../app/routes.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/entrance.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';

/// Celebration screen with confetti and session stats.
class WorkoutCompleteScreen extends StatefulWidget {
  const WorkoutCompleteScreen({super.key, required this.seconds, required this.exercises, required this.onRepeat});

  final int seconds;
  final int exercises;
  final Widget Function() onRepeat;

  @override
  State<WorkoutCompleteScreen> createState() => _WorkoutCompleteScreenState();
}

class _WorkoutCompleteScreenState extends State<WorkoutCompleteScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 5))..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rs = context.rs;
    final streak = context.progress.currentStreak;
    final short = rs.isLandscape && rs.height < 600;
    final minutes = (widget.seconds / 60).toStringAsFixed(widget.seconds < 600 ? 1 : 0);
    return Scaffold(
      body: AppBackground(
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _c,
                  builder: (context, _) => CustomPaint(painter: _ConfettiPainter(_c.value)),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(rs.pad),
                  child: MaxWidth(
                    maxWidth: short ? 900 : 560,
                    child: Flex(
                      direction: short ? Axis.horizontal : Axis.vertical,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 1100),
                          curve: Curves.elasticOut,
                          builder: (context, v, child) => Transform.scale(scale: v, child: child),
                          child: Container(
                            width: 130 * rs.scale,
                            height: 130 * rs.scale,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppGradients.sunrise,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.amber.withValues(alpha: 0.5),
                                  blurRadius: 50,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: DwIcon(DwIcons.trophy, size: 70 * rs.scale, color: AppColors.bg, strokeWidth: 1.8),
                          ),
                        ),
                        SizedBox(width: short ? 32 : 0, height: short ? 0 : 28),
                        Flexible(
                          fit: short ? FlexFit.tight : FlexFit.loose,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Entrance(
                                index: 2,
                                child: Text(l.workoutComplete, style: t.displaySmall, textAlign: TextAlign.center),
                              ),
                              const SizedBox(height: 10),
                              Entrance(
                                index: 3,
                                child: Text(
                                  l.completeBody,
                                  style: t.bodyLarge!.copyWith(color: AppColors.textSecondary),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 26),
                              Entrance(
                                index: 4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _Stat(
                                        value: minutes,
                                        label: l.minutesLabel,
                                        color: AppColors.teal,
                                        icon: DwIcons.clock,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: _Stat(
                                        value: '${widget.exercises}',
                                        label: l.exercisesLabel,
                                        color: AppColors.blue,
                                        icon: DwIcons.check,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: _Stat(
                                        value: '$streak',
                                        label: l.streakLabel,
                                        color: AppColors.coral,
                                        icon: DwIcons.flame,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Entrance(
                                index: 5,
                                child: GradientButton(
                                  label: l.backHome,
                                  icon: DwIcons.check,
                                  onTap: () => Navigator.of(context).pop(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Entrance(
                                index: 6,
                                child: TextButton.icon(
                                  onPressed: () =>
                                      Navigator.of(context).pushReplacement(AppRoutes.slideUp(widget.onRepeat())),
                                  icon: const DwIcon(DwIcons.restart, size: 20, color: AppColors.teal),
                                  label: Text(l.doAgain, style: t.labelLarge!.copyWith(color: AppColors.teal)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color, required this.icon});

  final String value;
  final String label;
  final Color color;
  final DwIcons icon;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      glow: color,
      child: Column(
        children: [
          DwIcon(icon, color: color, size: 26),
          const SizedBox(height: 8),
          FittedBox(child: Text(value, style: t.headlineMedium)),
          Text(label, style: t.bodySmall!.copyWith(color: AppColors.textSecondary), maxLines: 1),
        ],
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.t);

  final double t;

  static const _colors = [
    AppColors.teal,
    AppColors.blue,
    AppColors.violet,
    AppColors.coral,
    AppColors.amber,
    AppColors.lime,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(42);
    for (var i = 0; i < 120; i++) {
      final x0 = rnd.nextDouble() * size.width;
      final delay = rnd.nextDouble() * 0.35;
      final speed = 0.6 + rnd.nextDouble() * 0.8;
      final p = ((t - delay) * speed * 1.4).clamp(0.0, 1.2);
      if (p <= 0) continue;
      final y = -30 + p * (size.height + 60);
      final sway = math.sin(p * 10 + i) * 26;
      final rot = p * 12 + i;
      final c = _colors[i % _colors.length];
      canvas.save();
      canvas.translate(x0 + sway, y);
      canvas.rotate(rot);
      final paint = Paint()..color = c.withValues(alpha: (1.2 - p).clamp(0.0, 1.0));
      if (i % 3 == 0) {
        canvas.drawCircle(Offset.zero, 4, paint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: 12, height: 6 * math.cos(rot).abs() + 2),
            const Radius.circular(2),
          ),
          paint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.t != t;
}
