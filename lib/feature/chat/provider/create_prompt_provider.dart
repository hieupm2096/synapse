import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';
import 'package:synapse/feature/chat/repository/prompt_repository.dart';

part 'create_prompt_provider.g.dart';

@riverpod
class CreatePrompt extends _$CreatePrompt {
  @override
  FutureOr<PromptModel?> build() => null;

  Future<void> createPrompt({
    required String text,
    required String createdBy,
    required int conversationId,
    required bool isHuman,
  }) async {
    final res = await ref.read(promptRepositoryProvider).createPrompt(
          data: PromptModel(
            text: text,
            createdBy: createdBy,
            conversationId: conversationId,
            createdAt: DateTime.now(),
            isHuman: isHuman,
          ),
        );

    res.when(
      success: (success) {
        state = AsyncData(success);
      },
      failure: (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
    );
  }

  Future<void> createPromptByPrompt({required PromptModel data}) async {
    final res =
        await ref.read(promptRepositoryProvider).createPrompt(data: data);

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
