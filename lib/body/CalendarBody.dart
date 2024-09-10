import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBannerAd.dart';
import 'package:my_weight_app/provider/PremiumProvider.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/widget/home/CalendarTitle.dart';
import 'package:my_weight_app/widget/home/CalendarView.dart';
import 'package:my_weight_app/widget/home/HeaderBar.dart';
import 'package:my_weight_app/widget/home/TodayButton.dart';
import 'package:provider/provider.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  SegmentedTypes selectedSegment = SegmentedTypes.weight;

  onSegmentedChanged(segment) {
    setState(() => selectedSegment = segment);
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Column(
      children: [
        const HeaderBar(),
        const Spacer(),
        CalendarTitle(
          selectedSegment: selectedSegment,
          onSegmentedChanged: onSegmentedChanged,
        ),
        CalendarView(
          isLight: isLight,
          isPremium: isPremium,
          selectedSegment: selectedSegment,
        ),
        const Spacer(),
        const TodayButton()
      ],
    );
  }
}
