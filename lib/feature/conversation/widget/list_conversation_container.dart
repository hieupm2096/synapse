import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/conversation/provider/current_conversation_provider.dart';
import 'package:synapse/feature/conversation/provider/list_conversation_provider.dart';
import 'package:synapse/feature/conversation/widget/list_conversation.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_empty.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_error.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_loading.dart';

class ListConversationContainer extends ConsumerWidget {
  const ListConversationContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLlmId =
        ref.watch(currentLlmModelProvider.select((value) => value.value?.id));

    final listConversationAsyncNotifier =
        listConversationAsyncNotifierProvider(llmId: currentLlmId);

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
      currentConversationProvider(llmId: currentLlmId).select(
        (asyncValue) => asyncValue.value?.id,
      ),
    );

    return asyncConversations.when(
      data: (data) {
        if (data.isEmpty) return const ListConversationEmpty();

        return ListConversation(conversations: data);
      },
      error: (error, stackTrace) => ListConversationError(
        onRefresh: () {
          ref.invalidate(listConversationAsyncNotifier);
        },
      ),
      loading: () => const ListConversationLoading(),
    );
  }
}
