import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_result/simple_result.dart';
import 'package:synapse/feature/conversation/data_source/conversation/conversation_lds.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';

part 'conversation_repository.g.dart';

@Riverpod(keepAlive: true)
ConversationRepository conversationRepository(ConversationRepositoryRef ref) =>
    ConversationRepository(ref);

final class ConversationRepository {
  const ConversationRepository(this.ref);

  final Ref ref;

  Future<Result<List<ConversationModel>, Exception>> getConversations({
    String? llmId,
  }) async {
    try {
      final res = await ref
          .read(conversationLDSProvider)
          .getConversations(llmId: llmId);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<ConversationModel?, Exception>> getRecentConversation({
    required String llmId,
  }) async {
    try {
      final res = await ref
          .read(conversationLDSProvider)
          .getRecentConversation(llmId: llmId);

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

      final res = await ref
          .read(conversationLDSProvider)
          .updateConversation(data: newData);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<ConversationModel, Exception>> createConversation({
    required String llmId,
  }) async {
    try {
      // TODO(hieupm): get current login user or anonymous user and apply to
      // created by field

      final res = await ref.read(conversationLDSProvider).createConversation(
            data: ConversationModel(
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              llmId: llmId,
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
      final res =
          await ref.read(conversationLDSProvider).removeConversation(id: id);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
