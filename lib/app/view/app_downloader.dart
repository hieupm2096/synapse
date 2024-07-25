import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

class AppDownloaderWrapper extends StatefulWidget {
  const AppDownloaderWrapper({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<StatefulWidget> createState() => _AppDownloaderWrapperState();
}

class _AppDownloaderWrapperState extends State<AppDownloaderWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // to check background - foreground
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      logDebug('onBackground');
    }

    if (state == AppLifecycleState.resumed) {
      logDebug('onForeground');
      FileDownloader().resumeFromBackground();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
