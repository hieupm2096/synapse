import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/data_source/conversation/isar_conversation_lds.dart';
import 'package:synapse/feature/chat/model/conversation_model/conversation_model.dart';

part 'conversation_lds.g.dart';

@Riverpod(keepAlive: true)
IConversationLDS conversationLDS(ConversationLDSRef ref) {
  final asyncIsar = ref.watch(isarProvider);

  return switch (asyncIsar) {
    AsyncData(:final value) => IsarConversationLDS(client: value),
    _ => throw Exception('client is not loaded'),
  };
}

abstract interface class IConversationLDS {
  Future<List<ConversationModel>> getConversations({required String llmId});

  Future<ConversationModel> getRecentConversation({required String llmId});

  Future<ConversationModel> getConversation({required String id});

  Future<ConversationModel> createConversation({
    required ConversationModel data,
  });

  Future<ConversationModel> updateConversation({
    required ConversationModel data,
  });

  Future<bool> removeConversation({
    required String id,
  });
}
