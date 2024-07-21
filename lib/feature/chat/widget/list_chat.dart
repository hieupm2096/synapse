import 'package:flutter/material.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';
import 'package:synapse/feature/chat/widget/headline.dart';
import 'package:synapse/shared/widget/widget.dart';

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

        return ChatBubble(
          contentWidget: isNotEmpty ? null : const ChatGenerating(),
          content: isNotEmpty ? prompt.text : null,
          isLeft: !isHuman,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
