import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/page/list_llm_page.dart';
import 'package:synapse/feature/llm/provider/download_llm_provider.dart';
import 'package:synapse/shared/widget/misc/progress_border.dart';

class DownloaderButton extends ConsumerWidget {
  const DownloaderButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTaskSet =
        ref.watch(downloadLlmProvider).value?.taskSet.length ?? 0;

    if (asyncTaskSet == 0) return const SizedBox.shrink();

    final asyncOverallProgress = ref.watch(overallProgressProvider);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: asyncOverallProgress.$1),
      duration: Durations.short4,
      curve: Curves.easeInOut,
      builder: (_, value, child) {
        return Container(
          decoration: BoxDecoration(
            border: ProgressBorder.all(
              color: context.shadColor.success,
              width: 6,
              progress: value,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: FloatingActionButton(
            onPressed: () => context.push(ListLlmPage.route),
            child: Text(
              asyncTaskSet.toString(),
              style: context.shadTextTheme.h3.copyWith(
                color: context.shadColor.primaryForeground,
              ),
            ),
          ),
        );
      },
    );
  }
}
