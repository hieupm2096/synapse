import 'package:flutter/material.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/widget/chat_generating.dart';
import 'package:synapse/feature/chat/widget/chat_input.dart';

class BottomFakeChat extends StatelessWidget {
  const BottomFakeChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      decoration: BoxDecoration(
        color: context.shadColor.background,
        border: Border(top: BorderSide(color: context.shadColor.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: ChatInput(enabled: false),
                ),
              ),
              SizedBox(width: 12),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ChatGenerating(),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'The data could be inaccurate.',
            style: context.shadTextTheme.muted.copyWith(
              fontSize: 11,
              // fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
