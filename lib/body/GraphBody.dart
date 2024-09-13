import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonBannerAd.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSegmented.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/PremiumProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/graph/ContainerGraph.dart';
import 'package:provider/provider.dart';

class GraphBody extends StatefulWidget {
  const GraphBody({super.key});

  @override
  State<GraphBody> createState() => _GraphBodyState();
}

class _GraphBodyState extends State<GraphBody> {
  late DateTime startDateTime, endDateTime;
  SegmentedTypes selectedDateTimeSegment = SegmentedTypes.week;
  String graphCategory = 'weight';

  @override
  void initState() {
    setTitleDateTime();
    super.initState();
  }

  setTitleDateTime() {
    DateTime now = DateTime.now();

    startDateTime = jumpDayDateTime(
      type: JumpDayTypeEnum.subtract,
      dateTime: now,
      days: rangeInfo[selectedDateTimeSegment]!,
    );
    endDateTime = now;
  }

  onSegmentedDateTimeChanged(SegmentedTypes? segmented) {
    setState(() {
      selectedDateTimeSegment = segmented!;
      setTitleDateTime();
    });
  }

  setChartSwipeDirectionStart() {
    setState(() {
      endDateTime = startDateTime;
      startDateTime = jumpDayDateTime(
        type: JumpDayTypeEnum.subtract,
        dateTime: endDateTime,
        days: rangeInfo[selectedDateTimeSegment]!,
      );
    });
  }

  setChartSwipeDirectionEnd() {
    setState(() {
      if (dateTimeKey(endDateTime) >= dateTimeKey(DateTime.now())) {
        // ignore: void_checks
        return showSnackBar(
          context: context,
          text: '미래의 날짜를 불러올 순 없어요.',
          buttonName: '확인',
        );
      }

      startDateTime = endDateTime;
      endDateTime = jumpDayDateTime(
        type: JumpDayTypeEnum.add,
        dateTime: startDateTime,
        days: rangeInfo[selectedDateTimeSegment]!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isPremium == false ? const CommonBannerAd() : const CommonNull(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: CommonText(text: '몸무게 변화', fontSize: defaultFontSize + 3),
        ),
        ContainerGraph(
          graphCategory: graphCategory,
          graphType: eGraphDefault,
          selectedDateTimeSegment: selectedDateTimeSegment,
          startDateTime: startDateTime,
          endDateTime: endDateTime,
          setChartSwipeDirectionStart: setChartSwipeDirectionStart,
          setChartSwipeDirectionEnd: setChartSwipeDirectionEnd,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: CommonSegmented(
            selectedSegment: selectedDateTimeSegment,
            children: rangeSegmented(selectedDateTimeSegment),
            onSegmentedChanged: onSegmentedDateTimeChanged,
          ),
        ),
      ],
    );
  }
}
