import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:synapse/core/core.dart';

class HiThere extends StatelessWidget {
  const HiThere({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TypewriterAnimatedText(
          'Hi there 👋',
          textStyle: context.shadTextTheme.h1,
          speed: 100.ms,
        ),
      ],
    );
  }
}
