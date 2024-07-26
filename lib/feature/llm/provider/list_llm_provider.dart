import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/repository/llm_repository.dart';

part 'list_llm_provider.g.dart';

@riverpod
class ListLLMAsyncNotifier extends _$ListLLMAsyncNotifier {
  @override
  FutureOr<List<LlmModel>> build() async {
    final res = await ref.read(llmRepositoryProvider).getLlmModels();

    // cache result
    const cacheDuration = kDebugMode ? Duration.zero : Duration(minutes: 15);
    ref.cacheFor(cacheDuration);

    return res.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  Future<void> updateLlmModel({required LlmModel data}) async {
    state = const AsyncLoading();

    final listLlm = state.value ?? [];

    final foundIndex = listLlm.indexWhere((element) => element.id == data.id);

    if (foundIndex == -1) return;

    listLlm[foundIndex] = data;

    state = AsyncData(listLlm);
  }

  Future<void> addLlmModel({required LlmModel data}) async {
    state = const AsyncLoading();

    final listLlm = (state.value ?? [])..add(data);

    state = AsyncData(listLlm);
  }
}
