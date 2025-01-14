import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static String formatDateTime(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(date);
  }

}