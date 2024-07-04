import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/extension/build_context_ext.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    this.content,
    this.contentWidget,
    this.onPressed,
    this.onLongPressed,
    this.isLeft = true,
  });

  factory ChatBubble.left({
    Key? key,
    String? content,
    Widget? child,
    VoidCallback? onPressed,
    VoidCallback? onLongPressed,
  }) =>
      ChatBubble(
        key: key,
        content: content,
        contentWidget: child,
        onPressed: onPressed,
        onLongPressed: onLongPressed,
      );

  factory ChatBubble.right({
    Key? key,
    String? content,
    Widget? contentWidget,
    VoidCallback? onPressed,
    VoidCallback? onLongPressed,
  }) =>
      ChatBubble(
        key: key,
        content: content,
        contentWidget: contentWidget,
        onPressed: onPressed,
        onLongPressed: onLongPressed,
        isLeft: false,
      );

  final String? content;
  final Widget? contentWidget;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: isLeft ? 0 : 24,
        right: isLeft ? 24 : 0,
      ),
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: ShadButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
        size: ShadButtonSize.lg,
        backgroundColor:
            isLeft ? context.shadColor.background : context.shadColor.secondary,
        foregroundColor: context.shadColor.primary,
        hoverBackgroundColor: isLeft
            ? context.shadColor.background
            : context.shadColor.secondary.withOpacity(0.5),
        // hoverForegroundColor: context.shadColor.primary.withOpacity(0.5),

        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: ShadDecoration(
          border: ShadBorder(
            color: context.shadColor.border,
            radius: BorderRadius.circular(20),
          ),
        ),
        text: contentWidget ??
            Text(
              content ?? '',
              style: context.shadTextTheme.list,
            ),
      ),
    );
  }
}
