import 'dart:async';

import 'package:fllama/fllama.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';
import 'package:synapse/feature/setting/provider/ai_setting_provider.dart';

part 'prompt_reply_provider.g.dart';

enum PromptReplyStatus { initial, inProgress, done }

final class PromptReplyEntity {
  const PromptReplyEntity({
    required this.status,
    this.id,
    this.message,
  });

  final String? message;
  final PromptReplyStatus status;
  final int? id;

  PromptReplyEntity copyWith({
    String? message,
    PromptReplyStatus? status,
    int? id,
  }) {
    return PromptReplyEntity(
      message: message ?? this.message,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'id: $id - message: $message - status: $status';
  }
}

@riverpod
class PromptReply extends _$PromptReply {
  @override
  PromptReplyEntity build() {
    ref.onDispose(stopInference);

    return const PromptReplyEntity(status: PromptReplyStatus.initial);
  }

  // cache request id to cancel later - this function does not work correctly
  int? _requestId;

  Future<void> startInference({
    required int id,
    required String message,
  }) async {
    // change state
    state = PromptReplyEntity(id: id, status: PromptReplyStatus.inProgress);

    // get current llm model
    final llmModel = ref.read(currentLlmProvider).value;

    if (llmModel == null) return;

    // get llm model path
    var relativePath = '';
    var absolutePath = '';

    final path = llmModel.path;

    if (path == null) return;

    if (path.contains('/')) {
      absolutePath = path;
    } else {
      relativePath = path;
    }

    if (absolutePath == '') {
      final directory = await getApplicationDocumentsDirectory();

      absolutePath = '${directory.path}/$relativePath';
    }

    // start inference
    final request = OpenAiRequest(
      messages: [
        Message(
          Role.system,
          '''
          You are an AI assistant that helps people find information.
          You should always maintain a professional tone and avoid discussing personal opinions on politics.
          You should answer the question with short and concise answer.
          If you don't understand the question, answer you don't understand.
          If you don't know the answer for the question, answer you don't know.
          ''',
        ),
        Message(Role.user, message),
      ],
      modelPath: absolutePath,
      numGpuLayers: 99,
      maxTokens: 256,

      // ai setting
      contextSize: ref.read(contextWindowNotifierProvider).value ?? 2048,
      temperature: ref.read(temperatureNotifierProvider).value ?? 0.7,
      topP: ref.read(topPNotifierProvider).value ?? 1.0,
      frequencyPenalty: ref.read(frequencyPNotifierProvider).value ?? 0.0,
      presencePenalty: ref.read(presencePNotifierProvider).value ?? 1.1,

      logger: (log) => logDebug('[llama.cpp] $log'),
    );

    _requestId = await fllamaChat(
      request,
      (response, done) {
        state = PromptReplyEntity(
          id: id,
          message: response.trim(),
          status: done ? PromptReplyStatus.done : PromptReplyStatus.inProgress,
        );

        if (done) {
          ref.invalidateSelf();
        }
      },
    );
  }

  // this function does not work correctly
  void stopInference() {
    if (_requestId == null) return;

    fllamaCancelInference(_requestId!);
  }
}
