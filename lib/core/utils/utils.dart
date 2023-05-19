import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_colors.dart';
import 'dart:math' as math;
class Utils {
  static bool shouldUseDarkText(Color color) {
    return (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114) > 186;
  }
}

bool isNullOrEmpty(dynamic obj) =>
    obj == null ||
    ((obj is String || obj is List || obj is Map) && obj.isEmpty);

bool notNullNorEmpty(dynamic obj) =>
    obj != null &&
    ((obj is String || obj is List || obj is Map) && obj.isNotEmpty);

launchPhoneDialer(String phone) async {
  String url = "tel:" + phone;
  if (await launchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}

int daysRemainingTillNextMonth(DateTime date) {
  var daysLeft = 0;
  var lastDayOfNextRegistrationMonth = 0;

  final nextRegistrationCalender = getNextMonth(date);

  final nextRegistrationMonth = nextRegistrationCalender.month;

  lastDayOfNextRegistrationMonth = getLastDayOf(nextRegistrationCalender);

  final currentCalendar = DateTime.now();
  final currentMonth = currentCalendar.month;
  
  if (currentMonth == nextRegistrationMonth) {
    final currentDay = currentCalendar.day;
    daysLeft = lastDayOfNextRegistrationMonth - currentDay;
  } else {
    daysLeft = -1;
  }
  return daysLeft;
}

DateTime getNextMonth(DateTime date) {
  final nextMonth = (date.month < 12)
      ? DateTime(date.year, date.month + 1, 0)
      : DateTime(date.year + 1, 1, 0);
  return nextMonth;
}

int getLastDayOf(DateTime dateTime) {
  return getNextMonth(dateTime).day;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

int checkDateAfterDate(String? dateFormat, String? date1, String? date2) {
  try {
    DateFormat sdf = DateFormat("yyyy-MM-dd hh:mm:ss");

    final DateTime cal1 = sdf.parse(date1 ?? '');
    final DateTime cal2 = sdf.parse(date2 ?? '');
    if (cal1.isAfter(cal2)) {
      return 1;
    }
    if (cal1.isBefore(cal2)) {
      return 2;
    }
    if (cal1 == cal2) {
      return 0;
    }
  } catch (e) {
    e.toString();
  }
  return 0;
}

String convertDateFormatToAnother(String? srcDateFormat, String srcDate,
    String? destDateFormat, String? locale, bool useLocal) {
  try {
    final DateFormat srcDf = DateFormat(srcDateFormat, 'en');

    // parse the date string into Date object
    final DateTime date = srcDf.parse(srcDate);
    final DateFormat destDf =
        DateFormat(destDateFormat, (useLocal) ? locale : 'en');
    // format the date into another format
    destDf.format(date);
  } catch (e) {
    e.toString();
  }
  return srcDate;
}

  // void showOffersConsumptionDialog(
  //   List<AvailableOffer>? availableOfferModelArrayList,
  //   ScratchEntity? scratch,
  // ) {}

  // void showEmployeeDialog(String? voucher) {}

  // void showDefaultPhoneWarningDialog(bool hasDefaultPhone) {
  //   // val defaultPhoneWarningDialog = DefaultPhoneWarningDialog.newInstance(
  //   //     AppConstants.COME_FROM_HOME,
  //   //     hasDefaultPhone
  //   // ) as DefaultPhoneWarningDialog
  //   // defaultPhoneWarningDialog.setDefaultPhoneWarningDialogCallBack(this)
  //   // defaultPhoneWarningDialog.isCancelable = false
  //   // defaultPhoneWarningDialog.show(
  //   //     requireActivity().supportFragmentManager,
  //   //     DefaultPhoneWarningDialog.TAG
  //   // );
  // }

class CurvedPainter extends CustomPainter {
  bool background;
  double? arc;
  Color progressColor;

  CurvedPainter({this.arc,required this.progressColor,required this.background});
  @override
  void paint(Canvas canvas, Size size) {
    final rect =  Rect.fromLTRB(20, 0, ScreenUtil().screenWidth*.5, ScreenUtil().screenHeight * .2);
    final startAngle = -math.pi;
    final sweepAngle = arc!=null ? arc : math.pi;
    final userCenter = false;
    final paint = Paint()
    ..strokeCap = StrokeCap.round
    ..color = progressColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;

    if(background){

    }

    canvas.drawArc(rect, startAngle, sweepAngle!, userCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
