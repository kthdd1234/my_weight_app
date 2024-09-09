import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonCalendar extends StatefulWidget {
  CommonCalendar({
    super.key,
    required this.selectedDateTime,
    required this.calendarFormat,
    required this.shouldFillViewport,
    required this.markerBuilder,
    required this.onPageChanged,
    required this.onDaySelected,
    required this.onFormatChanged,
    this.todayBuilder,
    this.rowHeight,
    this.isDefault,
    this.sixWeekMonthsEnforced,
    this.isNotGoal,
  });

  DateTime selectedDateTime;
  CalendarFormat calendarFormat;
  bool shouldFillViewport;
  bool? isDefault, sixWeekMonthsEnforced, isNotGoal;
  double? rowHeight;
  Function(bool, DateTime) markerBuilder;
  Function(bool, DateTime)? todayBuilder;
  Function(DateTime) onPageChanged, onDaySelected;
  Function(CalendarFormat) onFormatChanged;

  @override
  State<CommonCalendar> createState() => _CommonCalendarState();
}

class _CommonCalendarState extends State<CommonCalendar> {
  Widget? dowBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? themeColor
                : Colors.white;

    return CommonText(
      text: eFormatter(locale: locale, dateTime: dateTime),
      color: widget.isDefault == true ? color : themeColor,
      fontSize: defaultFontSize - 2,
      isNotTr: true,
    );
  }

  Widget? defaultBuilder(bool isLight, DateTime dateTime) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? themeColor
                : Colors.white;

    Map<String, dynamic> goalInfo = userRepository.user.goalInfo;
    DateTime? goalDateTime = goalInfo['goalDateTime'];
    bool isGoalDateTime = false;

    if (goalDateTime != null && widget.isNotGoal != true) {
      isGoalDateTime = dateTimeKey(goalDateTime) == dateTimeKey(dateTime);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 13.5),
      child: Column(
        children: [
          CommonText(
            text: isGoalDateTime ? '⛳️' : '${dateTime.day}',
            color: widget.isDefault == true ? color : themeColor,
            isNotTr: true,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;

    tableCalendar() {
      return TableCalendar(
        rowHeight: widget.rowHeight ?? 52,
        locale: locale,
        shouldFillViewport: widget.shouldFillViewport,
        sixWeekMonthsEnforced: widget.sixWeekMonthsEnforced == true,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: widget.sixWeekMonthsEnforced == true,
          cellMargin: const EdgeInsets.all(14),
          cellAlignment: widget.shouldFillViewport
              ? Alignment.topCenter
              : Alignment.center,
          todayDecoration: BoxDecoration(
            color: isLight ? darkButtonColor : calendarSelectedDateTimeBgColor,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: isLight ? Colors.white : calendarSelectedDateTimeTextColor,
            fontSize: defaultFontSize - 2,
          ),
        ),
        availableGestures: widget.shouldFillViewport
            ? AvailableGestures.horizontalSwipe
            : AvailableGestures.all,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (cx, dateTime, _) =>
              defaultBuilder(isLight, dateTime),
          dowBuilder: (cx, dateTime) => dowBuilder(isLight, dateTime),
          markerBuilder: (cx, dateTime, _) =>
              widget.markerBuilder(isLight, dateTime),
          todayBuilder: widget.todayBuilder != null
              ? (cx, dateTime, _) => widget.todayBuilder!(isLight, dateTime)
              : null,
        ),
        headerVisible: false,
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(3000, 1, 1),
        currentDay: widget.selectedDateTime,
        focusedDay: widget.selectedDateTime,
        calendarFormat: widget.calendarFormat,
        availableCalendarFormats: availableCalendarFormats,
        onPageChanged: widget.onPageChanged,
        onDaySelected: (dateTime, _) => widget.onDaySelected(dateTime),
        onFormatChanged: widget.onFormatChanged,
      );
    }

    return tableCalendar();
  }
}
