import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/feature/llm/llm.dart';
import 'package:synapse/feature/onboard/page/onboard_page.dart';
import 'package:synapse/feature/setting/provider/app_setting_provider.dart';
import 'package:synapse/feature/splash/provider/splash_page_provider.dart';
import 'package:synapse/gen/assets.gen.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  static String route = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      splashPageProvider,
      (previous, next) {
        switch (next.valueOrNull) {
          case SplashLoadedSuccess(:final conversationId):
            context.replace('${ListConversationPage.route}/$conversationId');
          case NoConversation():
            context.replace(ListConversationPage.route);
          case NoLlm():
            context.replace(OnboardPage.route);
          case _:
            context.replace(ListLlmPage.route);
        }
      },
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: const CupertinoActivityIndicator()
                .animate()
                .fade(begin: 0, end: 1, duration: 2.seconds),
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Consumer(
              builder: (context, ref, child) {
                final asyncDarkMode =
                    ref.watch(darkModeProvider).value ?? false;

                return (asyncDarkMode
                        ? Assets.logo.logoDark.image(
                            fit: BoxFit.cover,
                            height: 32,
                          )
                        : Assets.logo.logo.image(
                            fit: BoxFit.cover,
                            height: 32,
                          ))
                    .animate(delay: 250.ms)
                    .fade(begin: 0, end: 1, duration: 500.ms)
                    .moveY(
                      begin: 0,
                      end: -16,
                      duration: 500.ms,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
