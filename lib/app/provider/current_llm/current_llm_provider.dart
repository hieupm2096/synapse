import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/repository/llm_repository.dart';

part 'current_llm_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentLlmModel extends _$CurrentLlmModel {
  @override
  FutureOr<LlmModel?> build() async {
    final res = await ref.read(llmRepositoryProvider).getCurrentLlmModel();
    return res.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  Future<void> setLlmModel(LlmModel llmModel) async {
    state = const AsyncLoading();

    final res = await ref
        .read(llmRepositoryProvider)
        .storeCurrentLlmModel(model: llmModel);

    state = res.when(
      success: (success) {
        return AsyncData(success);
      },
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
