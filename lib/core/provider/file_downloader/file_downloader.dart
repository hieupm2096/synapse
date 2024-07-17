// A service dedicated to background_downloader library

import 'package:background_downloader/background_downloader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_downloader.g.dart';

@Riverpod(keepAlive: true)
FileDownloader fileDownloader(FileDownloaderRef ref) => FileDownloader();
