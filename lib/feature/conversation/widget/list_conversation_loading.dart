import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ListConversationLoading extends StatelessWidget {
  const ListConversationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 6.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: height,
      alignment: Alignment.topCenter,
      child: const ShadProgress(minHeight: height),
    );
    // return ListView.separated(
    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   itemBuilder: (context, index) => const Skeleton(height: 36),
    //   separatorBuilder: (context, index) => const SizedBox(height: 12),
    //   itemCount: 5,
    // );
  }
}
