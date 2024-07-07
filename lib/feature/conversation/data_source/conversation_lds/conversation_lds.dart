import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/data_source/conversation_lds/fixture_conversation_lds.dart';
import 'package:synapse/feature/conversation/data_source/conversation_lds/isar_conversation_lds.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';

part 'conversation_lds.g.dart';

@Riverpod(keepAlive: true)
IConversationLDS conversationLDS(ConversationLDSRef ref) =>
    IsarConversationLDS(client: ref.read(isarProvider));

@Riverpod(keepAlive: true)
IConversationLDS fixtureConversationLDS(FixtureConversationLDSRef ref) {
  return FixtureConversationLDS();
}

abstract interface class IConversationLDS {
  Future<List<ConversationModel>> getConversations({String? llmId});

  Future<ConversationModel?> getRecentConversation({required String llmId});

  Future<ConversationModel> getConversation({required int id});

  Future<ConversationModel> createConversation({
    required ConversationModel data,
  });

  Future<ConversationModel> updateConversation({
    required ConversationModel data,
  });

  Future<ConversationModel> removeConversation({
    required int id,
  });
}
