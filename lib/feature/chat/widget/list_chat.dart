import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapse/app/constant/constant.dart';
import 'package:synapse/app/provider/current_conversation/current_conversation_provider.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
import 'package:synapse/feature/chat/provider/create_prompt_provider.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';
import 'package:synapse/feature/chat/widget/headline.dart';

class ListChat extends StatelessWidget {
  const ListChat({
    required this.data,
    super.key,
  });

  final List<PromptModel> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer(
          builder: (context, ref, child) {
            return Headline(
              onFinished: ({message}) {
                final currentLlmId = ref.read(currentLlmProvider).value?.id;

                if (currentLlmId == null) return;

                final conversationId = ref
                    .read(currentConversationProvider(llmId: currentLlmId))
                    .value
                    ?.id;

                if (conversationId == null) return;

                final mess = message ?? Constant.defaultMessage;

                ref.read(createPromptProvider.notifier).createPrompt(
                      text: mess,
                      createdBy: currentLlmId,
                      conversationId: conversationId,
                      isHuman: false,
                    );
              },
            );
          },
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        88 + context.mediaQuery.viewPadding.bottom,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final prompt = data[index];

        return ChatBubble(
          content: prompt.text,
          isLeft: !(prompt.isHuman ?? true),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
