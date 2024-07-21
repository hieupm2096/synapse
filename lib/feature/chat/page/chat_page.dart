import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';
import 'package:synapse/app/provider/provider.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/widget/list_chat_container.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/shared/widget/page/chat_app_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.conversationId,
    super.key,
  });

  static String route = ':id';

  final int conversationId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: ChatAppBar(
          title: Consumer(
            builder: (context, ref, child) {
              var title = 'New chat';

              final currentLlmId = ref.read(currentLlmProvider).value?.id;

              if (currentLlmId != null) {
                title = ref
                        .read(currentConversationProvider(llmId: currentLlmId))
                        .value
                        ?.title ??
                    title;
              }

              return Text(
                title,
                style: context.shadTextTheme.h4,
              );
            },
          ),
          onLeadingPressed: () => context.go(ListConversationPage.route),
          onSettingPressed: () {
            logDebug('onSettingPressed');
          },
        ),
        body: ListChatContainer(conversationId: conversationId),
        // bottomSheet: ,
      ),
    );
  }
}
