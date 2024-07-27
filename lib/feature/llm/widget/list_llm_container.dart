import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/feature/llm/provider/download_llm_provider.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';
import 'package:synapse/feature/llm/provider/pick_llm_provider.dart';
import 'package:synapse/feature/llm/widget/list_llm.dart';
import 'package:synapse/feature/llm/widget/list_llm_empty.dart';
import 'package:synapse/feature/llm/widget/list_llm_loading.dart';

import 'package:synapse/shared/shared.dart';

class ListLlmContainer extends ConsumerWidget {
  const ListLlmContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncListLlm = ref.watch(listLLMAsyncNotifierProvider);

    ref
      ..listen(
        downloadLlmProvider,
        (previous, next) {
          if (next.hasValue && next.value != null) {
            final value = next.value;
            if (value is EnqueueLlmSuccess) {
              context.shadToaster.show(
                ShadToast(
                  title: const Text('Added model to download queue'),
                  titleStyle: context.shadTextTheme.small,
                  duration: 2.seconds,
                  showCloseIconOnlyWhenHovered: false,
                ),
              );
            } else if (value is CancelDownloadLlmSuccess) {
              context.shadToaster.show(
                ShadToast.destructive(
                  title: const Text('Removed model from download queue'),
                  titleStyle: context.shadTextTheme.small,
                  duration: 2.seconds,
                  showCloseIconOnlyWhenHovered: false,
                ),
              );
            } else if (value is DownloadLlmSuccess) {
              context.shadToaster.show(
                ShadToast(
                  title: Text('${value.llmId} downloaded successfully'),
                  titleStyle: context.shadTextTheme.small,
                  duration: 2.seconds,
                  showCloseIconOnlyWhenHovered: false,
                ),
              );

              // go to ListConversationPage
              context.go(ListConversationPage.route);
            }
          }
        },
      )
      ..listen(
        pickLlmProvider,
        (previous, next) {
          if (next.hasError && next.error != null) {
            if (next.error?.toString() == 'invalid') {
              context.shadToaster.show(
                ShadToast.destructive(
                  title: const Text('Invalid file'),
                  description: const Text('File must has GGUF format.'),
                  titleStyle: context.shadTextTheme.small,
                  duration: 2.seconds,
                  showCloseIconOnlyWhenHovered: false,
                ),
              );
            }
          } else if (next.hasValue && next.value != null) {
            ref
                .read(listLLMAsyncNotifierProvider.notifier)
                .addLlmModel(data: next.value!);

            ref.read(currentLlmProvider.notifier).setLlmModel(next.value!);

            context.go(ListConversationPage.route);
          }
        },
      );

    return asyncListLlm.when(
      data: (listLlm) {
        if (listLlm.isEmpty) {
          return ListLlmEmpty(
            onAdd: () {},
          );
        }

        return ListLlm(data: listLlm);
      },
      error: (error, stackTrace) => CommonErrorWidget(
        onRetry: () {},
      ),
      loading: ListLlmLoading.new,
    );
  }
}
