import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapse/app/provider/provider.dart';
import 'package:synapse/core/extension/ext.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
import 'package:synapse/feature/chat/provider/create_prompt_provider.dart';
import 'package:synapse/feature/chat/provider/list_prompt_provider.dart';
import 'package:synapse/feature/chat/provider/prompt_reply_provider.dart';
import 'package:synapse/feature/chat/widget/list_chat.dart';
import 'package:synapse/feature/chat/widget/list_chat_error.dart';
import 'package:synapse/feature/chat/widget/list_chat_loading.dart';
import 'package:synapse/feature/chat/widget/type_and_send.dart';
import 'package:uuid/uuid.dart';

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

            final isHuman = prompt.isHuman ?? true;

            final llmModelId = ref.read(currentLlmProvider).value?.id;

            if (llmModelId == null) return;

            if (isHuman) {
              ref
                  .read(listPromptProvider(conversationId).notifier)
                  .createPrompt(data: prompt);

              final reply = PromptModel(
                conversationId: conversationId,
                id: const Uuid().v4().fastHash,
                createdAt: DateTime.now(),
                createdBy: llmModelId,
                isHuman: false,
              );

              ref
                  .read(listPromptProvider(conversationId).notifier)
                  .createPrompt(data: reply);

              ref
                  .read(promptReplyProvider.notifier)
                  .startInference(id: reply.id!, message: prompt.text!);
            }
          }
        },
      )
      ..listen(
        promptReplyProvider,
        (previous, next) {
          final id = next.id;
          final isDone = next.status == PromptReplyStatus.done;

          if (id != null) {
            final reply = ref
                .read(listPromptProvider(conversationId))
                .value
                ?.firstWhereOrNull((e) => e.id == next.id);

            if (reply == null) return;

            final newReply = reply.copyWith(text: next.message);

            ref
                .read(listPromptProvider(conversationId).notifier)
                .updatePrompt(data: newReply);

            if (isDone) {
              ref
                  .read(createPromptProvider.notifier)
                  .createPromptByPrompt(data: newReply);
            }
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
