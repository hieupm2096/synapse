import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/chat.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_container.dart';

class ListConversationPage extends StatelessWidget {
  const ListConversationPage({super.key});

  static String route = 'conversations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: ShadButton.ghost(
          icon: const Padding(
            padding: EdgeInsets.only(top: 6, left: 6),
            child: Icon(
              LucideIcons.arrowLeft,
              size: 24,
            ),
          ),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: Text(
          'Recent',
          style: context.shadTextTheme.h4,
        ),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            icon: const Icon(
              LucideIcons.squarePen,
              size: 20,
            ),
            onPressed: () => context.go(ChatPage.route),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(height: 0.1),
        ),
      ),
      body: const ListConversationContainer(),
    );
  }
}
