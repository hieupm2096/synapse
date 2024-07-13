import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/app/provider/current_user/current_user_provider.dart';
import 'package:synapse/feature/conversation/provider/current_conversation_provider.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

part 'splash_page_provider.g.dart';

sealed class SplashLoadedResult {}

final class NotOnboarded extends SplashLoadedResult {}

final class NoLlm extends SplashLoadedResult {}

final class NoUser extends SplashLoadedResult {}

final class SplashLoadedSuccess extends SplashLoadedResult {}

@Riverpod(keepAlive: true)
FutureOr<SplashLoadedResult> splashPage(SplashPageRef ref) async {
  await Future.delayed(1.seconds, () {});

  // onboard
  final data = await Future.wait([
    ref.watch(currentLlmModelProvider.future),
    ref.watch(currentUserProvider.future),
  ]);

  final currentLlm = data[0] as LlmModel?;
  // final currentUser = data[1] as UserModel?;

  if (currentLlm == null) return NoLlm();

  // if (currentUser == null) return NoUser();

  final llmId = currentLlm.id;

  if (llmId != null) {
    await ref.watch(CurrentConversationProvider(llmId: llmId).future);
  }

  return SplashLoadedSuccess();
}
