import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:synapse/feature/conversation/data_source/conversation/conversation_lds.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';

final class FixtureConversationLDS implements IConversationLDS {
  List<ConversationModel>? _data;

  @override
  Future<ConversationModel> createConversation({
    required ConversationModel data,
  }) async {
    _data ??= await getConversations();

    _data!.add(data);

    return data;
  }

  @override
  Future<ConversationModel> getConversation({
    required int id,
  }) async {
    _data ??= await getConversations();

    final foundIndex = _data!.indexWhere(
      (element) => element.id == id,
    );

    if (foundIndex == -1) throw Exception('not_found');

    return _data![foundIndex];
  }

  @override
  Future<List<ConversationModel>> getConversations({
    String? llmId,
  }) async {
    if (_data != null) return Future.value(_data);

    final jsonString =
        await rootBundle.loadString('assets/fixture/conversation_fixture.json');

    final data = jsonDecode(jsonString) as List;

    return data
        .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ConversationModel> getRecentConversation({
    required String llmId,
  }) async {
    _data ??= await getConversations();

    final res = _data?.firstWhereOrNull((e) => e.llmId == llmId);

    if (res == null) throw Exception('not_found');

    return res;
  }

  @override
  Future<ConversationModel> removeConversation({required int id}) async {
    if (_data == null) throw Exception('not_found');

    final foundIndex = _data!.indexWhere(
      (element) => element.id == id,
    );

    if (foundIndex == -1) throw Exception('not_found');

    return _data!.removeAt(foundIndex);
  }

  @override
  Future<ConversationModel> updateConversation({
    required ConversationModel data,
  }) async {
    _data ??= await getConversations();

    final foundIndex = _data!.indexWhere(
      (element) => element.id == data.id,
    );

    if (foundIndex == -1) throw Exception('not_found');

    _data![foundIndex] = data;

    return data;
  }
}
