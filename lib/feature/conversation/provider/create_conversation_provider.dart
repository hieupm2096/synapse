import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/repository/conversation/conversation_repository.dart';

part 'create_conversation_provider.g.dart';

@riverpod
class CreateConversation extends _$CreateConversation {
  @override
  FutureOr<ConversationModel?> build({String? llmId}) => null;

  Future<void> createConversation({
    required String userId,
  }) async {
    if (llmId == null) return;

    state = const AsyncLoading();

    final res =
        await ref.read(conversationRepositoryProvider).createConversation(
              llmId: llmId!,
              userId: userId,
            );

    state = res.when(
      success: (success) {
        return AsyncData(success);
      },
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
