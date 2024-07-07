import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/gen/assets.gen.dart';

class ListConversationEmpty extends StatelessWidget {
  const ListConversationEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 64),
        Assets.image.emptyConversation.svg(height: 110),
        const SizedBox(height: 24),
        Text(
          'No Conversation',
          style: context.shadTextTheme.large.copyWith(
            color: context.shadColor.mutedForeground,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'There is no recent conversation',
          style: context.shadTextTheme.muted,
        ),
        const SizedBox(height: 16),
        ShadButton.outline(
          onPressed: () {},
          icon: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(LucideIcons.squarePen, size: 16),
          ),
          text: const Text('Start chatting'),
        ),
      ],
    );
  }
}
