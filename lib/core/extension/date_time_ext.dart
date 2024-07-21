import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format(String dateFormat) {
    return DateFormat(dateFormat).format(this);
  }
}
