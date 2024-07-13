import 'dart:async';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/core/extension/shadcn_ext.dart';
import 'package:synapse/core/service/download_manager.dart';
import 'package:synapse/feature/llm/provider/download_llm_provider.dart';
import 'package:synapse/shared/shared.dart';

class AppDownloaderWrapper extends ConsumerStatefulWidget {
  const AppDownloaderWrapper({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppDownloaderWrapperState();
}

class _AppDownloaderWrapperState extends ConsumerState<AppDownloaderWrapper>
    with WidgetsBindingObserver {
  final _progressStream = StreamController<double>.broadcast();

  final _downloadQueue = <String>{};

  @override
  void initState() {
    ref.read(fileDownloaderProvider).updates.listen(
      (event) {
        switch (event) {
          case TaskStatusUpdate():
            switch (event.status) {
              case TaskStatus.enqueued:
              case TaskStatus.running:
              case TaskStatus.notFound:
              case TaskStatus.waitingToRetry:
              case TaskStatus.paused:
                break;

              case TaskStatus.complete:
              case TaskStatus.failed:
              case TaskStatus.canceled:
                logDebug('dequeued: ${event.task.taskId}');
                _downloadQueue.remove(event.task.taskId);
            }

          case TaskProgressUpdate():
            if (!_downloadQueue.contains(event.task.taskId)) {
              logDebug('enqueued: ${event.task.taskId}');
              _downloadQueue.add(event.task.taskId);
            }

            if (event.task.taskId == _downloadQueue.firstOrNull) {
              _progressStream.add(event.progress);
            }

            if (event.progress == 1) {
              logDebug('dequeued: ${event.task.taskId}');
              _downloadQueue.remove(event.task.taskId);
            }
        }
      },
    );

    // to check background - foreground
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      logDebug('onBackground');
    }

    if (state == AppLifecycleState.resumed) {
      logDebug('onForeground');
      ref.read(fileDownloaderProvider).resumeFromBackground();
    }
  }

  @override
  void dispose() {
    _progressStream.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      floatingActionButton: StreamBuilder<double>(
        stream: _progressStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const SizedBox.shrink();

          final asyncTaskSet = ref.watch(
            downloadLlmProvider.select(
              (value) => value.value?.taskSet.length,
            ),
          );

          if (asyncTaskSet == null || asyncTaskSet == 0) {
            return const SizedBox.shrink();
          }

          return switch (snapshot.connectionState) {
            ConnectionState.active => TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: snapshot.data ?? 0),
                duration: Durations.short4,
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      border: ProgressBorder.all(
                        color: context.shadColor.success,
                        width: 6,
                        progress: value,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: Text(
                        asyncTaskSet.toString(),
                        style: context.shadTextTheme.h3.copyWith(
                          color: context.shadColor.primaryForeground,
                        ),
                      ),
                    ),
                  );
                },
              ),
            _ => const SizedBox.shrink()
          };
        },
      ),
    );
  }
}
