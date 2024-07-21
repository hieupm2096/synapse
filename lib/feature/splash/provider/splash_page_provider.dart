import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

part 'splash_page_provider.g.dart';

sealed class SplashLoadedResult {}

final class NotOnboarded extends SplashLoadedResult {}

final class NoLlm extends SplashLoadedResult {}

final class NoUser extends SplashLoadedResult {}

final class NoConversation extends SplashLoadedResult {}

final class SplashLoadedSuccess extends SplashLoadedResult {
  SplashLoadedSuccess({required this.conversationId});

  final int conversationId;
}

@Riverpod(keepAlive: true)
FutureOr<SplashLoadedResult> splashPage(SplashPageRef ref) async {
  await Future.delayed(1.seconds, () {});

  // onboard
  final data = await Future.wait([
    ref.watch(currentLlmProvider.future),
    ref.watch(currentUserProvider.future),
  ]);

  final currentLlm = data[0] as LlmModel?;
  // final currentUser = data[1] as UserModel?;

  if (currentLlm == null) return NoLlm();

  // if (currentUser == null) return NoUser();

  final llmId = currentLlm.id;

  int? conversationId;

  if (llmId != null) {
    final currentConversation =
        await ref.watch(CurrentConversationProvider(llmId: llmId).future);

    conversationId = currentConversation?.id;
  }

  if (conversationId == null) return NoConversation();

  return SplashLoadedSuccess(conversationId: conversationId);
}
