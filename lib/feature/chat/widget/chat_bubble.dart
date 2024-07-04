import 'package:flutter/cupertino.dart';
import 'package:loggy/loggy.dart';
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
    return GestureDetector(
      onLongPress: () {
        logDebug('onLongPressed');
        // TODO(hieupm): show popover with copy action
      },
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0,
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.only(
            left: isLeft ? 0 : 24,
            right: isLeft ? 24 : 0,
          ),
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isLeft
                  ? context.shadColor.background
                  : context.shadColor.primary,
              border: Border.all(
                color: isLeft
                    ? context.shadColor.border
                    : context.shadColor.primary,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: contentWidget ??
                Text(
                  content ?? '',
                  style: context.shadTextTheme.list.copyWith(
                    color: isLeft
                        ? context.shadColor.primary
                        : context.shadColor.background,
                  ),
                  textAlign: isLeft ? TextAlign.start : TextAlign.end,
                ),
          ),
        ),
      ),
    );
  }
}
