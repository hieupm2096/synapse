import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/data_source/llm_lds/isar_llm_lds.dart';
import 'package:synapse/feature/llm/data_source/llm_lds/json_llm_lds.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

part 'llm_lds.g.dart';

@Riverpod(keepAlive: true)
ILlmLDS llmLDS(LlmLDSRef ref) => IsarLlmLDS(client: ref.read(isarProvider));

@Riverpod(keepAlive: true)
ILlmLDS jsonLlmLDS(JsonLlmLDSRef ref) => JsonLlmLds();

abstract interface class ILlmLDS {
  Future<List<LlmModel>> getLlmModels();

  Future<LlmModel> getLlmModel({required String llmId});

  Future<LlmModel> createLlmModel({required LlmModel data});

  Future<void> createLlmModels({required List<LlmModel> data});

  Future<LlmModel> removeLlmModel({required String llmId});
}
