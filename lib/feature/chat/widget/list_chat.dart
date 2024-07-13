import 'package:flutter/material.dart';
import 'package:synapse/feature/chat/widget/headline.dart';

class ListChat extends StatelessWidget {
  const ListChat({super.key});

  @override
  Widget build(BuildContext context) {
    final widgets = [
      const Headline(),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        return widgets[index];
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
