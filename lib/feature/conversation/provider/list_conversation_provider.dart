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
}
