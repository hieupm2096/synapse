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
    ref.read(fileDownloaderProvider).registerCallbacks(
      taskStatusCallback: (update) async {
        logDebug(
          'Status update for ${update.task} with status ${update.status}',
        );

        // TODO(hieupm): recheck when to remove task from task set
        if (update.status != TaskStatus.complete) return;

        final task = update.task;

        final taskId = task.taskId;

        final taskSet = (state.value?.taskSet ?? {})..remove(taskId);

        // update UI
        state = AsyncData(DownloadLlmSuccess(taskSet: taskSet, llmId: taskId));

        // update repository data
        final getLlmModelRes =
            await ref.read(llmRepositoryProvider).getLlmModel(
                  id: taskId,
                );

        final llmModel = getLlmModelRes.success;

        if (llmModel == null) {
          logError('unexpected_error: could not find llm model');
          return;
        }

        final absolutePath = await task.filePath();

        final relativePath = absolutePath.split('/').last;

        final newLlmModel = llmModel.copyWith(path: relativePath);

        final updateLlmModelRes = await ref
            .read(llmRepositoryProvider)
            .updateLlmModel(data: newLlmModel);

        final updatedLlmModel = updateLlmModelRes.success;

        if (updatedLlmModel == null) {
          logError('unexpected_error: could not update llm model');
          return;
        }

        await ref
            .read(listLLMAsyncNotifierProvider.notifier)
            .updateLlmModel(data: updatedLlmModel);
      },
    );

    final records = await ref
        .read(fileDownloaderProvider)
        .database
        .allRecordsWithStatus(TaskStatus.running);

    return DownloadLlmInitial(taskSet: records.map((e) => e.taskId).toSet());
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
    required String llmId,
  }) async {
    final taskSet = state.value?.taskSet ?? {};

    if (!taskSet.contains(llmId)) return;

    state = const AsyncLoading();

    final res = await ref.read(fileDownloaderProvider).cancelTaskWithId(llmId);

    if (!res) {
      state = AsyncError(Exception('unexpected'), StackTrace.current);
      return;
    }

    taskSet.remove(llmId);

    state = AsyncData(CancelDownloadLlmSuccess(taskSet: taskSet));
  }
}
