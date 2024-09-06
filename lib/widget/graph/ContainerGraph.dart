import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/graph/TitleDateTimeGraph.dart';
import 'package:my_weight_app/widget/graph/WeightGraph.dart';

class ContainerGraph extends StatelessWidget {
  ContainerGraph({
    super.key,
    required this.graphCategory,
    required this.graphType,
    required this.selectedDateTimeSegment,
    required this.startDateTime,
    required this.endDateTime,
    required this.setChartSwipeDirectionStart,
    required this.setChartSwipeDirectionEnd,
  });

  String graphType, graphCategory;
  SegmentedTypes selectedDateTimeSegment;
  DateTime startDateTime, endDateTime;
  Function() setChartSwipeDirectionStart, setChartSwipeDirectionEnd;

  int get range {
    if (graphType == eGraphCustom) {
      int days = daysBetween(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
      );

      return days;
    }

    return rangeInfo[selectedDateTimeSegment]!;
  }

  @override
  Widget build(BuildContext context) {
    bool isWeek = selectedDateTimeSegment == SegmentedTypes.week ||
        selectedDateTimeSegment == SegmentedTypes.twoWeek;
    bool isVisible = isWeek && (graphType == eGraphDefault);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TitleDateTimeGraph(
              startDateTime: startDateTime,
              endDateTime: endDateTime,
            ),
            Expanded(
              child: WeightGraph(
                graphType: graphType,
                isWeek: isWeek,
                isVisible: isVisible,
                range: range,
                selectedDateTimeSegment: selectedDateTimeSegment,
                startDateTime: startDateTime,
                endDateTime: endDateTime,
                setChartSwipeDirectionStart: setChartSwipeDirectionStart,
                setChartSwipeDirectionEnd: setChartSwipeDirectionEnd,
              ),
            )
          ],
        ),
      ),
    );
  }
}
