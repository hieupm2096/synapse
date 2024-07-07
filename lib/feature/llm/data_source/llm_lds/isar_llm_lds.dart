import 'package:isar/isar.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/data_source/llm_lds/llm_lds.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

final class IsarLlmLDS implements ILlmLDS {
  const IsarLlmLDS({required Isar client}) : _client = client;

  final Isar _client;

  @override
  Future<List<LlmModel>> getLlmModels() {
    return _client.llmModels.where().findAll();
  }

  @override
  Future<LlmModel> getLlmModel({required String llmId}) async {
    final res = await _client.llmModels.filter().idEqualTo(llmId).findFirst();

    if (res == null) throw Exception('not_found');

    return res;
  }

  @override
  Future<LlmModel> createLlmModel({required LlmModel data}) async {
    await _client.writeTxn(
      () async {
        await _client.llmModels.put(data);
      },
    );

    return data;
  }

  @override
  Future<void> createLlmModels({required List<LlmModel> data}) async {
    // TODO: implement createLlmModels
    await _client.writeTxn(
      () async {
        await _client.llmModels.putAll(data);
      },
    );
  }

  @override
  Future<LlmModel> removeLlmModel({required String llmId}) async {
    try {
      final llmModel = await getLlmModel(llmId: llmId);
      final res = await _client.llmModels.delete(llmId.fastHash);
      if (!res) throw Exception('unexpected');
      return llmModel;
    } on Exception {
      rethrow;
    }
  }
}
