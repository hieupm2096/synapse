import 'package:isar/isar.dart';
import 'package:synapse/feature/chat/data_source/prompt/prompt_lds.dart';
import 'package:synapse/feature/chat/model/prompt_model/prompt_model.dart';

final class IsarPromptLDS implements IPromptLDS {
  const IsarPromptLDS({required Isar client}) : _client = client;

  final Isar _client;

  @override
  Future<PromptModel> createPrompt({required PromptModel data}) async {
    final res = await _client.writeTxn(
      () => _client.promptModels.put(data),
    );

    return data.copyWith(id: res);
  }

  @override
  Future<List<PromptModel>> getExamplePrompts() {
    throw UnimplementedError();
  }

  @override
  Future<List<PromptModel>> getPrompts({required int conversationId}) async {
    final res = await _client.promptModels
        .filter()
        .conversationIdEqualTo(conversationId)
        .sortByCreatedAt()
        .findAll();

    return res;
  }
}
