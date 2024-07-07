import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/repository/conversation/conversation_repository.dart';

part 'current_conversation_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentConversation extends _$CurrentConversation {
  @override
  FutureOr<ConversationModel?> build({String? llmId}) async {
    if (llmId == null) return null;

    final result = await ref
        .read(conversationRepositoryProvider)
        .getRecentConversation(llmId: llmId);

    return result.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  Future<void> setCurrentConversation({
    required ConversationModel data,
  }) async {
    final newData = data.copyWith(
      updatedAt: DateTime.now(),
    );

    state = AsyncValue.data(newData);
  }
}
