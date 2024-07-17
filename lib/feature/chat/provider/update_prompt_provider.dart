import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
import 'package:synapse/feature/chat/repository/prompt_repository.dart';

part 'update_prompt_provider.g.dart';

@riverpod
class UpdatePrompt extends _$UpdatePrompt {
  @override
  FutureOr<PromptModel?> build() => null;

  Future<void> updatePrompt({
    required int id,
    required String message,
  }) async {
    final getPromptRes =
        await ref.read(promptRepositoryProvider).getPrompt(id: id);

    if (getPromptRes.isFailure) {
      state = AsyncError(getPromptRes.failure!, StackTrace.current);
      return;
    }

    final prompt = getPromptRes.success!;

    final newPrompt = prompt.copyWith(text: message);

    final res =
        await ref.read(promptRepositoryProvider).updatePrompt(data: newPrompt);

    res.when(
      success: (success) {
        state = AsyncData(success);
      },
      failure: (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
    );
  }
}
