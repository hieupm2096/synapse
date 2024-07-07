import 'package:flutter/material.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/widget/conversation_item.dart';

class ListConversation extends StatelessWidget {
  ListConversation({
    required this.conversations,
    super.key,
  }) : assert(conversations.isNotEmpty, 'Conversations is empty');

  final List<ConversationModel> conversations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemBuilder: (context, index) {
        return ConversationItem(conversation: conversations[index]);
      },
      itemCount: conversations.length,
    );
  }
}
