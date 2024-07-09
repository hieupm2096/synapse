import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
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
    return ShadPopover(
      controller: _controller,
      padding: EdgeInsets.zero,
      showDuration: const Duration(milliseconds: 100),
      waitDuration: const Duration(milliseconds: 100),
      decoration: ShadDecoration(
        border: ShadBorder(radius: BorderRadius.circular(12)),
      ),
      popover: (popoverContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.data.isAvailable && widget.data.isExternal)
              // DOWNLOAD BUTTON
              ShadButton.ghost(
                onPressed: () {},
                width: 125,
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
              ),
            if (widget.data.isExternal)
              // INFO BUTTON
              ShadButton.ghost(
                onPressed: () async {
                  _controller.toggle();

                  final url = widget.data.url;
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
                        description:
                            Text('There was a problem opening the link'),
                        showCloseIconOnlyWhenHovered: false,
                      ),
                    );
                  }
                },
                width: 125,
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
              ),
            if (!widget.data.isExternal)
              // DELETE BUTTON
              ShadButton.ghost(
                onPressed: () {},
                width: 125,
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
                width: 125,
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
