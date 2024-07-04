import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';
import 'package:synapse/feature/chat/widget/headline.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/shared/widget/chat_app_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        title: Text(
          'New Chat',
          style: context.shadTextTheme.h4,
        ),
        onLeadingPressed: () => context.go(
          '$route${ListConversationPage.route}',
        ),
        onSettingPressed: () {
          logDebug('onSettingPressed');
        },
        onModelPressed: () {
          logDebug('onModelPressed');
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline(),
            ChatBubble.right(
              content: 'Yes of course, could you do that for me?',
            ),
          ],
        ),
      ),
    );
  }
}
