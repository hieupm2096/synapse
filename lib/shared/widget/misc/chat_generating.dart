import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';

class ChatGenerating extends StatelessWidget {
  const ChatGenerating({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      LucideIcons.loaderCircle,
      size: 20,
      color: context.shadColor.primary,
    )
        .animate(onPlay: (controller) => controller.repeat())
        .rotate(duration: 250.ms);

    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Text(
    //       'Generating',
    //       style: context.shadTextTheme.p,
    //     ),
    //     const SizedBox(width: 4),
    //     Icon(
    //       LucideIcons.loaderCircle,
    //       size: 16,
    //       color: context.shadColor.primary,
    //     )
    //         .animate(onPlay: (controller) => controller.repeat())
    //         .rotate(duration: 250.ms),
    //   ],
    // );
  }
}
