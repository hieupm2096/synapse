import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/extension/build_context_ext.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      decoration: ShadDecoration(
        border: ShadBorder(
          width: 0,
          radius: BorderRadius.circular(6),
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 2),
        ),
        secondaryBorder: ShadBorder.none,
        errorBorder: ShadBorder.none,
        focusedBorder: ShadBorder(
          width: 0,
          radius: BorderRadius.circular(6),
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 2),
        ),
        secondaryFocusedBorder: ShadBorder.none,
        secondaryErrorBorder: ShadBorder.none,
        labelPadding: EdgeInsets.zero,
        color: context.shadColor.accent.withOpacity(0.5),
      ),
      placeholder: const Text('Type a message...'),
      controller: controller,
      minLines: 1,
      maxLines: 10,
    );
  }
}
