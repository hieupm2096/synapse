import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/chat.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/provider/current_conversation_provider.dart';
import 'package:synapse/feature/conversation/provider/current_llm_provider.dart';

class ConversationItem extends ConsumerWidget {
  const ConversationItem({
    required this.conversation,
    super.key,
  });

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLLM = ref.watch(currentLLMNotifierProvider);

    final currentConversationNotifier =
        currentConversationProvider(llmId: currentLLM ?? '');

    final currentConversationId = ref.watch(
      currentConversationNotifier.select((asyncData) => asyncData.value?.id),
    );

    ref.listen(
      currentConversationNotifier,
      (previous, next) {
        if (next.isLoading) {
          // TODO(hieupm): show full screen loading or what?
        } else if (next.hasValue && next.value != null) {
          context.go(ChatPage.route);
        } else {
          context.shadToaster.show(
            const ShadToast.destructive(
              title: Text('Uh oh! Something went wrong'),
              description: Text('There was a problem with your request'),
              showCloseIconOnlyWhenHovered: false,
            ),
          );
        }
      },
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ShadButton.ghost(
            onPressed: () {
              ref
                  .read(currentConversationNotifier.notifier)
                  .setCurrentConversation(data: conversation);
            },
            padding: const EdgeInsets.only(left: 10),
            size: ShadButtonSize.lg,
            backgroundColor: currentConversationId == conversation.id
                ? context.shadColor.secondary
                : null,
            text: Expanded(
              child: Text(
                conversation.title ?? 'New chat',
                style: context.shadTextTheme.list,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                softWrap: false,
              ),
            ),
          ),
        ),
        ShadButton.ghost(
          onPressed: () {
            // TODO(hieupm): show popover with rename and remove action
          },
          size: ShadButtonSize.icon,
          icon: const Icon(
            LucideIcons.ellipsis,
            size: 16,
          ),
        ),
      ],
    );
  }
}
