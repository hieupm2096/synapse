import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/data_source/prompt/isar_prompt_lds.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';

part 'prompt_lds.g.dart';

@Riverpod(keepAlive: true)
IPromptLDS promptLDS(PromptLDSRef ref) =>
    IsarPromptLDS(client: ref.read(isarProvider));

abstract interface class IPromptLDS {
  Future<List<PromptModel>> getPrompts({required int conversationId});

  Future<List<PromptModel>> getExamplePrompts();

  Future<PromptModel?> getPrompt({required int id});

  Future<PromptModel> createPrompt({required PromptModel data});

  Future<PromptModel> updatePrompt({required PromptModel data});
}
