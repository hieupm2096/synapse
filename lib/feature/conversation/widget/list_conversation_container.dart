import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/app/provider/provider.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/feature/conversation/provider/create_conversation_provider.dart';
import 'package:synapse/feature/conversation/provider/list_conversation_provider.dart';
import 'package:synapse/feature/conversation/widget/list_conversation.dart'
    as widget;
import 'package:synapse/feature/conversation/widget/list_conversation_empty.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_loading.dart';
import 'package:synapse/shared/widget/misc/common_error_widget.dart';

class ListConversationContainer extends ConsumerWidget {
  const ListConversationContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLlmId = ref.watch(currentLlmProvider).value?.id;

    final currentUserId = ref.read(currentUserProvider).value?.id;

    final asyncConversations =
        ref.watch(listConversationProvider(llmId: currentLlmId));

    ref
      ..listen(
        listConversationProvider(llmId: currentLlmId),
        (previous, next) {
          if (next.isLoading) {
            // DO NOTHING
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
      )
      ..listen(
        createConversationProvider(llmId: currentLlmId),
        (previous, next) {
          if (next.isLoading) {
            // DO NOTHING
          } else if (next.hasError) {
            context.shadToaster.show(
              const ShadToast.destructive(
                title: Text('Uh oh! Something went wrong'),
                description: Text('There was a problem with your request'),
                showCloseIconOnlyWhenHovered: false,
              ),
            );
          } else if (next.hasValue && next.value != null) {
            // add new conversation to list
            ref
                .read(listConversationProvider(llmId: currentLlmId).notifier)
                .addConversation(conversation: next.value!);

            // set current conversation
            ref
                .read(currentConversationProvider(llmId: currentLlmId).notifier)
                .setCurrentConversation(data: next.value!);
          }
        },
      )
      ..listen(
        currentConversationProvider(llmId: currentLlmId),
        (previous, next) {
          if (next.isLoading) {
            // DO NOTHING
          } else if (next.hasValue && next.value != null) {
            context.go('${ListConversationPage.route}/${next.value?.id}');
          } else if (next.hasError && next.error != null) {
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

    return asyncConversations.when(
      data: (data) {
        if (data.isEmpty) {
          return ListConversationEmpty(
            onCreateConversation: () {
              if (currentUserId == null) return;

              ref
                  .read(
                    createConversationProvider(llmId: currentLlmId).notifier,
                  )
                  .createConversation(userId: currentUserId);
            },
          );
        }

        return widget.ListConversation(conversations: data);
      },
      error: (error, stackTrace) => CommonErrorWidget(
        onRetry: () =>
            ref.invalidate(listConversationProvider(llmId: currentLlmId)),
      ),
      loading: () => const ListConversationLoading(),
    );
  }
}
