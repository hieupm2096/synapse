import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/widget/llm_item_action.dart';

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
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${model.modelId ?? 'N/A'} ',
                      style: context.shadTextTheme.list.copyWith(
                        fontWeight: context.shadTextTheme.large.fontWeight,
                        color: model.isAvailable
                            ? context.shadColor.primary
                            : context.shadColor.mutedForeground,
                      ),
                    ),
                    if (model.isAvailable)
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Icon(
                            LucideIcons.circleCheckBig,
                            color: context.shadColor.success,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (model.author != null)
                    Text(
                      model.author!,
                      style: context.shadTextTheme.muted,
                    ),
                  if (model.author != null && model.parameters != null)
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
        LlmItemAction(data: model),
      ],
    );
  }
}
