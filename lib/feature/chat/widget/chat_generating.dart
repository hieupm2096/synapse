import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:synapse/core/core.dart';

class ChatGenerating extends StatelessWidget {
  const ChatGenerating({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: context.shadColor.primary,
        shape: BoxShape.circle,
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .scaleXY(
          duration: 1000.milliseconds,
          begin: 0.9,
          end: 1.1,
        );
  }
}
