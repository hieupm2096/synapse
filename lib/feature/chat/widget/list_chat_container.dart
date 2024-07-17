import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/feature/chat/provider/create_prompt_provider.dart';
import 'package:synapse/feature/chat/provider/list_prompt_provider.dart';
import 'package:synapse/feature/chat/provider/prompt_reply_provider.dart';
import 'package:synapse/feature/chat/provider/update_prompt_provider.dart';
import 'package:synapse/feature/chat/widget/list_chat.dart';
import 'package:synapse/feature/chat/widget/list_chat_error.dart';
import 'package:synapse/feature/chat/widget/list_chat_loading.dart';
import 'package:synapse/feature/chat/widget/type_and_send.dart';

class ListChatContainer extends ConsumerWidget {
  const ListChatContainer({
    required this.conversationId,
    super.key,
  });

  final int conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncListChat = ref.watch(listPromptProvider(conversationId));

    ref
      ..listen(
        createPromptProvider,
        (previous, next) {
          if (next.hasValue && next.value != null) {
            final prompt = next.value!;

            ref
                .read(listPromptProvider(conversationId).notifier)
                .createPrompt(data: prompt);

            final isHuman = prompt.isHuman ?? true;

            final llmModel = ref.read(currentLlmProvider).value;

            if (llmModel == null) return;

            // if the message is not from human, which means it's reply,
            // trigger inference
            if (!isHuman) {
              final message = previous?.value?.text;

              if (message == null) return;

              ref
                  .read(promptReplyProvider(id: prompt.id!).notifier)
                  .startInference(
                    message: message,
                    conversationId: conversationId,
                    llmModel: llmModel,
                  );
            } else {
              // if the message is from human, we create a blank reply using
              // createChatProvider

              ref.read(createPromptProvider.notifier).createPrompt(
                    text: 'Generating...',
                    createdBy: llmModel.id!,
                    conversationId: conversationId,
                    isHuman: false,
                  );
            }
          }
        },
      )
      ..listen(
        updatePromptProvider,
        (previous, next) {
          if (next.hasValue && next.value != null) {
            final prompt = next.value!;

            ref
                .read(listPromptProvider(conversationId).notifier)
                .updatePrompt(data: prompt);
          }
        },
      );

    return asyncListChat.when(
      data: (data) => Stack(
        children: [
          ListChat(data: data),

          // Typing
          const Align(
            alignment: Alignment.bottomCenter,
            child: TypeAndSend(),
          ),
        ],
      ),
      error: (error, stackTrace) => const ListChatError(),
      loading: () => const ListChatLoading(),
    );
  }
}
