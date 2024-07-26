import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';
import 'package:synapse/feature/chat/widget/chat_generating.dart';
import 'package:synapse/feature/chat/widget/chat_input.dart';
import 'package:synapse/feature/llm/page/list_llm_page.dart';
import 'package:synapse/feature/onboard/widget/pick_llm_button.dart';
import 'package:synapse/feature/setting/page/setting_page.dart';
import 'package:synapse/shared/widget/page/chat_app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  static const String route = '/onboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        title: Text('Welcome', style: context.shadTextTheme.h4),
        showLeading: false,
        onSettingPressed: () => context.push(SettingPage.route),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Hi there 👋',
                        textStyle: context.shadTextTheme.h1,
                        speed: 100.ms,
                      ),
                    ],
                  ).animate(delay: 2500.ms).fadeOut(duration: 250.ms).swap(
                    builder: (context, child) {
                      return ChatBubble.left(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To start chatting, you need to',
                              style: context.shadTextTheme.list,
                            ),
                            const SizedBox(height: 16),
                            ShadButton(
                              onPressed: () {
                                context.push(ListLlmPage.route);
                              },
                              size: ShadButtonSize.lg,
                              text: Text(
                                'Download model',
                                style: context.shadTextTheme.large.copyWith(
                                  color: context.shadColor.primaryForeground,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                launchUrlString(
                                  'https://huggingface.co/microsoft/Phi-3-mini-4k-instruct',
                                );
                              },
                              child: Text(
                                'microsoft/Phi-3-mini-4k-instruct',
                                style: context.shadTextTheme.list.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '''The model takes about 2.2GB in space and it works great on phone with 4GB of RAM or more.''',
                              style: context.shadTextTheme.list,
                            ),
                            Text(
                              '''You can also try other models by saving them to your phone and then''',
                              style: context.shadTextTheme.list,
                            ),
                            const SizedBox(height: 16),

                            // PICK LLM BUTTON
                            const PickLlmButton(),
                            
                            const SizedBox(height: 16),
                            Text(
                              '''noticing that some models might not work great on mobile device.''',
                              style: context.shadTextTheme.list,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              '*Microsoft and Phi 3 are trademarks of '
                              'Microsoft Corporation',
                              style: context.shadTextTheme.list
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(begin: 0, duration: 200.ms);
                    },
                  ),
                ],
              ),
            ),

            // Typing
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                decoration: BoxDecoration(
                  color: context.shadColor.background,
                  border:
                      Border(top: BorderSide(color: context.shadColor.border)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: ChatInput(enabled: false),
                          ),
                        ),
                        SizedBox(width: 16),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: ChatGenerating(),
                        ),
                        SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'The data could be inaccurate.',
                      style: context.shadTextTheme.muted.copyWith(
                        fontSize: 11,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
