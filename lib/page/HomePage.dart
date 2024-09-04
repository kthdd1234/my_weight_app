import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonCalendar.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/common/CommonSvg.dart';
import 'package:my_weight_app/common/CommonSvgText.dart';
import 'package:my_weight_app/common/CommonTag.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/page/GoalWeightPage.dart';
import 'package:my_weight_app/page/ContainerPage.dart';
import 'package:my_weight_app/provider/SelectedDateTimeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    //
  }

  onDaySelected(DateTime dateTime) {
    //
  }

  onGoalWeight() {
    navigator(context: context, page: const GoalWeightPage());
  }

  onCategory() {
    //
  }

  onGraph() {
    //
  }

  onSetting() {
    //
  }

  onFloatingAction() {
    navigator(context: context, page: ContainerPage());
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return CommonBackground(
      child: CommonScaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: darkButtonColor,
          onPressed: onFloatingAction,
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: CommonTag(
                    text: '⛳️ 2024년 10월 3일까지 70kg 달성!',
                    fontSize: 16,
                    onTap: onGoalWeight,
                  ),
                ),
                const Spacer(),
                CommonSvg(
                  name: 'top-graph',
                  onTap: onGraph,
                  padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                ),
                CommonSvg(
                  name: 'top-setting',
                  onTap: () {},
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 7,
                  ),
                  child: Row(
                    children: [
                      CommonSvgText(
                        text: '2024년 9월',
                        fontSize: 20,
                        svgWidth: 10,
                        svgName: 'dir-down-bold',
                        svgDirection: SvgDirection.right,
                      ),
                      const Spacer(),
                      CommonTag(
                        text: '체중',
                        fontSize: 14,
                        onTap: onCategory,
                      )
                    ],
                  ),
                ),
                CommonCalendar(
                  rowHeight: 72,
                  selectedDateTime: selectedDateTime,
                  calendarFormat: CalendarFormat.month,
                  shouldFillViewport: false,
                  todayBuilder: todayBuilder,
                  markerBuilder: markerBuilder,
                  onPageChanged: onPageChanged,
                  onDaySelected: onDaySelected,
                  onFormatChanged: (_) {},
                ),
              ],
            ),
            const Spacer(),
            // TodayButton()
          ],
        ),
      ),
    );
  }
}

class TodayButton extends StatelessWidget {
  const TodayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: CommonText(text: '오늘로 이동', fontSize: 14),
    );
  }
}
