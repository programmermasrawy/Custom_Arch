import 'package:intl/intl.dart';

import '../logic/preferences_cubit/preferences_cubit.dart';

extension DateTimeExtended on DateTime {
  static DateTime fromSecondsSinceEpoch(int secondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  }

  String toFormattedStringEEEdd() =>
      DateFormat('EEE dd,').add_jm().format(this);

  String toFormattedStringdMMMy() => DateFormat('d MMMM y').format(this);
//data
  String toddMMyyyy() => DateFormat('yyyy-MM-dd').format(this);

//View
  String toFormattedStringMMMMY() =>
      DateFormat('d MMM y', languageCode).format(this);

  String toAuctionStartFormatString() =>
      DateFormat('EEE, MMMM d, y').add_jm().format(this);

  String toUtcFormmatedString() =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(toUtc());

  DateTime toMidnight(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  bool isWeekend() {
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }

  bool isToday() {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool isPastDay() {
    final today = toMidnight(DateTime.now());
    return isBefore(today);
  }

  DateTime addDaysToDate(int days) {
    DateTime newDate = add(Duration(days: days));

    if (hour != newDate.hour) {
      final hoursDifference = hour - newDate.hour;

      if (hoursDifference <= 3 && hoursDifference >= -3) {
        newDate = newDate.add(Duration(hours: hoursDifference));
      } else if (hoursDifference <= -21) {
        newDate = newDate.add(Duration(hours: 24 + hoursDifference));
      } else if (hoursDifference >= 21) {
        newDate = newDate.add(Duration(hours: hoursDifference - 24));
      }
    }
    return newDate;
  }

  bool isSpecialPastDay() {
    return isPastDay() || (isToday() && DateTime.now().hour >= 12);
  }

  DateTime getFirstDayOfNextMonth() {
    var dateTime = getFirstDayOfMonth();
    dateTime = addDaysToDate(31);
    dateTime = getFirstDayOfMonth();
    return dateTime;
  }

  DateTime getFirstDayOfMonth() {
    return DateTime(year, month);
  }

  DateTime getLastDayOfMonth() {
    final firstDayOfMonth = DateTime(year, month);
    final nextMonth = firstDayOfMonth.add(const Duration(days: 32));
    final firstDayOfNextMonth = DateTime(nextMonth.year, nextMonth.month);
    return firstDayOfNextMonth.subtract(const Duration(days: 1));
  }

  bool isSameDay(DateTime date2) {
    return day == date2.day && month == date2.month && year == date2.year;
  }

  bool isCurrentMonth() {
    final now = DateTime.now();
    return month == now.month && year == now.year;
  }

  int calculateMonthsDifference(DateTime endDate) {
    final yearsDifference = endDate.year - year;
    return 12 * yearsDifference + endDate.month - month;
  }

  int calculateWeeksNumber(DateTime monthEndDate) {
    int rowsNumber = 1;

    DateTime currentDay = this;
    while (currentDay.isBefore(monthEndDate)) {
      currentDay = currentDay.add(const Duration(days: 1));
      if (currentDay.weekday == DateTime.monday) {
        rowsNumber += 1;
      }
    }

    return rowsNumber;
  }
}
