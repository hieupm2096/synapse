import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/app/provider/provider.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/widget/conversation_item_action.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    required this.conversation,
    super.key,
  });

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final currentLlmId = ref.read(currentLlmProvider).value?.id;

              final currentConversationId = ref
                  .watch(currentConversationProvider(llmId: currentLlmId))
                  .value
                  ?.id;

              return ShadButton.ghost(
                onPressed: () {
                  ref
                      .read(
                        currentConversationProvider(llmId: currentLlmId)
                            .notifier,
                      )
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
              );
            },
          ),
        ),
        ConversationItemAction(data: conversation),
      ],
    );
  }
}
