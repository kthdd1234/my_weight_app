import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:my_weight_app/common/CommonCalendar.dart';
import 'package:my_weight_app/common/CommonImage.dart';
import 'package:my_weight_app/common/CommonMask.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonTag.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/model/reocrd_box/record_box.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/page/ContainerPage.dart';
import 'package:my_weight_app/provider/SelectedDateTimeProvider.dart';
import 'package:my_weight_app/provider/TitleDateTimeProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/NativeAdBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    super.key,
    required this.selectedSegment,
    required this.isLight,
    required this.isPremium,
  });

  bool isLight, isPremium;
  SegmentedTypes selectedSegment;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  Widget? markerBuilder(bool isLight, DateTime dateTime) {
    UserBox user = userRepository.user;
    String weightUint = user.weightUnit;
    int recordKey = dateTimeKey(dateTime);
    RecordBox? record = recordRepository.recordBox.get(recordKey);

    String morningWeight = record?.morningWeight != null
        ? '${record?.morningWeight}$weightUint'
        : '';
    String nightWeight =
        record?.nightWeight != null ? '${record?.nightWeight}$weightUint' : '';

    bool isMorning = morningWeight != '';
    bool isNight = nightWeight != '';

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          CommonTag(
            vertical: 1,
            horizontal: 5,
            text: morningWeight,
            fontSize: defaultFontSize - 6,
            colorName: isMorning ? '파란색' : '투명',
            isSelection: isMorning,
            isNotTr: true,
            isColor: isMorning,
            onTap: () => onDaySelected(dateTime),
          ),
          CommonSpace(height: 4),
          CommonTag(
            vertical: 1,
            horizontal: 5,
            text: nightWeight,
            fontSize: defaultFontSize - 6,
            colorName: isNight ? '빨간색' : '투명',
            isSelection: isNight,
            isNotTr: true,
            isColor: isNight,
            onTap: () => onDaySelected(dateTime),
          )
        ],
      ),
    );
  }

  Widget? imageBuildler(bool isLight, DateTime dateTime) {
    int recordKey = dateTimeKey(dateTime);
    RecordBox? record = recordRepository.recordBox.get(recordKey);
    List<Uint8List> imageList = record?.imageList ?? [];

    if (imageList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Center(
              child: CommonImage(
                uint8List: imageList.first,
                width: 40,
                height: 40,
                onTap: (_) {},
              ),
            ),
            Center(child: CommonMask(width: 40, height: 40, opacity: 0.2)),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  color: isToday(dateTime) ? darkButtonColor : null,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CommonText(
                  text: '${dateTime.day}',
                  color: Colors.white,
                  isBold: true,
                  isNotTr: true,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return null;
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  onDaySelected(DateTime dateTime) async {
    String? result = await navigator(
        context: context, page: ContainerPage(dateTime: dateTime));

    if (!context.mounted) return;

    if (result == 'showAd' && widget.isPremium == false) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => NativeAdBottomSheet(isLight: widget.isLight),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) => CommonCalendar(
        rowHeight: 80,
        selectedDateTime: selectedDateTime,
        calendarFormat: CalendarFormat.month,
        shouldFillViewport: false,
        todayBuilder: todayBuilder,
        markerBuilder: widget.selectedSegment == SegmentedTypes.weight
            ? markerBuilder
            : imageBuildler,
        onPageChanged: onPageChanged,
        onDaySelected: onDaySelected,
        onFormatChanged: (_) {},
      ),
    );
  }
}
