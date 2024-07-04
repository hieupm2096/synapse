import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/data_source/conversation/conversation_lds.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy();

  FlutterError.onError = (details) {
    logError(details.exceptionAsString(), details.stack);
  };

  // Show a loading indicator before running the full app (optional)
  // The platform's loading screen will be used while awaiting if you omit this.
  // runApp(const LoadingScreen());

  final isar = await initIsarClient();

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),

        // TODO(hieupm): for developing purpose, remove it later
        conversationLDSProvider.overrideWith(fixtureConversationLDS),
      ],
      child: await builder(),
    ),
  );
}
