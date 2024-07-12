import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/feature/llm/llm.dart';
import 'package:synapse/feature/splash/provider/splash_page_provider.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  static String route = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      splashPageProvider,
      (previous, next) {
        if (next.value is SplashLoadedSuccess) {
          context.go('/');
        } else if (next.value is NoLlm) {
          context.go(ListLlmPage.route);
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
                .fade(begin: 0, end: 1, duration: 500.ms),
          ),
          const Icon(
            LucideIcons.brain,
            size: 48,
          ).animate().moveY(
                begin: 0,
                end: -16,
                duration: 500.ms,
              ),
        ],
      ),
    );
  }
}
