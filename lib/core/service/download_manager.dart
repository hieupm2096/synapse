// A service dedicated to background_downloader library

import 'package:background_downloader/background_downloader.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'download_manager.g.dart';

@Riverpod(keepAlive: true)
FileDownloader fileDownloader(FileDownloaderRef ref) => FileDownloader();

@Riverpod(keepAlive: true)
DownloadManager downloadManager(DownloadManagerRef ref) {
  return DownloadManager(downloader: ref.read(fileDownloaderProvider));
}

@riverpod
Future<bool> isDownloading(IsDownloadingRef ref, String url) async {
  final res = await ref.read(downloadManagerProvider).isDownloading(url);
  return res;
}

final class DownloadManager {
  const DownloadManager({
    required FileDownloader downloader,
  }) : _downloader = downloader;

  final FileDownloader _downloader;

  Future<bool> startDownload(
    String url, {
    String? taskId,
  }) async {
    final downloading = await isDownloading(taskId ?? url);

    if (downloading) return false;

    final res = await _downloader.enqueue(
      DownloadTask(
        taskId: url,
        url: url,
      ),
    );
    return res;
  }

  Stream<TaskUpdate> get updateStream => _downloader.updates;

  Future<bool> isDownloading(String url) async {
    final currentDatabases = await _downloader.database.allRecords();

    logDebug(currentDatabases.length);

    final task = await _downloader.database.recordForId(url);

    return task != null &&
        (task.status == TaskStatus.enqueued ||
            task.status == TaskStatus.running ||
            task.status == TaskStatus.waitingToRetry);
  }

  Future<bool> cancelDownload(String url) async {
    return _downloader.cancelTaskWithId(url);
  }
}
