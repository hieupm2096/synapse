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
  bool? get centerTitle => false;

  @override
  Widget? get leading => ShadButton.ghost(
        icon: const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(
            LucideIcons.columns2,
            size: 24,
          ),
        ),
        size: ShadButtonSize.icon,
        onPressed: onLeadingPressed,
      );

  @override
  List<Widget>? get actions => [
        ShadButton.ghost(
          icon: const Icon(
            LucideIcons.settings,
            size: 24,
          ),
          size: ShadButtonSize.icon,
          onPressed: onSettingPressed,
        ),
      ];
}
