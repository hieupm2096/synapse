import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/conversation/provider/current_conversation_provider.dart';
import 'package:synapse/feature/conversation/provider/current_llm_provider.dart';
import 'package:synapse/feature/conversation/provider/list_conversation_provider.dart';
import 'package:synapse/feature/conversation/widget/list_conversation.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_empty.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_error.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_loading.dart';

class ListConversationContainer extends ConsumerWidget {
  const ListConversationContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLLM = ref.watch(currentLLMNotifierProvider);

    final listConversationAsyncNotifier = listConversationAsyncNotifierProvider(
      llmId: currentLLM,
    );

    final asyncConversations = ref.watch(listConversationAsyncNotifier);

    ref.listen(
      listConversationAsyncNotifier,
      (previous, next) {
        if (next.isLoading) {
          // TODO(hieupm): show full screen loading?
        } else if (next.hasError) {
          context.shadToaster.show(
            const ShadToast.destructive(
              title: Text('Uh oh! Something went wrong'),
              description: Text('There was a problem with your request'),
              showCloseIconOnlyWhenHovered: false,
            ),
          );
        }
      },
    );

    final _ = ref.watch(
      currentConversationProvider(llmId: currentLLM ?? '').select(
        (asyncData) => asyncData.value?.id,
      ),
    );

    return asyncConversations.when(
      data: (data) {
        if (data.isEmpty) return const ListConversationEmpty();

        return ListConversation(conversations: data);
      },
      error: (error, stackTrace) => const ListConversationError(),
      loading: () => const ListConversationLoading(),
    );
  }
}
