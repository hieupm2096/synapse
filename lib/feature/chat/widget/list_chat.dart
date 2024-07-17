import 'package:flutter/material.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
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
        88 + context.mediaQuery.viewPadding.bottom,
      ),
      itemCount: reversedData.length,
      itemBuilder: (context, index) {
        final prompt = reversedData[index];

        final isHuman = prompt.isHuman ?? true;

        return ChatBubble(
          content: prompt.text,
          isLeft: !isHuman,
        );

        // if (isHuman) {
        //   return ChatBubble(
        //     content: prompt.text,
        //     isLeft: false,
        //   );
        // }

        // return ChatBubble(
        //   contentWidget: Consumer(
        //     builder: (context, ref, child) {
        //       final reply =
        //           ref.watch(promptReplyProvider(id: prompt.id!));

        //       return Text(
        //         reply,
        //         style: context.shadTextTheme.list.copyWith(
        //           color: context.shadColor.primary,
        //         ),
        //         textAlign: TextAlign.start,
        //       );
        //     },
        //   ),
        // );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
