import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/common/CommonSegmented.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/graph/ContainerGraph.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  late DateTime startDateTime, endDateTime;
  SegmentedTypes selectedDateTimeSegment = SegmentedTypes.week;
  String graphCategory = 'weight';

  onSegmentedDateTimeChanged(SegmentedTypes? segmented) {
    setState(() {
      selectedDateTimeSegment = segmented!;
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
  void initState() {
    DateTime now = DateTime.now();

    startDateTime = jumpDayDateTime(
      type: JumpDayTypeEnum.subtract,
      dateTime: now,
      days: rangeInfo[selectedDateTimeSegment]!,
    );

    endDateTime = now;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '몸무게 변화'),
        body: Column(
          children: [
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
        ),
      ),
    );
  }
}
