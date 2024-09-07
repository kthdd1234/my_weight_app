// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/model/condition_box/condition_box.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  onStart() async {
    initConditionInfoList.forEach(
      (info) => conditionRepository.updateCondition(
        key: info.id,
        condition: ConditionBox(
          id: info.id,
          colorName: info.colorName,
          text: info.text.tr(),
        ),
      ),
    );

    userRepository.updateUser(
      UserBox(
        id: uuid(),
        createDateTime: DateTime.now(),
        fontFamily: initFontFamily,
        theme: tSystem,
        fontSize: defaultFontSize,
        background: 1,
        weightUnit: 'kg',
        goalInfo: {'goalDateTime': null, 'goalWeight': null},
        categoryOpenIdList: [
          eWegihtId,
          eImageId,
          eDietId,
          eExerciseId,
          eConditionId,
          eDiaryId
        ],
        conditionOrderIdList:
            initConditionInfoList.map((info) => info.id).toList(),
      ),
    );

    await Navigator.pushNamedAndRemoveUntil(
      context,
      'home-page',
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonBackground(
      path: '1',
      child: CommonScaffold(
        initFontSize: defaultFontSize,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        body: Column(
          children: [
            const Spacer(),
            CommonText(text: '반가워요! 오늘의 체중 앱과 함께'),
            CommonText(text: '꾸준히 체중을 관리해보아요 :D'),
            const Spacer(),
            CommonButton(
              text: '시작하기',
              textColor: isLight ? Colors.black : Colors.white,
              buttonColor: isLight ? Colors.white : darkButtonColor,
              verticalPadding: 15,
              borderRadius: 7,
              onTap: onStart,
            )
          ],
        ),
      ),
    );
  }
}
