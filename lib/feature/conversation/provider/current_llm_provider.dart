import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_llm_provider.g.dart';

@riverpod
class CurrentLLMNotifier extends _$CurrentLLMNotifier {
  // TODO(hieupm): implement llm feature
  @override
  String? build() => 'microsoft/phi-2';

  // ignore: use_setters_to_change_properties
  void setLLM(String? llm) {
    state = llm;
  }
}
