import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/repository/llm_repository.dart';

part 'pick_llm_provider.g.dart';

@riverpod
class PickLlm extends _$PickLlm {
  @override
  FutureOr<LlmModel?> build() => null;

  Future<void> pickLlm() async {
    state = const AsyncLoading();

    final res = await ref.read(filePickerProvider).pickFiles();

    final file = res?.files.firstOrNull;

    if (file == null) {
      state = AsyncError(Exception('not_found'), StackTrace.current);

      return;
    }

    if (!file.name.endsWith('.gguf')) {
      state = AsyncError(Exception('invalid'), StackTrace.current);
      return;
    }

    final model = LlmModel(
      id: file.name,
      author: 'user',
      modelId: file.name,
      path: file.path,
      size: file.size.getFileSize(),
      createdAt: DateTime.now(),
      lastModified: DateTime.now(),
    );

    final createRes =
        await ref.read(llmRepositoryProvider).createLlmModel(model: model);

    state = createRes.when(
      success: AsyncData.new,
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
