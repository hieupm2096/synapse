import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShadBackButton extends StatelessWidget {
  const ShadBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadButton.ghost(
      icon: const Padding(
        padding: EdgeInsets.only(top: 6, left: 6),
        child: Icon(
          LucideIcons.arrowLeft,
          size: 24,
        ),
      ),
      onPressed: () {
        if (context.canPop()) context.pop();
      },
    );
  }
}
