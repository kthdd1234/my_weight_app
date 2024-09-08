import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:my_weight_app/common/CommonSvg.dart';
import 'package:my_weight_app/common/CommonTag.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/page/GoalWeightPage.dart';
import 'package:my_weight_app/page/GraphPage.dart';
import 'package:my_weight_app/page/MorePage.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/final.dart';
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
    navigator(context: context, page: const MorePage());
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        UserBox? user = userRepository.user;
        GoalInfoClass goalInfo = GoalInfoClass(
          goalDateTime: user.goalInfo['goalDateTime'],
          goalWeight: user.goalInfo['goalWeight'],
        );
        bool isGoalDateTime = goalInfo.goalDateTime != null;
        bool isGoalWeight = goalInfo.goalWeight != null;
        bool isGoal = isGoalDateTime || isGoalWeight;

        String weightUnit = user.weightUnit;

        String goalDateTimeText = isGoalDateTime
            ? ymdFullFormatter(locale: locale, dateTime: goalInfo.goalDateTime!)
            : '-년 -월 -일';
        String goalWeightText =
            '${isGoalWeight ? goalInfo.goalWeight : '-'}$weightUnit';

        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: CommonTag(
                text: isGoal
                    ? '⛳️ $goalDateTimeText까지 $goalWeightText 달성!'
                    : '⛳️ 목표 체중과 날짜를 설정해주세요',
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
      },
    );
  }
}
