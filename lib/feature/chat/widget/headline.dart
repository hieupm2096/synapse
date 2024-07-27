import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/extension/build_context_ext.dart';

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
  var _firstAnimDone = false;

  final _greetings = [
    'How can I help you?',
    'How may I assist you?',
    'What can I do for you today?',
    'Great to see you!',
  ];

  var _rand = 0;

  final random = Random();

  @override
  void initState() {
    _rand = random.nextInt(_greetings.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedTextKit(
            onFinished: () => setState(() => _firstAnimDone = true),
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                'Hi there 👋',
                textStyle: context.shadTextTheme.h1,
                speed: 75.ms,
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_firstAnimDone)
            AnimatedTextKit(
              onFinished: () {},
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  _greetings[_rand],
                  textStyle: context.shadTextTheme.large,
                  speed: 50.ms,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
