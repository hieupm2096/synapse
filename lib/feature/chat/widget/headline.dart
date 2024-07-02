import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';

class Headline extends StatefulWidget {
  const Headline({super.key});

  @override
  State<Headline> createState() => _HeadlineState();
}

class _HeadlineState extends State<Headline> {
  var _hiAnimDone = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_hiAnimDone)
          AnimatedTextKit(
            onFinished: () {
              setState(() => _hiAnimDone = true);
            },
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                'Hi!',
                textStyle: context.shadTextTheme.h1,
                speed: const Duration(milliseconds: 200),
              ),
            ],
          ),
        if (_hiAnimDone)
          ChatBubble.left(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'How can I help you?',
                  textStyle: context.shadTextTheme.list,
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              isRepeatingAnimation: false,
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          )
      ],
    );
  }
}
