import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/conversation/repository/conversation/conversation_repository.dart';

part 'list_conversation_provider.g.dart';

@Riverpod(keepAlive: false)
class ListConversationAsyncNotifier extends _$ListConversationAsyncNotifier {
  @override
  FutureOr<List<ConversationModel>> build({String? llmId}) async {
    final res = await ref
        .read(conversationRepositoryProvider)
        .getConversations(llmId: llmId);

    // cache result
    const cacheDuration = kDebugMode ? Duration.zero : Duration(minutes: 15);
    ref.cacheFor(cacheDuration);

    return res.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  Future<void> removeConversation({required int id}) async {
    final res = await ref
        .read(conversationRepositoryProvider)
        .removeConversation(id: id);

    res.when(
      success: (success) {
        (state.value ?? []).removeWhere((element) => element.id == id);
        state = AsyncData(state.value ?? []);
      },
      failure: (failure) => throw failure,
    );
  }

  Future<void> updateConversation({
    required ConversationModel data,
  }) async {
    state = const AsyncLoading();

    final res = await ref
        .read(conversationRepositoryProvider)
        .updateConversation(data: data);

    res.when(
      success: (success) {
        final foundIndex =
            (state.value ?? []).indexWhere((element) => element.id == data.id);

        if (foundIndex == -1) return;

        (state.value ?? [])[foundIndex] = data;

        state = AsyncData(state.value ?? []);
      },
      failure: (failure) => throw failure,
    );
  }

  Future<void> addConversation({
    required ConversationModel conversation,
  }) async {
    state = const AsyncLoading();

    state = AsyncData([conversation, ...state.value ?? []]);
  }
}
