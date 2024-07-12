import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';
import 'package:synapse/feature/llm/widget/list_llm.dart';
import 'package:synapse/feature/llm/widget/list_llm_empty.dart';
import 'package:synapse/feature/llm/widget/list_llm_loading.dart';

import 'package:synapse/shared/shared.dart';

class ListLlmContainer extends ConsumerWidget {
  const ListLlmContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncListLlm = ref.watch(listLLMAsyncNotifierProvider);

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
