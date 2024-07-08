import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatAppBar extends AppBar {
  ChatAppBar({
    super.key,
    this.onLeadingPressed,
    super.title,
    this.onSettingPressed,
    this.onModelPressed,
  });

  final VoidCallback? onLeadingPressed;
  final VoidCallback? onSettingPressed;
  final VoidCallback? onModelPressed;

  @override
  double? get leadingWidth => 50;

  @override
  double? get scrolledUnderElevation => 0;

  @override
  Widget? get leading => ShadButton.ghost(
        icon: const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(
            LucideIcons.columns2,
            size: 24,
          ),
        ),
        onPressed: onLeadingPressed,
      );

  @override
  List<Widget>? get actions => [
        ShadButton.ghost(
          icon: const Icon(
            LucideIcons.settings,
            size: 24,
          ),
          onPressed: onSettingPressed,
        ),
      ];

  @override
  PreferredSizeWidget? get bottom => const PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: Divider(height: 0.1),
      );
}
