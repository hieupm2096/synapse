import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/provider/download_llm_provider.dart';
import 'package:synapse/shared/shared.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LlmItem extends StatelessWidget {
  const LlmItem({
    required this.model,
    super.key,
  });

  final LlmModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                onPressed: () => _onInfoTap(context),
                minSize: 0,
                padding: EdgeInsets.zero,
                child: Text(
                  model.modelId ?? 'N/A',
                  style: context.shadTextTheme.list.copyWith(
                    fontWeight: context.shadTextTheme.large.fontWeight,
                    color: model.isAvailable
                        ? context.shadColor.primary
                        : context.shadColor.mutedForeground,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (model.author != null)
                    Text(
                      model.author!,
                      style: context.shadTextTheme.muted,
                    ),
                  if (model.author != null)
                    const Icon(
                      LucideIcons.dot,
                      size: 12,
                    ),
                  if (model.parameters != null)
                    Text(
                      model.parameters!,
                      style: context.shadTextTheme.muted,
                    ),
                  if (model.parameters != null && model.size != null)
                    const Icon(
                      LucideIcons.dot,
                      size: 12,
                    ),
                  if (model.size != null)
                    Text(
                      model.size!,
                      style: context.shadTextTheme.muted,
                    ),
                ],
              ),
            ],
          ),
        ),

        // LlmItemAction(data: model),

        const SizedBox(width: 16),

        if (model.isAvailable)
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            child: Icon(
              LucideIcons.check,
              size: 20,
              color: context.shadColor.success,
            ),
          )
        else if (model.downloadUrl != null)
          _ActionButton(
            llmId: model.id!,
            url: model.downloadUrl!,
            // downloaded: model.isAvailable,
            path: model.path,
          ),
      ],
    );
  }

  Future<void> _onInfoTap(BuildContext context) async {
    final url = model.url;

    if (url == null) return;

    var res = false;

    try {
      res = await launchUrlString(url);
    } on Exception {
      res = false;
    }
    if (!res) {
      if (!context.mounted) return;

      context.shadToaster.show(
        const ShadToast.destructive(
          title: Text('Uh oh! Something went wrong'),
          description: Text('There was a problem opening the link'),
          duration: Duration(seconds: 5),
          showCloseIconOnlyWhenHovered: false,
        ),
      );
    }
  }
}

class _ActionButton extends ConsumerWidget {
  const _ActionButton({
    required this.llmId,
    required this.url,
    // required this.downloaded,
    this.path,
  });

  final String llmId;
  final String url;
  // final bool downloaded;
  final String? path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDownloading =
        ref.watch(downloadLlmProvider).value?.taskSet.contains(llmId);

    // if (downloaded) {
    // disable clear data function
    // return ShadButton.ghost(
    //   onPressed: () {
    //     if (path == null) return;

    //     ref.read(clearLlmProvider.notifier).clearLlm(llmId, path!);
    //   },
    //   foregroundColor: context.shadColor.destructive,
    //   hoverForegroundColor: context.shadColor.destructive,
    //   icon: const Icon(
    //     LucideIcons.trash2,
    //     size: 20,
    //   ),
    // );

    // }

    if (isDownloading == null) {
      return const SizedBox.shrink();
    } else if (isDownloading) {
      final asyncProgress = ref.watch(DownloadProgressProvider(llmId));

      final progress = asyncProgress.$1 >= 0 ? asyncProgress.$1 : 0.0;

      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress),
        duration: Durations.short4,
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return CupertinoButton(
            onPressed: () {
              ref
                  .read(downloadLlmProvider.notifier)
                  .cancelDownload(taskId: llmId);
            },
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: ProgressBorder.all(
                  color: context.shadColor.success,
                  width: 4,
                  progress: value,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(progress * 100).round()}',
                    style: context.shadTextTheme.small,
                  ),
                  Text(
                    '%',
                    style: context.shadTextTheme.small.copyWith(fontSize: 9),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return ShadButton.ghost(
        onPressed: () {
          ref
              .read(downloadLlmProvider.notifier)
              .downloadLlmModel(llmId: llmId, url: url);
        },
        icon: const Icon(
          LucideIcons.download,
          size: 20,
        ),
      );
    }
  }
}
