import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
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
    String locale = context.locale.toString();
    List<PlotBand> plotBandList = <PlotBand>[
      PlotBand(
        borderWidth: 1.0,
        borderColor: grey.original,
        isVisible: true,
        text: '목표 체중: '.tr(
          namedArgs: {"weight": 'kg', 'unit': 'kg'},
        ),
        textStyle: TextStyle(color: grey.original),
        start: 71.2,
        end: 71.2,
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

    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
        header: '',
        enable: true,
        format: 'point.x: point.y${'kg'}',
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
        minimum: weightMinimum,
        maximum: weightMaximum,
        plotBands: plotBandList,
      ),
      series: [
        FastLineSeries(
          xValueMapper: (data, _) => data.x,
          yValueMapper: (data, _) => data.y,
          dataSource: [],
        )
      ],
      onPlotAreaSwipe: onPlotAreaSwipe,
    );
  }
}
