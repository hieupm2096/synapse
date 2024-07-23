import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/router/router.dart';
import 'package:synapse/app/view/app_downloader.dart';
import 'package:synapse/feature/setting/provider/app_setting_provider.dart';
import 'package:synapse/l10n/l10n.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    final darkMode = ref.watch(darkModeProvider).value ?? false;

    return ShadApp.router(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      builder: (context, child) {
        return AppDownloaderWrapper(child: child);
      },
    );
  }
}
