import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';

class Headline extends StatefulWidget {
  const Headline({
    super.key,
    this.onFinished,
  });

  final void Function({String? message})? onFinished;

  @override
  State<Headline> createState() => _HeadlineState();
}

class _HeadlineState extends State<Headline> {
  var _hiAnimDone = false;
  final _message = 'How can I help you?';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_hiAnimDone)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AnimatedTextKit(
              onFinished: () {
                setState(() => _hiAnimDone = true);
              },
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Hi there 👋',
                  textStyle: context.shadTextTheme.h1,
                  speed: 100.ms,
                ),
              ],
            ),
          ),
        if (_hiAnimDone)
          ChatBubble.left(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  _message,
                  textStyle: context.shadTextTheme.list,
                  speed: 50.ms,
                ),
              ],
              onFinished: () => widget.onFinished?.call(message: _message),
              isRepeatingAnimation: false,
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
      ],
    );
  }
}
