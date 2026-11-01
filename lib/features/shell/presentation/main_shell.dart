import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/logo_mark.dart';
import '../../../core/widgets/pressable.dart';
import '../../eye_care/presentation/eye_care_screen.dart';
import '../../exercises/presentation/library_screen.dart';
import '../../home/presentation/home_screen.dart';
import '../../nutrition/presentation/nutrition_screen.dart';
import '../../progress/presentation/progress_screen.dart';

enum AppTab { today, exercises, eyes, nutrition, progress }

/// Root of the signed-in app: tab pages + adaptive navigation
/// (floating bottom bar on phones, side rail on tablets / landscape).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  static MainShellState of(BuildContext context) => context.findAncestorStateOfType<MainShellState>()!;

  @override
  State<MainShell> createState() => MainShellState();
}

class MainShellState extends State<MainShell> {
  AppTab _tab = AppTab.today;

  void goTo(AppTab tab) => setState(() => _tab = tab);

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final pages = [
      const HomeScreen(),
      const LibraryScreen(),
      const EyeCareScreen(),
      const NutritionScreen(),
      const ProgressScreen(),
    ];
    final body = IndexedStack(
      index: _tab.index,
      children: [
        for (var i = 0; i < pages.length; i++)
          TickerMode(
            enabled: i == _tab.index,
            child: _FadeIn(active: i == _tab.index, child: pages[i]),
          ),
      ],
    );
    final items = _items(context.l10n);

    if (rs.useRail) {
      return Scaffold(
        body: AppBackground(
          child: Row(
            children: [
              _SideRail(items: items, current: _tab, onSelect: goTo),
              Expanded(child: body),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      extendBody: true,
      body: AppBackground(child: body),
      bottomNavigationBar: _BottomBar(items: items, current: _tab, onSelect: goTo),
    );
  }

  List<(AppTab, DwIcons, String)> _items(AppLocalizations l) => [
    (AppTab.today, DwIcons.home, l.navToday),
    (AppTab.exercises, DwIcons.grid, l.navExercises),
    (AppTab.eyes, DwIcons.eye, l.navEyes),
    (AppTab.nutrition, DwIcons.leaf, l.navNutrition),
    (AppTab.progress, DwIcons.chart, l.navProgress),
  ];
}

/// Fades a tab in whenever it becomes active.
class _FadeIn extends StatelessWidget {
  const _FadeIn({required this.active, required this.child});

  final bool active;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: active ? 1 : 0,
    duration: const Duration(milliseconds: 320),
    child: AnimatedSlide(
      offset: active ? Offset.zero : const Offset(0, 0.015),
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
      child: child,
    ),
  );
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.items, required this.current, required this.onSelect});

  final List<(AppTab, DwIcons, String)> items;
  final AppTab current;
  final ValueChanged<AppTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(14, 0, 14, bottom + 12),
      child: MaxWidth(
        maxWidth: 560,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 74,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.surface.withValues(alpha: 0.72),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                children: [
                  for (final (tab, icon, label) in items)
                    Expanded(
                      child: _NavItem(icon: icon, label: label, selected: tab == current, onTap: () => onSelect(tab)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  final DwIcons icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      scale: 0.9,
      child: Semantics(
        selected: selected,
        button: true,
        label: label,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              width: selected ? 52 : 40,
              height: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                gradient: selected ? AppGradients.primary : null,
                boxShadow: selected
                    ? [BoxShadow(color: AppColors.teal.withValues(alpha: 0.5), blurRadius: 16, spreadRadius: -4)]
                    : null,
              ),
              alignment: Alignment.center,
              child: DwIcon(icon, size: 22, color: selected ? AppColors.bg : AppColors.textMuted, strokeWidth: 2.1),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: selected ? AppColors.textPrimary : AppColors.textMuted,
                letterSpacing: 0.2,
              ),
              child: Text(label, maxLines: 1, overflow: TextOverflow.fade, softWrap: false),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideRail extends StatelessWidget {
  const _SideRail({required this.items, required this.current, required this.onSelect});

  final List<(AppTab, DwIcons, String)> items;
  final AppTab current;
  final ValueChanged<AppTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final wide = context.rs.width >= 1200;
    final short = context.rs.height < 520;
    return SafeArea(
      right: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: wide ? 220 : 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.surface.withValues(alpha: 0.65),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: LayoutBuilder(
                builder: (context, c) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: c.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!short) ...[
                            const SizedBox(height: 16),
                            const LogoMark(size: 48, glow: false),
                            const SizedBox(height: 22),
                          ],
                          for (final (tab, icon, label) in items)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: short ? 2 : 5, horizontal: 10),
                              child: wide
                                  ? _WideRailItem(
                                      icon: icon,
                                      label: label,
                                      selected: tab == current,
                                      onTap: () => onSelect(tab),
                                    )
                                  : SizedBox(
                                      height: short ? 60 : 66,
                                      child: _NavItem(
                                        icon: icon,
                                        label: label,
                                        selected: tab == current,
                                        onTap: () => onSelect(tab),
                                      ),
                                    ),
                            ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WideRailItem extends StatelessWidget {
  const _WideRailItem({required this.icon, required this.label, required this.selected, required this.onTap});

  final DwIcons icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: selected ? AppGradients.primary : null,
        ),
        child: Row(
          children: [
            DwIcon(icon, size: 24, color: selected ? AppColors.bg : AppColors.textSecondary),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: selected ? AppColors.bg : AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
