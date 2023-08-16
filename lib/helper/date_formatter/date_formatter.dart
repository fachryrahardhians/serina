import 'package:intl/intl.dart';

extension DateTimeFormatExtension on DateTime {
  String toStringAMPM() {
    final format = DateFormat('hh.mm a');
    return format.format(this);
  }
}