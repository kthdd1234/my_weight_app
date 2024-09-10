import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/model/reocrd_box/record_box.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeightGraph extends StatefulWidget {
  WeightGraph({
    super.key,
    required this.graphType,
    required this.isWeek,
    required this.isVisible,
    required this.range,
    required this.selectedDateTimeSegment,
    required this.startDateTime,
    required this.endDateTime,
    required this.setChartSwipeDirectionStart,
    required this.setChartSwipeDirectionEnd,
  });

  String graphType;
  bool isWeek, isVisible;
  int range;
  SegmentedTypes selectedDateTimeSegment;
  DateTime startDateTime, endDateTime;
  Function() setChartSwipeDirectionStart, setChartSwipeDirectionEnd;

  @override
  State<WeightGraph> createState() => _WeightGraphState();
}

class _WeightGraphState extends State<WeightGraph> {
  double? weightMinimum, weightMaximum;

  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    String weightUnit = user.weightUnit;
    double? goalWeight = user.goalInfo['goalWeight'];
    String locale = context.locale.toString();
    List<PlotBand> plotBandList = <PlotBand>[
      PlotBand(
        borderWidth: 1.0,
        borderColor: purple.s200,
        isVisible: true,
        // text: '목표 몸무게: ${goalWeight ?? '-'}$weightUnit'.tr(),
        text: '목표 몸무게: '.tr(
          namedArgs: {"goalWeight": '${goalWeight ?? '-'}', 'unit': weightUnit},
        ),
        textStyle: TextStyle(color: purple.s300),
        start: goalWeight ?? 0.0,
        end: goalWeight ?? 0.0,
        dashArray: const <double>[4, 5],
      )
    ];

    onPlotAreaSwipe(ChartSwipeDirection direction) {
      setState(() {
        switch (direction) {
          case ChartSwipeDirection.start:
            widget.setChartSwipeDirectionStart();

            break;
          case ChartSwipeDirection.end:
            widget.setChartSwipeDirectionEnd();

            break;
          default:
        }
      });
    }

    getRecordInfo(DateTime datatime) {
      int recordKey = dateTimeKey(datatime);
      return recordRepository.recordBox.get(recordKey);
    }

    onSeriesDateTime({required String type, required DateTime endPoint}) {
      List<GraphData> seriesData = [];
      List<double> weightList = [];

      for (var i = 0; i <= widget.range; i++) {
        DateTime subtractDateTime = jumpDayDateTime(
          type: JumpDayTypeEnum.subtract,
          dateTime: endPoint,
          days: i,
        );
        RecordBox? recordInfo = getRecordInfo(subtractDateTime);
        String x = getGraphX(
          locale: locale,
          isWeek: widget.isWeek,
          graphType: widget.graphType,
          dateTime: subtractDateTime,
        );
        double? weight = type == 'morning'
            ? recordInfo?.morningWeight
            : recordInfo?.nightWeight;
        GraphData chartData = GraphData(x, weight);

        if (recordInfo?.morningWeight != null) {
          weightList.add(recordInfo!.morningWeight!);
        }

        if (recordInfo?.nightWeight != null) {
          weightList.add(recordInfo!.nightWeight!);
        }

        seriesData.add(chartData);
      }

      return [seriesData, weightList];
    }

    fastLineSeries(String type) {
      final seriesData =
          onSeriesDateTime(type: type, endPoint: widget.endDateTime);
      final fastLineSeriesData = seriesData[0] as List<GraphData>;
      final weightList = seriesData[1] as List<double>;

      setState(() {
        if (weightList.isEmpty) {
          weightMinimum = 0.0;
          weightMaximum = 100.0;
        } else {
          weightMinimum = (weightList.reduce(min) - 1).floorToDouble();
          weightMaximum = (weightList.reduce(max) + 1).floorToDouble();
        }
      });

      return fastLineSeriesData.reversed.toList();
    }

    setFastLineSeries(String type) {
      return FastLineSeries(
        emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.drop),
        dataSource: fastLineSeries(type),
        color: type == 'morning' ? blue.s300 : red.s200,
        xValueMapper: (data, _) => data.x,
        yValueMapper: (data, _) => data.y,
        markerSettings: MarkerSettings(isVisible: widget.isVisible),
        dataLabelSettings: DataLabelSettings(
          isVisible: widget.isVisible,
          textStyle: TextStyle(
            color: type == 'morning' ? blue.original : red.s300,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    fastLineSeries('morning');
    fastLineSeries('night');

    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
        header: '',
        enable: true,
        format: 'point.x: point.y$weightUnit',
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
        minimum: weightMinimum,
        maximum: weightMaximum,
        plotBands: plotBandList,
      ),
      series: [setFastLineSeries('morning'), setFastLineSeries('night')],
      onPlotAreaSwipe: onPlotAreaSwipe,
    );
  }
}
