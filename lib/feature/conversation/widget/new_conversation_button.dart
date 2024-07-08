import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';
import 'package:synapse/feature/conversation/provider/create_conversation_provider.dart';

class NewConversationIconButton extends ConsumerWidget {
  const NewConversationIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLlmId =
        ref.watch(currentLlmModelProvider.select((value) => value.value?.id));

    final createConversationAsyncNotifier =
        createConversationAsyncNotifierProvider(llmId: currentLlmId);

    return ShadButton.ghost(
      icon: const Icon(
        LucideIcons.squarePen,
        size: 20,
      ),
      onPressed: () => ref
          .read(createConversationAsyncNotifier.notifier)
          .createConversation(),
    );
  }
}
