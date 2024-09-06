import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonSvg.dart';
import 'package:my_weight_app/common/CommonTag.dart';
import 'package:my_weight_app/page/GoalWeightPage.dart';
import 'package:my_weight_app/page/GraphPage.dart';
import 'package:my_weight_app/page/SettingPage.dart';
import 'package:my_weight_app/util/func.dart';

class HeaderBar extends StatefulWidget {
  const HeaderBar({super.key});

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  onGoal() {
    navigator(context: context, page: const GoalWeightPage());
  }

  onGraph() {
    navigator(context: context, page: const GraphPage());
  }

  onSetting() {
    navigator(context: context, page: const SettingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
          child: CommonTag(
            text: '⛳️ 2024년 10월 3일까지 70kg 달성!',
            fontSize: 16,
            onTap: onGoal,
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
          onTap: onSetting,
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        ),
      ],
    );
  }
}
