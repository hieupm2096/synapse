import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/widget/list_chat_container.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/shared/widget/page/chat_app_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static String route = '/';

  @override
  Widget build(BuildContext context) {
    final listConversationRoute = '$route${ListConversationPage.route}';

    return Scaffold(
      appBar: ChatAppBar(
        title: Text(
          'New Chat',
          style: context.shadTextTheme.h4,
        ),
        onLeadingPressed: () => context.go(listConversationRoute),
        onSettingPressed: () {
          logDebug('onSettingPressed');
        },
      ),
      body: const ListChatContainer(),
    );
  }
}
