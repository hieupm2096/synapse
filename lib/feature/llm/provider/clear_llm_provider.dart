import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';
import 'package:synapse/feature/llm/repository/llm_repository.dart';

part 'clear_llm_provider.g.dart';

@Riverpod(keepAlive: true)
class ClearLlm extends _$ClearLlm {
  @override
  FutureOr<bool> build() => false;

  Future<void> clearLlm(String id, String relativePath) async {
    state = const AsyncLoading();

    final directory = await getApplicationDocumentsDirectory();

    final absolutePath = '${directory.path}/$relativePath';

    final file = File(absolutePath);

    if (file.existsSync()) {
      await file.delete();
    }

    final res = await ref
        .read(llmRepositoryProvider)
        .updateLlmModel(id: id, relativePath: '');

    state = res.when(
      success: (success) {
        // reflect to the UI
        ref
            .read(listLLMAsyncNotifierProvider.notifier)
            .updateLlmModel(data: success);

        return const AsyncData(true);
      },
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
