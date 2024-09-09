import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/widget/home/CalendarTitle.dart';
import 'package:my_weight_app/widget/home/CalendarView.dart';
import 'package:my_weight_app/widget/home/FnbButton.dart';
import 'package:my_weight_app/widget/home/HeaderBar.dart';
import 'package:my_weight_app/widget/home/TodayButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SegmentedTypes selectedSegment = SegmentedTypes.weight;

  onSegmentedChanged(SegmentedTypes? segmentedType) {
    setState(() => selectedSegment = segmentedType!);
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        body: Column(
          children: [
            const HeaderBar(),
            const Spacer(),
            CalendarTitle(
              selectedSegment: selectedSegment,
              onSegmentedChanged: onSegmentedChanged,
            ),
            CalendarView(selectedSegment: selectedSegment),
            const Spacer(),
            const TodayButton()
          ],
        ),
        floatingActionButton: const FnbButton(),
      ),
    );
  }
}
