import 'package:flutter/material.dart';

import '../../../../app/app_scope.dart';
import '../../../../core/icons/dw_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/entrance.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/icon_badge.dart';
import '../../../../core/widgets/tag_chip.dart';
import '../../../settings/application/settings_controller.dart';

/// Final onboarding step: daily goal, break interval and language.
class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final s = context.settings;
    final rs = context.rs;
    final t = Theme.of(context).textTheme;

    Widget section(int i, DwIcons icon, Color color, String label, Widget child) => Entrance(
      index: i,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconBadge(icon: icon, color: color, size: 42),
                  const SizedBox(width: 14),
                  Expanded(child: Text(label, style: t.titleMedium)),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: rs.pad, vertical: 12),
      child: MaxWidth(
        maxWidth: 640,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.onbSetupTitle, style: t.displaySmall),
            const SizedBox(height: 8),
            Text(l.onbSetupBody, style: t.bodyLarge!.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 22),
            section(
              0,
              DwIcons.target,
              AppColors.teal,
              l.onbGoalLabel,
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
              1,
              DwIcons.bell,
              AppColors.coral,
              l.onbBreakLabel,
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
              2,
              DwIcons.globe,
              AppColors.violet,
              l.languageLabel,
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  TagChip(
                    label: l.languageSystem,
                    color: AppColors.violet,
                    large: true,
                    selected: s.localeCode == null,
                    onTap: () => s.setLocaleCode(null),
                  ),
                  for (final loc in LocaleResolver.supported)
                    TagChip(
                      label: LocaleResolver.nativeName(loc),
                      color: AppColors.violet,
                      large: true,
                      selected: s.localeCode == loc.languageCode,
                      onTap: () => s.setLocaleCode(loc.languageCode),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
