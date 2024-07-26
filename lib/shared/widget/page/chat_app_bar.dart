import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatAppBar extends AppBar {
  ChatAppBar({
    super.key,
    this.showLeading = true,
    this.showSetting = true,
    this.onLeadingPressed,
    this.onSettingPressed,
    super.title,
  });

  final bool showLeading;
  final bool showSetting;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onSettingPressed;

  @override
  double? get leadingWidth => 50;

  @override
  double? get scrolledUnderElevation => 0;

  @override
  Widget? get leading => showLeading
      ? ShadButton.ghost(
          icon: const Icon(
            LucideIcons.columns2,
            size: 24,
          ),
          onPressed: onLeadingPressed,
        )
      : null;

  @override
  List<Widget>? get actions => showSetting
      ? [
          ShadButton.ghost(
            icon: const Icon(
              LucideIcons.settings,
              size: 24,
            ),
            onPressed: onSettingPressed,
          ),
        ]
      : null;

  @override
  PreferredSizeWidget? get bottom => const PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: Divider(height: 0.1),
      );
}
