import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loggy/loggy.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/widget/chat_item_action.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    this.content,
    this.child,
    this.onPressed,
    this.isLeft = true,
  });

  factory ChatBubble.left({
    Key? key,
    String? content,
    Widget? child,
    VoidCallback? onPressed,
  }) =>
      ChatBubble(
        key: key,
        content: content,
        onPressed: onPressed,
        child: child,
      );

  factory ChatBubble.right({
    Key? key,
    String? content,
    Widget? child,
    VoidCallback? onPressed,
  }) =>
      ChatBubble(
        key: key,
        content: content,
        onPressed: onPressed,
        isLeft: false,
        child: child,
      );

  final String? content;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    final isEmpty = content?.isEmpty ?? true;

    return Container(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      padding: EdgeInsets.only(
        left: isLeft ? 0 : 24,
        right: isLeft ? 24 : 0,
      ),
      child: ChatItemAction(
        enabled: !isEmpty,
        onLongPressed: () {
          if (isEmpty) return;

          Clipboard.setData(ClipboardData(text: content!));
        },
        child: GestureDetector(
          onTap: () {
            logDebug('onChatPressed');
            FocusScope.of(context).unfocus();
            onPressed?.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isLeft
                  ? context.shadColor.background
                  : context.shadColor.accent,
              border: Border.all(
                color: isLeft
                    ? context.shadColor.border
                    : context.shadColor.border,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: child ??
                Text(
                  content ?? '',
                  style: context.shadTextTheme.list.copyWith(
                    color: isLeft
                        ? context.shadColor.primary
                        : context.shadColor.accentForeground,
                  ),
                  textAlign: TextAlign.start,
                ),
          ),
        ),
      ),
    );
  }
}
