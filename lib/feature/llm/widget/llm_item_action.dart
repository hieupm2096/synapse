import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/provider/download_llm_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LlmItemAction extends ConsumerStatefulWidget {
  const LlmItemAction({
    required this.data,
    super.key,
  });

  final LlmModel data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LlmItemActionState();
}

class _LlmItemActionState extends ConsumerState<LlmItemAction> {
  final _controller = ShadPopoverController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      downloadLlmProvider,
      (previous, next) {
        if (next.hasValue && next.value != null) {
          final value = next.value;
          if (value is EnqueueLlmSuccess) {
            context.shadToaster.show(
              const ShadToast(
                description: Text('Added model to download queue'),
                duration: Duration(seconds: 2),
                showCloseIconOnlyWhenHovered: false,
              ),
            );
          } else if (value is CancelDownloadLlmSuccess) {
            context.shadToaster.show(
              const ShadToast.destructive(
                description: Text('Removed model from download queue'),
                duration: Duration(seconds: 2),
                showCloseIconOnlyWhenHovered: false,
              ),
            );
          } else if (value is DownloadLlmSuccess) {
            context.shadToaster.show(
              ShadToast(
                description: Text('${value.llmId} downloaded successfully'),
                duration: 2.seconds,
                showCloseIconOnlyWhenHovered: false,
              ),
            );

            // go to ListConversationPage
            context.go(ListConversationPage.route);
          }
        }
      },
    );

    return ShadPopover(
      controller: _controller,
      padding: EdgeInsets.zero,
      decoration: ShadDecoration(
        border: ShadBorder(radius: BorderRadius.circular(12)),
      ),
      popover: (popoverContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!widget.data.isAvailable &&
                widget.data.isExternal &&
                widget.data.downloadUrl != null)
              // DOWNLOAD BUTTON
              _DownloadButton(
                llmId: widget.data.id!,
                url: widget.data.downloadUrl!,
                controller: _controller,
              ),
            if (widget.data.isExternal)
              // INFO BUTTON
              _InfoButton(controller: _controller, url: widget.data.url!),
            if (!widget.data.isExternal)
              // DELETE BUTTON
              ShadButton.ghost(
                onPressed: () {},
                width: 150,
                foregroundColor: popoverContext.shadColor.destructive,
                hoverForegroundColor: popoverContext.shadColor.destructive,
                text: const Expanded(
                  child: Text(
                    'Delete',
                    textAlign: TextAlign.start,
                  ),
                ),
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    LucideIcons.trash2,
                    size: 16,
                  ),
                ),
              )
            else if (widget.data.isAvailable)
              // CLEAR DOWNLOAD BUTTON
              ShadButton.ghost(
                onPressed: () {},
                width: 150,
                foregroundColor: popoverContext.shadColor.destructive,
                hoverForegroundColor: popoverContext.shadColor.destructive,
                text: const Expanded(
                  child: Text(
                    'Clear',
                    textAlign: TextAlign.start,
                  ),
                ),
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    LucideIcons.trash2,
                    size: 16,
                  ),
                ),
              ),
          ],
        );
      },
      child: ShadButton.ghost(
        onPressed: _controller.toggle,
        icon: const Icon(
          LucideIcons.ellipsisVertical,
          size: 16,
        ),
      ),
    );
  }
}

class _DownloadButton extends ConsumerWidget {
  const _DownloadButton({
    required this.llmId,
    required this.url,
    required this.controller,
  });

  final String llmId;
  final String url;
  final ShadPopoverController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDownloading = ref.watch(
      downloadLlmProvider.select(
        (value) => value.value?.taskSet.contains(llmId),
      ),
    );

    if (isDownloading == null) {
      return const SizedBox.shrink();
    } else if (isDownloading) {
      return ShadButton.ghost(
        onPressed: () {
          controller.toggle();

          ref.read(downloadLlmProvider.notifier).cancelDownload(taskId: llmId);
        },
        width: 150,
        foregroundColor: context.shadColor.destructive,
        hoverForegroundColor: context.shadColor.destructive,
        text: const Expanded(
          child: Text(
            'Cancel',
            textAlign: TextAlign.start,
          ),
        ),
        icon: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            LucideIcons.x,
            size: 16,
          ),
        ),
      );
    } else {
      return ShadButton.ghost(
        onPressed: () {
          controller.toggle();

          ref
              .read(downloadLlmProvider.notifier)
              .downloadLlmModel(llmId: llmId, url: url);
        },
        width: 150,
        text: const Expanded(
          child: Text(
            'Download',
            textAlign: TextAlign.start,
          ),
        ),
        icon: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            LucideIcons.download,
            size: 16,
          ),
        ),
      );
    }
  }
}

class _InfoButton extends StatelessWidget {
  const _InfoButton({
    required ShadPopoverController controller,
    required this.url,
  }) : _controller = controller;

  final ShadPopoverController _controller;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ShadButton.ghost(
      onPressed: () async {
        _controller.toggle();

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
      },
      width: 150,
      text: const Expanded(
        child: Text(
          'Info',
          textAlign: TextAlign.start,
        ),
      ),
      icon: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(
          LucideIcons.info,
          size: 16,
        ),
      ),
    );
  }
}
