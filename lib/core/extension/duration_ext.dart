extension DurationExt on Duration {
  String formatDuration() {
    if (inHours > 0) {
      return '''$inHours hour${inHours > 1 ? 's' : ''} ${inMinutes.remainder(60)} minute${inMinutes.remainder(60) > 1 ? 's' : ''}''';
    } else if (inMinutes > 0) {
      return '$inMinutes minute${inMinutes > 1 ? 's' : ''}';
    } else {
      return '$inSeconds second${inSeconds > 1 ? 's' : ''}';
    }
  }
}
