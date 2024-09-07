import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/GoalDateTimeBottomSheet.dart';
import 'package:my_weight_app/widget/bottomSheet/GoalWeightBottomSheet.dart';
import 'package:provider/provider.dart';

class GoalWeightPage extends StatefulWidget {
  const GoalWeightPage({super.key});

  @override
  State<GoalWeightPage> createState() => _GoalWeightPageState();
}

class _GoalWeightPageState extends State<GoalWeightPage> {
  UserBox user = userRepository.user;
  DateTime? goalDateTime;
  double? goalWeight;

  @override
  void initState() {
    GoalInfoClass goalInfo = GoalInfoClass(
      goalDateTime: user.goalInfo['goalDateTime'],
      goalWeight: user.goalInfo['goalWeight'],
    );

    goalDateTime = goalInfo.goalDateTime;
    goalWeight = goalInfo.goalWeight;

    super.initState();
  }

  onShowGoalDateTime() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => GoalDateTimeBottomSheet(
        goalDateTime: goalDateTime,
        onDaySelected: (DateTime dateTime) {
          setState(() => goalDateTime = dateTime);
          pop(context);
        },
      ),
    );
  }

  onShowGoalWeight() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => GoalWeightBottomSheet(
        initWeight: goalWeight,
        onCompleted: (weight) {
          setState(() => goalWeight = weight);
          pop(context);
        },
      ),
    );
  }

  onCompleted() async {
    user.goalInfo['goalDateTime'] = goalDateTime;
    user.goalInfo['goalWeight'] = goalWeight;

    await user.save();
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String locale = context.locale.toString();
    String weightUnit = user.weightUnit;
    bool isCompleted = goalDateTime != null || goalWeight != null;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '목표 설정'),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonContainer(
                onTap: onShowGoalDateTime,
                child: Row(
                  children: [
                    CommonText(
                      text: goalDateTime != null
                          ? '${ymdeFullFormatter(
                              locale: locale,
                              dateTime: goalDateTime!,
                            )}까지'
                          : '목표 날짜를 선택해주세요',
                      fontSize: defaultFontSize - 1,
                      color: goalDateTime != null ? Colors.black : grey.s400,
                    ),
                    const Spacer(),
                    svgAsset(
                      isLight: isLight,
                      name: 'calendar',
                      width: 20,
                      color: goalDateTime != null ? Colors.black : grey.s400,
                    )
                  ],
                ),
              ),
              CommonSpace(height: 10),
              CommonContainer(
                onTap: onShowGoalWeight,
                child: Row(
                  children: [
                    CommonText(
                      text: goalWeight != null
                          ? '$goalWeight$weightUnit'
                          : '목표 체중을 입력해주세요',
                      color: goalWeight != null ? Colors.black : grey.s400,
                    ),
                    const Spacer(),
                    svgAsset(
                      isLight: isLight,
                      name: 'dir-right-bold',
                      width: 7,
                      color: goalWeight != null ? Colors.black : grey.s400,
                    )
                  ],
                ),
              ),
              const Spacer(),
              CommonButton(
                outerPadding: const EdgeInsets.only(top: 10),
                text: '저장',
                textColor: isCompleted ? Colors.white : grey.s400,
                buttonColor: isCompleted ? darkButtonColor : Colors.white,
                verticalPadding: 12.5,
                borderRadius: 7,
                onTap: onCompleted,
              )
            ],
          ),
        ),
      ),
    );
  }
}
