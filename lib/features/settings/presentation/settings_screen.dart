import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/icons/dw_icons.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/icon_badge.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/tag_chip.dart';
import '../application/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const version = '1.0.0';

  Future<void> _confirmReset(BuildContext context) async {
    final l = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(l.resetConfirmTitle),
        content: Text(l.resetConfirmBody, style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.resetAction),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) await AppScope.read(context).progress.reset();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context).textTheme;
    final rs = context.rs;
    final s = context.settings;

    Widget section(DwIcons icon, Color color, String title, Widget child, {String? subtitle}) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(icon: icon, color: color, size: 42),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: t.titleMedium),
                      if (subtitle != null) Text(subtitle, style: t.bodySmall!.copyWith(color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );

    Widget langRow(String label, bool selected, VoidCallback onTap) => Pressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: selected ? AppColors.violet.withValues(alpha: 0.18) : Colors.white.withValues(alpha: 0.04),
          border: Border.all(color: selected ? AppColors.violet : Colors.transparent),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: t.titleSmall)),
            AnimatedOpacity(
              opacity: selected ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: const DwIcon(DwIcons.check, color: AppColors.violet, size: 22),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppTopBar(title: l.settingsTitle),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(rs.pad, 4, rs.pad, 30),
                  child: MaxWidth(
                    maxWidth: 760,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        section(
                          DwIcons.globe,
                          AppColors.violet,
                          l.languageLabel,
                          Column(
                            children: [
                              langRow(l.languageSystem, s.localeCode == null, () => s.setLocaleCode(null)),
                              for (final loc in LocaleResolver.supported)
                                langRow(
                                  LocaleResolver.nativeName(loc),
                                  s.localeCode == loc.languageCode,
                                  () => s.setLocaleCode(loc.languageCode),
                                ),
                            ],
                          ),
                        ),
                        section(
                          DwIcons.target,
                          AppColors.teal,
                          l.dailyGoalLabel,
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (final g in SettingsController.goalOptions)
                                TagChip(
                                  label: l.minutesShort(g),
                                  color: AppColors.teal,
                                  large: true,
                                  selected: s.dailyGoalMin == g,
                                  onTap: () => s.setDailyGoal(g),
                                ),
                            ],
                          ),
                        ),
                        section(
                          DwIcons.bell,
                          AppColors.coral,
                          l.breakReminderLabel,
                          subtitle: l.breakReminderDesc,
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (final b in SettingsController.breakOptions)
                                TagChip(
                                  label: l.everyMinutes(b),
                                  color: AppColors.coral,
                                  large: true,
                                  selected: s.breakIntervalMin == b,
                                  onTap: () => s.setBreakInterval(b),
                                ),
                            ],
                          ),
                        ),
                        section(
                          DwIcons.drop,
                          AppColors.sky,
                          l.waterGoalSetting,
                          Row(
                            children: [
                              Expanded(child: Text(l.glassesCount(s.waterGoal), style: t.headlineSmall)),
                              Pressable(
                                onTap: () => s.setWaterGoal(s.waterGoal - 1),
                                child: const IconBadge(icon: DwIcons.minus, color: AppColors.sky, size: 44),
                              ),
                              const SizedBox(width: 10),
                              Pressable(
                                onTap: () => s.setWaterGoal(s.waterGoal + 1),
                                child: const IconBadge(icon: DwIcons.plus, color: AppColors.sky, size: 44, solid: true),
                              ),
                            ],
                          ),
                        ),
                        section(
                          DwIcons.info,
                          AppColors.blue,
                          l.aboutTitle,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l.aboutBody, style: t.bodyMedium),
                              const SizedBox(height: 14),
                              Text(l.disclaimerTitle, style: t.titleSmall!.copyWith(color: AppColors.amber)),
                              const SizedBox(height: 4),
                              Text(l.disclaimerBody, style: t.bodyMedium!.copyWith(color: AppColors.textSecondary)),
                              const SizedBox(height: 14),
                              Text(l.sourcesTitle, style: t.titleSmall!.copyWith(color: AppColors.teal)),
                              const SizedBox(height: 4),
                              Text(l.sourcesBody, style: t.bodyMedium!.copyWith(color: AppColors.textSecondary)),
                              const SizedBox(height: 14),
                              Text(l.versionLabel(version), style: t.bodySmall!.copyWith(color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                        Pressable(
                          onTap: () => _confirmReset(context),
                          child: GlassCard(
                            borderColor: AppColors.danger,
                            child: Row(
                              children: [
                                const IconBadge(icon: DwIcons.restart, color: AppColors.danger, size: 42),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(l.resetProgress, style: t.titleMedium!.copyWith(color: AppColors.danger)),
                                ),
                                const DwIcon(DwIcons.chevronRight, color: AppColors.danger),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
