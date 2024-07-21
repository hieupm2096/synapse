import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_result/simple_result.dart';
import 'package:synapse/feature/chat/data_source/prompt/prompt_lds.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';

part 'prompt_repository.g.dart';

@Riverpod(keepAlive: true)
PromptRepository promptRepository(PromptRepositoryRef ref) {
  return PromptRepository(promptLDS: ref.read(promptLDSProvider));
}

final class PromptRepository {
  const PromptRepository({required IPromptLDS promptLDS})
      : _promptLDS = promptLDS;

  final IPromptLDS _promptLDS;

  Future<Result<List<PromptModel>, Exception>> getPrompts({
    required int conversationId,
  }) async {
    try {
      final res = await _promptLDS.getPrompts(conversationId: conversationId);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<PromptModel, Exception>> getPrompt({required int id}) async {
    try {
      final res = await _promptLDS.getPrompt(id: id);

      if (res == null) return Result.failure(Exception('not_found'));

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<PromptModel, Exception>> createPrompt({
    required PromptModel data,
  }) async {
    try {
      final res = await _promptLDS.createPrompt(data: data);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<PromptModel, Exception>> updatePrompt({
    required PromptModel data,
  }) async {
    try {
      final res = await _promptLDS.updatePrompt(data: data);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
