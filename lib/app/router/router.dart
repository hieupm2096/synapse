import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/chat/chat.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> goRouter(GoRouterRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: ChatPage.route,
        builder: (context, state) => const ChatPage(),
      ),
    ],
  );
}
