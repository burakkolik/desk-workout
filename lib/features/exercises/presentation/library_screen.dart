import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/entrance.dart';
import '../../../core/widgets/icon_badge.dart';
import '../../../core/widgets/responsive_grid.dart';
import '../../../core/widgets/tag_chip.dart';
import '../data/exercise_catalog.dart';
import '../domain/exercise_category.dart';
import 'widgets/exercise_card.dart';

/// Browse all exercises, filterable by category.
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key, this.initialCategory, this.standalone = false});

  final ExerciseCategory? initialCategory;

  /// Pushed as its own page (shows a back button + background).
  final bool standalone;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late ExerciseCategory? _filter = widget.initialCategory;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final rs = context.rs;
    final t = Theme.of(context).textTheme;
    final cats = _filter == null ? ExerciseCategory.values : [_filter!];
    final bottomPad = widget.standalone ? 40.0 : 120.0;

    final content = CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.standalone) const AppTopBar(),
                MaxWidth(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(rs.pad, widget.standalone ? 4 : 20, rs.pad, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.libraryTitle, style: t.displaySmall),
                        const SizedBox(height: 6),
                        Text(l.librarySubtitle, style: t.bodyLarge!.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: rs.pad),
                    children: [
                      TagChip(
                        label: l.filterAll,
                        color: AppColors.teal,
                        large: true,
                        selected: _filter == null,
                        onTap: () => setState(() => _filter = null),
                      ),
                      for (final c in ExerciseCategory.values)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TagChip(
                            label: c.label(l),
                            icon: c.icon,
                            color: c.color,
                            large: true,
                            selected: _filter == c,
                            onTap: () => setState(() => _filter = c),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        for (final c in cats)
          SliverToBoxAdapter(
            key: ValueKey('${_filter?.name}-${c.name}'),
            child: MaxWidth(
              child: Padding(
                padding: EdgeInsets.fromLTRB(rs.pad, 26, rs.pad, 0),
                child: Entrance(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconBadge(icon: c.icon, color: c.color, size: 46),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.label(l), style: t.headlineSmall),
                                Text(
                                  '${c.description(l)} · ${l.exercisesCount(ExerciseCatalog.byCategory(c).length)}',
                                  style: t.bodyMedium!.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                        minItemWidth: rs.isCompact ? 150 : 210,
                        maxColumns: 6,
                        spacing: 14,
                        children: [for (final e in ExerciseCatalog.byCategory(c)) ExerciseCard(exercise: e)],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        SliverToBoxAdapter(child: SizedBox(height: bottomPad)),
      ],
    );
    if (!widget.standalone) return content;
    return Scaffold(body: AppBackground(child: content));
  }
}
