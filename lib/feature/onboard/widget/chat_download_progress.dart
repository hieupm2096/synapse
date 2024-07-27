import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/core/extension/duration_ext.dart';
import 'package:synapse/feature/llm/provider/download_llm_provider.dart';

class ChatDownloadProgress extends ConsumerWidget {
  const ChatDownloadProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDownloadProgress = ref.watch(overallProgressProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder(
          tween: Tween(
            begin: 0,
            end: asyncDownloadProgress.$1,
          ),
          duration: Durations.short4,
          builder: (context, value, child) => ShadProgress(
            minHeight: 6,
            value: value.toDouble(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (asyncDownloadProgress.$2 != null)
              Text(
                '${asyncDownloadProgress.$2!.formatDuration()} to complete',
                style: context.shadTextTheme.muted.copyWith(fontSize: 11),
              ),
            Text(
              '${(asyncDownloadProgress.$1 * 100).round()}%',
              style: context.shadTextTheme.muted.copyWith(fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}
