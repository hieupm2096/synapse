import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:synapse/feature/llm/data_source/llm_lds/llm_lds.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

final class JsonLlmLds implements ILlmLDS {
  @override
  Future<List<LlmModel>> getLlmModels() async {
    final jsonString = await rootBundle.loadString('assets/json/llm.json');

    final data = jsonDecode(jsonString) as List;

    return data
        .map((e) => LlmModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<LlmModel> createLlmModel({required LlmModel data}) {
    throw UnimplementedError();
  }

  @override
  Future<LlmModel> getLlmModel({required String llmId}) {
    throw UnimplementedError();
  }

  @override
  Future<LlmModel> removeLlmModel({required String llmId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> createLlmModels({required List<LlmModel> data}) {
    throw UnimplementedError();
  }

  @override
  Future<LlmModel> updateLlmModel({required LlmModel data}) {
    throw UnimplementedError();
  }
}
