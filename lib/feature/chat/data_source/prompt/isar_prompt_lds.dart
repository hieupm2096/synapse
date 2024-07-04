import 'package:isar/isar.dart';
import 'package:synapse/feature/chat/data_source/prompt/prompt_lds.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';

final class IsarPromptLDS implements IPromptLDS {
  const IsarPromptLDS({required this.client});

  final Isar client;

  @override
  Future<PromptModel> createPrompt({required PromptModel data}) {
    // TODO: implement createPrompt
    throw UnimplementedError();
  }

  @override
  Future<List<PromptModel>> getExamplePrompts() {
    // TODO: implement getExamplePrompts
    throw UnimplementedError();
  }

  @override
  Future<List<PromptModel>> getPrompts({required int conversationId}) {
    // TODO: implement getPrompts
    throw UnimplementedError();
  }
}
