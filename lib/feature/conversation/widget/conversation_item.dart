import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/provider/current_conversation_provider.dart';
import 'package:synapse/feature/conversation/widget/conversation_item_action.dart';

class ConversationItem extends ConsumerStatefulWidget {
  const ConversationItem({
    required this.conversation,
    super.key,
  });

  final ConversationModel conversation;

  @override
  ConsumerState<ConversationItem> createState() => _ConversationItemState();
}

class _ConversationItemState extends ConsumerState<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    final currentLlmId = ref.watch(
      currentLlmModelProvider.select((asyncValue) => asyncValue.value?.id),
    );

    final currentConversationAsyncNotifier =
        currentConversationProvider(llmId: currentLlmId);

    final currentConversationId = ref.watch(
      currentConversationAsyncNotifier.select(
        (asyncData) => asyncData.value?.id,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ShadButton.ghost(
            onPressed: () {
              ref
                  .read(currentConversationAsyncNotifier.notifier)
                  .setCurrentConversation(data: widget.conversation);
            },
            padding: const EdgeInsets.only(left: 10),
            size: ShadButtonSize.lg,
            backgroundColor: currentConversationId == widget.conversation.id
                ? context.shadColor.secondary
                : null,
            text: Expanded(
              child: Text(
                widget.conversation.title ?? 'New chat',
                style: context.shadTextTheme.list,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                softWrap: false,
              ),
            ),
          ),
        ),
        ConversationItemAction(data: widget.conversation),
      ],
    );
  }
}
