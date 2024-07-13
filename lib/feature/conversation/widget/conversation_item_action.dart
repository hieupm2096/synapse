import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/provider/list_conversation_provider.dart';

class ConversationItemAction extends ConsumerStatefulWidget {
  const ConversationItemAction({
    required this.data,
    super.key,
  });

  final ConversationModel data;

  @override
  ConsumerState<ConversationItemAction> createState() =>
      _ConversationItemActionState();
}

class _ConversationItemActionState
    extends ConsumerState<ConversationItemAction> {
  final _controller = ShadPopoverController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLlmId =
        ref.watch(currentLlmModelProvider.select((value) => value.value?.id));

    final listConversationAsyncNotifier =
        listConversationAsyncNotifierProvider(llmId: currentLlmId);

    void onRename() {
      _controller.toggle();

      final titleController = TextEditingController(text: widget.data.title);

      showShadDialog<dynamic>(
        context: context,
        builder: (dialogContext) => ShadDialog(
          removeBorderRadiusWhenTiny: false,
          radius: BorderRadius.circular(12),
          constraints: BoxConstraints(
            maxWidth: context.mediaQuery.size.width - 48,
          ),
          actionsAxis: Axis.horizontal,
          actionsMainAxisAlignment: MainAxisAlignment.end,
          title: const Text('Rename'),
          content: ShadInput(controller: titleController),
          actions: [
            ShadButton(
              width: 120,
              text: const Text('Save'),
              onPressed: () {
                final newTitle = titleController.text;

                titleController.dispose();

                dialogContext.pop();

                final newData = widget.data.copyWith(title: newTitle);

                ref
                    .read(listConversationAsyncNotifier.notifier)
                    .updateConversation(data: newData);
              },
            ),
          ],
        ),
      );
    }

    void onRemove() {
      _controller.toggle();

      showShadDialog<dynamic>(
        context: context,
        builder: (dialogContext) => ShadDialog.alert(
          removeBorderRadiusWhenTiny: false,
          radius: BorderRadius.circular(12),
          // padding: const EdgeInsets.all(32),
          constraints: BoxConstraints(
            maxWidth: context.mediaQuery.size.width - 48,
          ),
          actionsAxis: Axis.horizontal,
          actionsMainAxisAlignment: MainAxisAlignment.center,
          title: const Text('Are you absolutely sure?'),
          description: const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'This action cannot be undone. '
              'This will permanently delete your conversation.',
            ),
          ),
          actions: [
            ShadButton.ghost(
              width: 120,
              text: const Text('Cancel'),
              onPressed: dialogContext.pop,
            ),
            ShadButton.destructive(
              width: 120,
              text: const Text('Delete'),
              onPressed: () {
                dialogContext.pop();

                ref
                    .read(listConversationAsyncNotifier.notifier)
                    .removeConversation(id: widget.data.id!);
              },
            ),
          ],
        ),
      );
    }

    return ShadPopover(
      controller: _controller,
      padding: EdgeInsets.zero,
      showDuration: const Duration(milliseconds: 100),
      waitDuration: const Duration(milliseconds: 100),
      decoration: ShadDecoration(
        border: ShadBorder(radius: BorderRadius.circular(12)),
      ),
      popover: (context) {
        return Column(
          children: [
            ShadButton.ghost(
              onPressed: onRename,
              width: 120,
              text: const Text('Rename'),
              icon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  LucideIcons.pen,
                  size: 16,
                ),
              ),
            ),
            ShadButton.ghost(
              onPressed: onRemove,
              width: 120,
              foregroundColor: context.shadColor.destructive,
              hoverForegroundColor: context.shadColor.destructive,
              text: const Text('Delete'),
              icon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  LucideIcons.trash2,
                  size: 16,
                ),
              ),
            ),
          ],
        );
      },
      child: ShadButton.ghost(
        onPressed: _controller.toggle,
        icon: const Icon(
          LucideIcons.ellipsisVertical,
          size: 16,
        ),
      ),
    );
  }
}
