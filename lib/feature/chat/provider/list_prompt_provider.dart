import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
import 'package:synapse/feature/chat/repository/prompt_repository.dart';

part 'list_prompt_provider.g.dart';

@riverpod
class ListPrompt extends _$ListPrompt {
  @override
  FutureOr<List<PromptModel>> build(int conversationId) async {
    final res = await ref
        .read(promptRepositoryProvider)
        .getPrompts(conversationId: conversationId);

    // cache result
    const cacheDuration = kDebugMode ? Duration.zero : Duration(minutes: 15);
    ref.cacheFor(cacheDuration);

    return res.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  void createPrompt({required PromptModel data}) {
    state = const AsyncLoading();

    final prompts = (state.value ?? [])..add(data);

    state = AsyncData(prompts);
  }
}
