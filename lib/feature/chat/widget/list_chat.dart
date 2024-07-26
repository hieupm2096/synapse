import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
import 'package:synapse/feature/chat/provider/prompt_reply_provider.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';
import 'package:synapse/feature/chat/widget/chat_loading.dart';
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
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Headline(),
      );
    }

    final reversedData = data.reversed.toList();

    return ListView.separated(
      reverse: true,
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        114 + context.mediaQuery.viewPadding.bottom,
      ),
      itemCount: reversedData.length,
      itemBuilder: (context, index) {
        final prompt = reversedData[index];

        final isHuman = prompt.isHuman ?? true;

        final isNotEmpty = prompt.text?.isNotEmpty ?? false;

        if (isHuman) {
          return ChatBubble(content: prompt.text, isLeft: false);
        }

        return Consumer(
          builder: (context, ref, child) {
            final replyEntity = ref.watch(promptReplyProvider);

            final isCurrentReply = prompt.id == replyEntity.id;
            final isLoading =
                replyEntity.status == PromptReplyStatus.inProgress;

            if (!isCurrentReply) {
              return ChatBubble(
                content: isNotEmpty
                    ? prompt.text
                    : 'Error: Could not generate response',
              );
            }

            return ChatBubble(
              content: isNotEmpty ? prompt.text : null,
              child: (isLoading && !isNotEmpty) ? const ChatLoading() : null,
            );
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
