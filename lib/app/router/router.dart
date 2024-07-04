import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/chat/chat.dart';
import 'package:synapse/feature/conversation/conversation.dart';

part 'router.g.dart';

final class GoNavigationObserver extends NavigatorObserver {
  static List<String> backStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    backStack.add(route.settings.name ?? '');

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
    observers: [
      if (kDebugMode) GoNavigationObserver(),
    ],
    routes: [
      GoRoute(
        path: ChatPage.route,
        builder: (context, state) => const ChatPage(),
        routes: [
          GoRoute(
            path: ListConversationPage.route,
            builder: (context, state) => const ListConversationPage(),
          ),
        ],
      ),
    ],
  );
}
