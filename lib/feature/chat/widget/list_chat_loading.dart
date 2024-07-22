import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ListChatLoading extends StatelessWidget {
  const ListChatLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 6.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: height,
      alignment: Alignment.topCenter,
      child: const ShadProgress(minHeight: height),
    );
  }
}
