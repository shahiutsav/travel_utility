import 'package:intl/intl.dart';

class DateUtil {
  static DateTime convertToDate(String dateString) {
    return DateTime.parse(dateString);
  }

  static String getDay(String dateString) {
    final DateTime date = convertToDate(dateString);
    final int day = date.day;
    var dayString = day.toString();

    var numberOfZeroRequired = 2 - dayString.length;

    while (numberOfZeroRequired != 0) {
      dayString = '0$dayString';
      numberOfZeroRequired--;
    }

    return dayString;
  }

  static String getMonthName(String dateString) {
    final DateTime date = convertToDate(dateString);
    final String monthName = DateFormat.MMM().format(date);
    return monthName;
  }
}
