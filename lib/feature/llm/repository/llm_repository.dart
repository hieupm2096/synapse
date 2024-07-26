import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_result/simple_result.dart';
import 'package:synapse/app/constant/constant.dart';
import 'package:synapse/app/data_source/kvp_lds/kvp_lds.dart';
import 'package:synapse/feature/llm/data_source/llm_lds/llm_lds.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

part 'llm_repository.g.dart';

@Riverpod(keepAlive: true)
LlmRepository llmRepository(LlmRepositoryRef ref) => LlmRepository(
      llmLDS: ref.read(llmLDSProvider),
      jsonLlmLDS: ref.read(jsonLlmLDSProvider),
      kvpLDS: ref.read(kvpLDSProvider),
    );

final class LlmRepository {
  LlmRepository({
    required ILlmLDS llmLDS,
    required ILlmLDS jsonLlmLDS,
    required IKVPLocalDS kvpLDS,
  })  : _llmLDS = llmLDS,
        _jsonLlmLDS = jsonLlmLDS,
        _kvpLDS = kvpLDS;

  final ILlmLDS _llmLDS;
  final ILlmLDS _jsonLlmLDS;
  final IKVPLocalDS _kvpLDS;

  Future<Result<List<LlmModel>, Exception>> getLlmModels() async {
    try {
      final res = await _llmLDS.getLlmModels();

      if (res.isNotEmpty) return Result.success(res);

      // seeding data
      final data = await _jsonLlmLDS.getLlmModels();

      await _llmLDS.createLlmModels(data: data);

      return Result.success(data);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<LlmModel, Exception>> removeLlmModel({
    required String id,
  }) async {
    try {
      final res = await _llmLDS.removeLlmModel(llmId: id);
      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<LlmModel?, Exception>> getCurrentLlmModel() async {
    try {
      final kvp = await _kvpLDS.getKVP(Constant.kCurrentLLM);

      if (kvp == null) {
        final models = await _llmLDS.getLlmModels();

        final defaultModel =
            models.firstWhereOrNull((element) => element.isAvailable);

        if (defaultModel == null) return const Result.success(null);

        await _kvpLDS.setKVP(Constant.kCurrentLLM, defaultModel.id!);

        return Result.success(defaultModel);
      }

      final res = await _llmLDS.getLlmModel(llmId: kvp.value);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<LlmModel, Exception>> storeCurrentLlmModel({
    required LlmModel model,
  }) async {
    try {
      await _kvpLDS.setKVP(Constant.kCurrentLLM, model.id!);

      return Result.success(model);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<LlmModel, Exception>> getLlmModel({required String id}) async {
    try {
      final res = await _llmLDS.getLlmModel(llmId: id);

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<LlmModel, Exception>> updateLlmModel({
    required String id,
    required String relativePath,
  }) async {
    try {
      final data = await _llmLDS.getLlmModel(llmId: id);

      final res = await _llmLDS.updateLlmModel(
        data: data.copyWith(path: relativePath),
      );

      return Result.success(res);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<LlmModel, Exception>> createLlmModel({
    required LlmModel model,
  }) async {
    try {
      final data = await _llmLDS.createLlmModel(data: model);

      return Result.success(data);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
