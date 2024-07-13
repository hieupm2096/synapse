import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/chat.dart';
import 'package:synapse/feature/conversation/provider/create_conversation_provider.dart';
import 'package:synapse/feature/conversation/provider/current_conversation_provider.dart';
import 'package:synapse/feature/conversation/provider/list_conversation_provider.dart';
import 'package:synapse/feature/conversation/widget/list_conversation.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_empty.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_loading.dart';
import 'package:synapse/shared/widget/misc/common_error_widget.dart';

class ListConversationContainer extends ConsumerWidget {
  const ListConversationContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLlmId =
        ref.watch(currentLlmModelProvider.select((value) => value.value?.id));

    final currentConversationAsyncNotifier =
        currentConversationProvider(llmId: currentLlmId);

    final listConversationAsyncNotifier =
        listConversationAsyncNotifierProvider(llmId: currentLlmId);

    final createConversationAsyncNotifier =
        createConversationAsyncNotifierProvider(llmId: currentLlmId);

    final asyncConversations = ref.watch(listConversationAsyncNotifier);

    ref
      ..listen(
        listConversationAsyncNotifier,
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
        createConversationAsyncNotifier,
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
                .read(listConversationAsyncNotifier.notifier)
                .addConversation(conversation: next.value!);

            // set current conversation
            ref
                .read(currentConversationAsyncNotifier.notifier)
                .setCurrentConversation(data: next.value!);

            // routing
            // context.go(ChatPage.route);
          }
        },
      )
      ..listen(
        currentConversationAsyncNotifier,
        (previous, next) {
          if (next.isLoading) {
            // DO NOTHING
          } else if (next.hasValue && next.value != null) {
            context.go(ChatPage.route);
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
              ref
                  .read(createConversationAsyncNotifier.notifier)
                  .createConversation();
            },
          );
        }

        return ListConversation(conversations: data);
      },
      error: (error, stackTrace) => CommonErrorWidget(
        onRetry: () => ref.invalidate(listConversationAsyncNotifier),
      ),
      loading: () => const ListConversationLoading(),
    );
  }
}
