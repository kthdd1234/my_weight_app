import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonCalendar.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/page/ContainerPage.dart';
import 'package:my_weight_app/provider/SelectedDateTimeProvider.dart';
import 'package:my_weight_app/provider/TitleDateTimeProvider.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  Widget? markerBuilder(bool isLight, DateTime dateTime) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          CommonText(
            text: '75.1kg',
            fontSize: 11,
            color: blue.original,
            isNotTr: true,
          ),
          CommonText(
            text: '75.6kg',
            fontSize: 11,
            color: red.s300,
            isNotTr: true,
          ),
        ],
      ),
    );
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  onDaySelected(DateTime dateTime) {
    navigator(context: context, page: ContainerPage(dateTime: dateTime));
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return CommonCalendar(
      rowHeight: 72,
      selectedDateTime: selectedDateTime,
      calendarFormat: CalendarFormat.month,
      shouldFillViewport: false,
      todayBuilder: todayBuilder,
      markerBuilder: markerBuilder,
      onPageChanged: onPageChanged,
      onDaySelected: onDaySelected,
      onFormatChanged: (_) {},
    );
  }
}
