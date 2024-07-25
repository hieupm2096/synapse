import 'dart:async';
import 'dart:math';

import 'package:background_downloader/background_downloader.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';
import 'package:synapse/feature/llm/repository/llm_repository.dart';

part 'download_llm_provider.g.dart';

abstract class DownloadLlmState {
  const DownloadLlmState({required this.taskSet});

  final Set<String> taskSet;
}

final class DownloadLlmInitial extends DownloadLlmState {
  const DownloadLlmInitial({required super.taskSet});
}

final class EnqueueLlmSuccess extends DownloadLlmState {
  const EnqueueLlmSuccess({required super.taskSet});
}

final class EnqueueLlmFailure extends DownloadLlmState {
  const EnqueueLlmFailure({required this.error, required super.taskSet});

  final Exception error;
}

final class DownloadLlmSuccess extends DownloadLlmState {
  const DownloadLlmSuccess({
    required super.taskSet,
    required this.llmId,
  });

  final String llmId;
}

final class CancelDownloadLlmSuccess extends DownloadLlmState {
  const CancelDownloadLlmSuccess({required super.taskSet});
}

final class CancelDownloadLlmFailure extends DownloadLlmState {
  const CancelDownloadLlmFailure({
    required this.error,
    required super.taskSet,
  });

  final Exception error;
}

@Riverpod(keepAlive: true)
class DownloadLlm extends _$DownloadLlm {
  @override
  FutureOr<DownloadLlmState> build() async {
    ref.read(fileDownloaderProvider).updates.listen(
      (event) {
        switch (event) {
          case TaskStatusUpdate():
            _onTaskStatusUpdate(event);
          case TaskProgressUpdate():
            _onTaskProgressUpdate(event);
        }
      },
    );

    final runningRecs = await ref
        .read(fileDownloaderProvider)
        .database
        .allRecordsWithStatus(TaskStatus.running);

    final pausedRecs = await ref
        .read(fileDownloaderProvider)
        .database
        .allRecordsWithStatus(TaskStatus.paused);

    return DownloadLlmInitial(
      taskSet: [...runningRecs, ...pausedRecs].map((e) => e.taskId).toSet(),
    );
  }

  Future<void> downloadLlmModel({
    required String url,
    required String llmId,
  }) async {
    state = const AsyncLoading();

    final res = await ref.read(fileDownloaderProvider).enqueue(
          DownloadTask(
            url: url,
            taskId: llmId,
            updates: Updates.statusAndProgress,
          ),
        );

    if (!res) {
      state = AsyncError(Exception('unexpected'), StackTrace.current);
      return;
    }

    final taskSet = (state.value?.taskSet ?? {})..add(llmId);

    state = AsyncData(EnqueueLlmSuccess(taskSet: taskSet));
  }

  Future<void> cancelDownload({
    required String taskId,
  }) async {
    final taskSet = state.value?.taskSet ?? {};

    if (!taskSet.contains(taskId)) return;

    state = const AsyncLoading();

    final res = await ref.read(fileDownloaderProvider).cancelTaskWithId(taskId);

    if (!res) {
      state = AsyncError(Exception('unexpected'), StackTrace.current);
      return;
    }

    taskSet.remove(taskId);

    ref.invalidate(downloadProgressProvider(taskId));

    ref.read(overallProgressProvider.notifier).removeTask(taskId);

    state = AsyncData(CancelDownloadLlmSuccess(taskSet: taskSet));
  }

  Future<void> _onTaskStatusUpdate(TaskStatusUpdate event) async {
    logDebug('Status update: ${event.task} - ${event.status}');

    final task = event.task;

    final taskId = task.taskId;

    // If download task is not complete, do nothing
    // The cancel operation already performed in cancel function
    if (event.status != TaskStatus.complete) return;

    // Handle complete task
    final taskSets = (state.value?.taskSet ?? {})..remove(taskId);

    ref.read(overallProgressProvider.notifier).removeTask(taskId);

    if (taskSets.isEmpty) {
      ref.invalidate(overallProgressProvider);
    }

    ref.invalidate(downloadProgressProvider(taskId));

    // update UI
    state = AsyncData(DownloadLlmSuccess(taskSet: taskSets, llmId: taskId));

    // update repository data
    final absolutePath = await task.filePath();

    final relativePath = absolutePath.split('/').last;

    final updatedLlmRes = await ref
        .read(llmRepositoryProvider)
        .updateLlmModel(id: taskId, relativePath: relativePath);

    if (updatedLlmRes.success == null) {
      return;
    }

    await ref
        .read(listLLMAsyncNotifierProvider.notifier)
        .updateLlmModel(data: updatedLlmRes.success!);
  }

  Future<void> _onTaskProgressUpdate(
    TaskProgressUpdate event,
  ) async {
    logDebug('Progress update: ${event.task} - ${event.progress}');

    final taskId = event.task.taskId;

    if (event.progress >= 0) {
      ref
          .read(downloadProgressProvider(taskId).notifier)
          .updateProgress(event.progress);

      ref
          .read(overallProgressProvider.notifier)
          .updateProgress(taskId, event.progress);
    }
  }
}

@Riverpod(keepAlive: true)
class OverallProgress extends _$OverallProgress {
  final _progressMap = <String, double>{};

  @override
  double build() => 0;

  void updateProgress(String taskId, double progress) {
    _progressMap[taskId] = progress;

    state = _progressMap.values.reduce(max);
  }

  void removeTask(String taskId) {
    _progressMap.remove(taskId);

    if (_progressMap.isEmpty) {
      ref.invalidateSelf();
    }
  }
}

@Riverpod(keepAlive: true)
class DownloadProgress extends _$DownloadProgress {
  @override
  double build(String taskId) => 0;

  // ignore: use_setters_to_change_properties
  void updateProgress(double value) {
    state = value;
  }
}
