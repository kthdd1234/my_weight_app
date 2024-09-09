import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonCalendar.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSvgText.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:table_calendar/table_calendar.dart';

class GoalDateTimeBottomSheet extends StatefulWidget {
  GoalDateTimeBottomSheet({
    super.key,
    this.goalDateTime,
    required this.onDaySelected,
  });

  DateTime? goalDateTime;
  Function(DateTime) onDaySelected;

  @override
  State<GoalDateTimeBottomSheet> createState() =>
      _GoalDateTimeBottomSheetState();
}

class _GoalDateTimeBottomSheetState extends State<GoalDateTimeBottomSheet> {
  DateTime titleDateTime = DateTime.now();

  markerBuilder(bool isLight, DateTime dateTime) {
    DateTime now = DateTime.now();

    if (widget.goalDateTime != null &&
        dateTimeKey(widget.goalDateTime) == dateTimeKey(dateTime)) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: CommonText(text: '⛳️', isNotTr: true),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: CommonText(
        text: dateTimeKey(dateTime) == dateTimeKey(now) ? '오늘' : '',
        fontSize: 14,
        color: grey.original,
      ),
    );
  }

  todayBuilder(bool isLight, DateTime dateTime) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? themeColor
                : Colors.white;

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        children: [CommonText(text: '${dateTime.day}', color: color)],
      ),
    );
  }

  onPageChanged(DateTime dateTime) {
    setState(() => titleDateTime = dateTime);
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return CommonModalSheet(
        title: '목표 날짜',
        height: 500,
        child: CommonContainer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 5,
                ),
                child: Row(
                  children: [
                    CommonSvgText(
                      text:
                          yMFormatter(locale: locale, dateTime: titleDateTime),
                      fontSize: 20,
                      svgWidth: 10,
                      svgDirection: SvgDirection.right,
                    ),
                    Spacer(),
                    CommonText(
                      text: widget.goalDateTime != null
                          ? '⛳️ ${ymdeFullFormatter(
                              locale: locale,
                              dateTime: widget.goalDateTime!,
                            )}까지'
                          : '날짜를 선택해주세요',
                      color: grey.original,
                      fontSize: 13,
                    )
                  ],
                ),
              ),
              CommonCalendar(
                isNotGoal: true,
                isDefault: true,
                sixWeekMonthsEnforced: true,
                selectedDateTime: titleDateTime,
                calendarFormat: CalendarFormat.month,
                shouldFillViewport: false,
                markerBuilder: markerBuilder,
                todayBuilder: todayBuilder,
                onPageChanged: onPageChanged,
                onDaySelected: widget.onDaySelected,
                onFormatChanged: (CalendarFormat calendarFormat) {},
              ),
            ],
          ),
        ));
  }
}
