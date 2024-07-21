import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatItemAction extends StatefulWidget {
  const ChatItemAction({
    required this.enabled,
    super.key,
    this.child,
    this.onLongPressed,
  });

  final Widget? child;
  final bool enabled;
  final VoidCallback? onLongPressed;

  @override
  State<ChatItemAction> createState() => _ChatItemActionState();
}

class _ChatItemActionState extends State<ChatItemAction> {
  final _controller = ShadPopoverController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: _controller,
      padding: EdgeInsets.zero,
      decoration: ShadDecoration(
        border: ShadBorder(radius: BorderRadius.circular(12)),
      ),
      popover: (popoverContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton.ghost(
              onPressed: () async {
                _controller.toggle();

                // copy
                widget.onLongPressed?.call();
              },
              width: 150,
              text: const Expanded(
                child: Text(
                  'Copy',
                  textAlign: TextAlign.start,
                ),
              ),
              icon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(LucideIcons.copy, size: 16),
              ),
            ),
          ],
        );
      },
      child: GestureDetector(
        onLongPress: widget.enabled
            ? () {
                logDebug('onLongPressed');
                _controller.toggle();
              }
            : null,
        child: widget.child,
      ),
    );
  }
}
