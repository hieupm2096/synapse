import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_result/simple_result.dart';
import 'package:synapse/app/constant/constant.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/data_source/conversation_lds/conversation_lds.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';

part 'conversation_repository.g.dart';

@Riverpod(keepAlive: true)
ConversationRepository conversationRepository(ConversationRepositoryRef ref) {
  return ConversationRepository(
    conversationLDS: ref.read(conversationLDSProvider),
  );
}

final class ConversationRepository {
  const ConversationRepository({required IConversationLDS conversationLDS})
      : _conversationLDS = conversationLDS;

  final IConversationLDS _conversationLDS;

  Future<Result<List<ConversationModel>, Exception>> getConversations({
    String? llmId,
  }) async {
    try {
      final res = await _conversationLDS.getConversations(llmId: llmId);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<ConversationModel?, Exception>> getRecentConversation({
    required String llmId,
  }) async {
    try {
      final res = await _conversationLDS.getRecentConversation(llmId: llmId);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<ConversationModel, Exception>> updateRecentConversation({
    required ConversationModel data,
  }) async {
    try {
      final newData = data.copyWith(
        updatedAt: DateTime.now(),
      );

      final res = await _conversationLDS.updateConversation(data: newData);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<ConversationModel, Exception>> updateConversation({
    required ConversationModel data,
  }) async {
    try {
      final res = await _conversationLDS.updateConversation(data: data);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<ConversationModel, Exception>> createConversation({
    required String userId,
    required String llmId,
  }) async {
    try {
      final createdDate = DateTime.now();

      final res = await _conversationLDS.createConversation(
        data: ConversationModel(
          title: createdDate.format(Constant.ddMMyyyyHHmm),
          createdAt: createdDate,
          updatedAt: createdDate,
          llmId: llmId,
          createdBy: userId,
        ),
      );

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<ConversationModel, Exception>> removeConversation({
    required int id,
  }) async {
    try {
      final res = await _conversationLDS.removeConversation(id: id);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
