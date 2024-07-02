import 'package:isar/isar.dart';
import 'package:synapse/feature/chat/data_source/conversation/conversation_lds.dart';
import 'package:synapse/feature/chat/model/conversation_model/conversation_model.dart';

final class IsarConversationLDS implements IConversationLDS {
  const IsarConversationLDS({
    required this.client,
  });

  final Isar client;

  @override
  Future<ConversationModel> createConversation({
    required ConversationModel data,
  }) async {
    await client.writeTxn(
      () async {
        await client.conversationModels.put(data);
      },
    );

    return data;
  }

  @override
  Future<ConversationModel> getConversation({required String id}) {
    // TODO: implement getConversation
    throw UnimplementedError();
  }

  @override
  Future<List<ConversationModel>> getConversations({required String llmId}) {
    // TODO: implement getConversations
    throw UnimplementedError();
  }

  @override
  Future<ConversationModel> getRecentConversation({required String llmId}) {
    // TODO: implement getRecentConversation
    throw UnimplementedError();
  }

  @override
  Future<bool> removeConversation({required String id}) {
    // TODO: implement removeConversation
    throw UnimplementedError();
  }

  @override
  Future<ConversationModel> updateConversation({
    required ConversationModel data,
  }) {
    // TODO: implement updateConversation
    throw UnimplementedError();
  }
}
