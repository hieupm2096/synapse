import 'dart:async';

import 'package:fllama/fllama.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';

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
}

@Riverpod(keepAlive: true)
class PromptReply extends _$PromptReply {
  @override
  PromptReplyEntity build() {
    // ref.onDispose(stopInference);

    return const PromptReplyEntity(status: PromptReplyStatus.initial);
  }

  // cache request id to cancel later - this function does not work correctly
  // int? _requestId;

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
    final relativePath = llmModel.path;

    if (relativePath == null) return;

    final directory = await getApplicationDocumentsDirectory();

    final absolutePath = '${directory.path}/$relativePath';

    // start inference
    final request = OpenAiRequest(
      modelPath: absolutePath,
      maxTokens: 256,
      numGpuLayers: 99,
      
      messages: [
        Message(
          Role.system,
          '''
          You are an AI assistant that helps people find information.
          You should always maintain a professional tone and avoid discussing personal opinions on politics.
          You should answer the question in shortest form possible.
          If you don't understand the question, answer you don't understand.
          If you don't know the answer for the question, answer you don't know.
          ''',
        ),
        Message(Role.user, message),
      ],
      temperature: 0.5,
      logger: (log) => logDebug('[llama.cpp] $log'),
    );

    // _requestId =
    await fllamaChat(
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
  // void stopInference() {
  //   if (_requestId == null) return;

  //   fllamaCancelInference(_requestId!);
  // }
}
