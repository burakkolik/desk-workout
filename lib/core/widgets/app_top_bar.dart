import 'package:flutter/material.dart';

import '../icons/dw_icons.dart';
import 'gradient_button.dart';

/// Minimal top bar used on pushed pages (custom back button + title).
class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key, this.title, this.trailing, this.onBack});

  final String? title;
  final Widget? trailing;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Row(
        children: [
          CircleIconButton(
            icon: DwIcons.chevronLeft,
            size: 48,
            onTap: onBack ?? () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: title == null
                ? const SizedBox()
                : Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
