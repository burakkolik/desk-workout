import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../app/routes.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/logo_mark.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../shell/presentation/main_shell.dart';

/// Animated splash: the logo draws itself, rings ripple out, the title
/// rises letter by letter, then we fade into onboarding or the app.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 2900));
  late final AnimationController _loop = AnimationController(vsync: this, duration: const Duration(seconds: 3))
    ..repeat();

  @override
  void initState() {
    super.initState();
    _c.forward().whenComplete(_go);
  }

  void _go() {
    if (!mounted) return;
    final done = AppScope.read(context).settings.onboardingDone;
    Navigator.of(context).pushReplacement(AppRoutes.fade(done ? const MainShell() : const OnboardingScreen()));
  }

  @override
  void dispose() {
    _c.dispose();
    _loop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final rs = context.rs;
    final logo = 132.0 * rs.scale;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBuilder(
        animation: Listenable.merge([_c, _loop]),
        builder: (context, _) {
          final t = _c.value;
          final out = ((t - 0.88) / 0.12).clamp(0.0, 1.0);
          return Opacity(
            opacity: 1 - out,
            child: Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: _SplashBg(t, _loop.value))),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LogoMark(size: logo, progress: (t / 0.55).clamp(0.0, 1.0)),
                        SizedBox(height: 34 * rs.scale),
                        _Title(text: l.appName, t: ((t - 0.4) / 0.35).clamp(0.0, 1.0)),
                        const SizedBox(height: 12),
                        Opacity(
                          opacity: ((t - 0.62) / 0.2).clamp(0.0, 1.0),
                          child: Text(
                            l.splashTagline,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(color: AppColors.textSecondary, letterSpacing: 1.6),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.text, required this.t});

  final String text;
  final double t;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.displayMedium!;
    final chars = text.characters.toList();
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: ShaderMask(
        shaderCallback: (r) =>
            const LinearGradient(colors: [Colors.white, Color(0xFFBFFCF1), AppColors.teal]).createShader(r),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < chars.length; i++)
              Builder(
                builder: (context) {
                  final local = ((t * (chars.length + 4) - i) / 4).clamp(0.0, 1.0);
                  final e = Curves.easeOutBack.transform(local);
                  return Opacity(
                    opacity: local,
                    child: Transform.translate(
                      offset: Offset(0, (1 - e) * 26),
                      child: Text(chars[i], style: style.copyWith(color: Colors.white)),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _SplashBg extends CustomPainter {
  _SplashBg(this.t, this.loop);

  final double t;
  final double loop;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final m = math.max(size.width, size.height);
    // Big soft glows.
    for (final (color, dx, dy, r) in [
      (AppColors.teal, -0.3, -0.25, 0.7),
      (AppColors.blue, 0.35, 0.3, 0.75),
      (AppColors.violet, -0.2, 0.45, 0.5),
    ]) {
      final o = c + Offset(dx * size.width + math.sin(loop * math.pi * 2) * 12, dy * size.height);
      canvas.drawCircle(
        o,
        m * r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withValues(alpha: 0.18 * t.clamp(0, 1)),
              color.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: o, radius: m * r)),
      );
    }
    // Ripple rings from the logo.
    final logoC = c - Offset(0, 50);
    for (var i = 0; i < 3; i++) {
      final p = ((t * 1.6 - 0.2 - i * 0.18)).clamp(0.0, 1.0);
      if (p <= 0 || p >= 1) continue;
      canvas.drawCircle(
        logoC,
        60 + p * m * 0.45,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = AppColors.teal.withValues(alpha: (1 - p) * 0.35),
      );
    }
    // Orbiting particles.
    final rnd = math.Random(3);
    for (var i = 0; i < 40; i++) {
      final a = rnd.nextDouble() * math.pi * 2 + loop * math.pi * 2 * (rnd.nextBool() ? 0.15 : -0.1);
      final r = 120 + rnd.nextDouble() * m * 0.4;
      final p = logoC + Offset(math.cos(a), math.sin(a)) * r * (0.6 + 0.4 * t);
      canvas.drawCircle(
        p,
        1 + rnd.nextDouble() * 2,
        Paint()..color = (i.isEven ? AppColors.teal : AppColors.sky).withValues(alpha: 0.5 * t),
      );
    }
  }

  @override
  bool shouldRepaint(_SplashBg old) => true;
}
