import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';

class LlmSelect extends ConsumerWidget {
  const LlmSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLlm = ref.watch(listLLMAsyncNotifierProvider);

    final asyncCurrentLlm = ref.watch(currentLlmModelProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 180),
      child: ShadSelect<LlmModel>(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        initialValue: asyncCurrentLlm.value,
        onChanged: (value) {
          ref.read(currentLlmModelProvider.notifier).setLlmModel(value);
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
          ...(asyncLlm.value ?? []).map(
            (e) => ShadOption(value: e, child: Text(e.id ?? 'N/A')),
          ),
        ],
        selectedOptionBuilder: (context, value) {
          return Text(
            value.id ?? 'N/A',
            style: context.shadTextTheme.small.copyWith(
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }
}
