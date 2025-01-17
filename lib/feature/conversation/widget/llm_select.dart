import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/llm.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';

class LlmSelect extends ConsumerWidget {
  const LlmSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLlm = ref.watch(listLLMAsyncNotifierProvider);

    final asyncCurrentLlm = ref.watch(currentLlmProvider);

    ref.listen(
      currentLlmProvider,
      (previous, next) {
        if (next.hasError && next.error != null) {
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

    return Row(
      children: [
        Expanded(
          child: ShadSelect<LlmModel>(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            initialValue: asyncCurrentLlm.value,
            onChanged: (value) {
              ref.read(currentLlmProvider.notifier).setLlmModel(value);
            },
            placeholder: Row(
              children: [
                Text(
                  'Select a model',
                  style: context.shadTextTheme.muted.copyWith(
                    fontSize: context.shadTextTheme.small.fontSize,
                  ),
                ),
                if (asyncLlm.isLoading || asyncCurrentLlm.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
            options: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                child: Text(
                  'Model',
                  style: context.shadTextTheme.muted.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.shadColor.popoverForeground,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              ...(asyncLlm.value ?? [])
                  .where((e) => e.isAvailable)
                  .map((e) => ShadOption(value: e, child: Text(e.id ?? 'N/A'))),
            ],
            selectedOptionBuilder: (context, value) {
              return Text(
                value.id ?? 'N/A',
                style: context.shadTextTheme.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
              );
            },
          ),
        ),
        ShadButton.outline(
          onPressed: () {
            context.push(ListLlmPage.route);
          },
          icon: const Icon(
            LucideIcons.ganttChart,
            size: 20,
          ),
        ),
      ],
    );
  }
}
