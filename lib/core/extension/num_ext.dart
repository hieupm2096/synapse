import 'dart:math';

extension IntExt on int {
  String getFileSize() {
    if (this <= 0) return '0B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(this) / log(1024)).floor();
    return '${(this / pow(1024, i)).toStringAsFixed(2)}${suffixes[i]}';
  }
}
