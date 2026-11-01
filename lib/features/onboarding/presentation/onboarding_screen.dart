import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../app/routes.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/pressable.dart';
import '../../shell/presentation/main_shell.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_visuals.dart';
import 'widgets/page_dots.dart';
import 'widgets/setup_page.dart';

/// Five-step onboarding: four live, animated story pages and a setup page.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pager = PageController();
  double _page = 0;

  static const _accents = [
    [AppColors.teal, AppColors.blue, AppColors.violet],
    [AppColors.coral, AppColors.violet, AppColors.blue],
    [AppColors.violet, AppColors.sky, AppColors.teal],
    [AppColors.sky, AppColors.lime, AppColors.blue],
    [AppColors.teal, AppColors.amber, AppColors.violet],
  ];

  @override
  void initState() {
    super.initState();
    _pager.addListener(() => setState(() => _page = _pager.page ?? 0));
  }

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  int get _count => 5;
  bool get _isLast => _page.round() == _count - 1;

  void _next() {
    if (_isLast) {
      _finish();
    } else {
      _pager.nextPage(duration: const Duration(milliseconds: 650), curve: Curves.easeInOutCubic);
    }
  }

  Future<void> _finish() async {
    await AppScope.read(context).settings.completeOnboarding();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(AppRoutes.fade(const MainShell()));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final rs = context.rs;
    final idx = _page.round().clamp(0, _count - 1);
    final pages = <Widget>[
      OnboardingPage(
        visual: const WelcomeVisual(),
        title: l.onb1Title,
        body: l.onb1Body,
        accent: AppColors.teal,
        offset: _page - 0,
      ),
      OnboardingPage(
        visual: const PostureVisual(),
        title: l.onb2Title,
        body: l.onb2Body,
        accent: AppColors.coral,
        offset: _page - 1,
      ),
      OnboardingPage(
        visual: const EyesVisual(),
        title: l.onb3Title,
        body: l.onb3Body,
        accent: AppColors.violet,
        offset: _page - 2,
      ),
      OnboardingPage(
        visual: const NutritionVisual(),
        title: l.onb4Title,
        body: l.onb4Body,
        accent: AppColors.sky,
        offset: _page - 3,
      ),
      const SetupPage(),
    ];
    return Scaffold(
      body: AnimatedSwitcherBackground(
        colors: _accents[idx],
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rs.pad, vertical: 8),
                child: Row(
                  children: [
                    const DwIcon(DwIcons.sparkle, color: AppColors.teal, size: 26),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l.appName,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _isLast ? 0 : 1,
                      duration: const Duration(milliseconds: 250),
                      child: Pressable(
                        onTap: _isLast
                            ? null
                            : () => _pager.animateToPage(
                                _count - 1,
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.easeInOutCubic,
                              ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            l.onbSkip,
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(controller: _pager, children: pages),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(rs.pad, 8, rs.pad, 18),
                child: MaxWidth(
                  maxWidth: 560,
                  child: Row(
                    children: [
                      PageDots(count: _count, page: _page),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GradientButton(
                          label: _isLast ? l.onbStart : l.onbNext,
                          icon: _isLast ? DwIcons.check : DwIcons.arrowRight,
                          onTap: _next,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [AppBackground] whose orb colours crossfade when [colors] change.
class AnimatedSwitcherBackground extends StatelessWidget {
  const AnimatedSwitcherBackground({super.key, required this.colors, required this.child});

  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 900),
            child: AppBackground(key: ValueKey(colors.first), colors: colors, child: const SizedBox.expand()),
          ),
        ),
        child,
      ],
    );
  }
}
