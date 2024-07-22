import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShadBackButton extends StatelessWidget {
  const ShadBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.canPop()) return const SizedBox.shrink();

    return ShadButton.ghost(
      icon: const Icon(
        LucideIcons.arrowLeft,
        size: 24,
      ),
      onPressed: () {
        if (context.canPop()) context.pop();
      },
    );
  }
}
