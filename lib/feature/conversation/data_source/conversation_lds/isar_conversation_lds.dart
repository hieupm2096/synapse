import 'package:isar/isar.dart';
import 'package:synapse/feature/conversation/data_source/conversation_lds/conversation_lds.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';

final class IsarConversationLDS implements IConversationLDS {
  const IsarConversationLDS({required Isar client}) : _client = client;

  final Isar _client;

  @override
  Future<ConversationModel> createConversation({
    required ConversationModel data,
  }) async {
    await _client.writeTxn(
      () async {
        await _client.conversationModels.put(data);
      },
    );

    return data;
  }

  @override
  Future<ConversationModel> getConversation({required int id}) async {
    final res =
        await _client.conversationModels.filter().idEqualTo(id).findFirst();

    if (res == null) throw Exception('not_found');

    return res;
  }

  @override
  Future<List<ConversationModel>> getConversations({String? llmId}) {
    if (llmId != null) {
      return _client.conversationModels
          .filter()
          .llmIdEqualTo(llmId)
          .sortByUpdatedAtDesc()
          .findAll();
    }

    return _client.conversationModels.where().sortByUpdatedAtDesc().findAll();
  }

  @override
  Future<ConversationModel?> getRecentConversation({
    required String llmId,
  }) async {
    final res = await _client.conversationModels
        .filter()
        .llmIdEqualTo(llmId)
        .sortByUpdatedAtDesc()
        .limit(1)
        .findFirst();

    return res;
  }

  @override
  Future<ConversationModel> removeConversation({required int id}) async {
    final conversation = await getConversation(id: id);
    final res = await _client.conversationModels.delete(id);
    if (!res) throw Exception('unexpected');
    return conversation;
  }

  @override
  Future<ConversationModel> updateConversation({
    required ConversationModel data,
  }) async {
    await _client.writeTxn(
      () async {
        await _client.conversationModels.put(data);
      },
    );

    return data;
  }
}
