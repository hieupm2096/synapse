import 'dart:async';

import 'package:fllama/fllama.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/chat/provider/update_prompt_provider.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

part 'prompt_reply_provider.g.dart';

@riverpod
class PromptReply extends _$PromptReply {
  @override
  String build({required int id}) => '';

  Future<void> startInference({
    required String message,
    required int conversationId,
    required LlmModel llmModel,
  }) async {
    final relativePath = llmModel.path;

    if (relativePath == null) return;

    final directory = await getApplicationDocumentsDirectory();

    final absolutePath = '${directory.path}/$relativePath';

    final request = FllamaInferenceRequest(
      maxTokens: 256,
      input: message,
      numGpuLayers: 99,
      modelPath: absolutePath,
      penaltyFrequency: 0,
      // Don't use below 1.1, LLMs without a repeat penalty
      // will repeat the same token.
      penaltyRepeat: 1.1,
      topP: 1,
      contextSize: 2048,
      // Don't use 0.0, some models will repeat
      // the same token.
      temperature: 0.1,
      logger: (log) {
        logDebug('[llama.cpp] $log');
      },
    );

    unawaited(fllamaInference(request, _listener));
  }

  void _listener(String response, bool done) {
    logInfo('[llama] $response');

    // update prompt in local db
    if (done) {
      ref
          .read(updatePromptProvider.notifier)
          .updatePrompt(id: id, message: response);
    }

    // update the text value
    state = response;
  }
}
