import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/chat/chat.dart';
import 'package:synapse/feature/conversation/conversation.dart';
import 'package:synapse/feature/llm/llm.dart';
import 'package:synapse/feature/onboard/onboard.dart';
import 'package:synapse/feature/setting/setting.dart';
import 'package:synapse/feature/splash/splash.dart';

part 'router.g.dart';

final class GoNavigationObserver extends NavigatorObserver {
  static List<String> backStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '';

    backStack.add(routeName);

    logDebug(backStack.toString());
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    backStack.removeLast();

    logDebug(backStack.toString());
  }
}

@Riverpod(keepAlive: true)
Raw<GoRouter> goRouter(GoRouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: SplashPage.route,
    observers: [
      if (kDebugMode) GoNavigationObserver(),
    ],
    routes: [
      GoRoute(
        path: SplashPage.route,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: ListConversationPage.route,
        builder: (context, state) => const ListConversationPage(),
        routes: [
          GoRoute(
            path: ChatPage.route,
            builder: (context, state) => ChatPage(
              conversationId: int.parse(state.pathParameters['id']!),
            ),
          ),
        ],
      ),
      GoRoute(
        path: OnboardPage.route,
        builder: (context, state) => const OnboardPage(),
      ),
      GoRoute(
        path: ListLlmPage.route,
        builder: (context, state) => const ListLlmPage(),
      ),
      GoRoute(
        path: SettingPage.route,
        builder: (context, state) => const SettingPage(),
      ),
    ],
  );
}
