import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/provider/provider.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/page/list_conversation_page.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';
import 'package:synapse/feature/llm/provider/pick_llm_provider.dart';

class PickLlmButton extends ConsumerWidget {
  const PickLlmButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
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

    return ShadButton(
      onPressed: () => ref.read(pickLlmProvider.notifier).pickLlm(),
      size: ShadButtonSize.lg,
      text: Text(
        'Select it here',
        style: context.shadTextTheme.large.copyWith(
          color: context.shadColor.primaryForeground,
        ),
      ),
    );
  }
}
