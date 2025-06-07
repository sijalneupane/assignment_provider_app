import 'package:intl/intl.dart';

class DateFormatter{
  String formatDate(String isoDateString) {
  DateTime dateTime = DateTime.parse(isoDateString);
  return DateFormat('yyyy-MM-dd – hh:mm a').format(dateTime.toLocal());
}
}