import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapse/feature/chat/provider/create_prompt_provider.dart';
import 'package:synapse/feature/chat/provider/list_prompt_provider.dart';
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

    ref.listen(
      createPromptProvider,
      (previous, next) {
        if (next.hasValue) {
          final prompt = next.value;

          if (prompt == null) return;

          ref
              .read(ListPromptProvider(conversationId).notifier)
              .createPrompt(data: prompt);
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
