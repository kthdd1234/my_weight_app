import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/common/CommonSvg.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/GoalWeightDateTimeBottomSheet.dart';
import 'package:my_weight_app/widget/textFormField/WeightTextFormField.dart';
import 'package:provider/provider.dart';

class GoalWeightPage extends StatefulWidget {
  const GoalWeightPage({super.key});

  @override
  State<GoalWeightPage> createState() => _GoalWeightPageState();
}

class _GoalWeightPageState extends State<GoalWeightPage> {
  TextEditingController controller = TextEditingController();

  DateTime? goalDateTime;
  double? goalWeight;

  onDateTime() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => GoalWeightDateTimeBottomSheet(
        goalDateTime: goalDateTime,
        onDaySelected: (DateTime dateTime) {
          setState(() => goalDateTime = dateTime);
          pop(context);
        },
      ),
    );
  }

  onFocusOut() {
    FocusScope.of(context).unfocus();
  }

  onCompleted() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String locale = context.locale.toString();

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '목표 설정'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonContainer(
              onTap: onDateTime,
              outerPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    name: 'dir-right',
                    width: 7,
                    color: grey.original,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: WeightTextFormField(
                isSuffix: true,
                hintText: '목표 체중을 입력해주세요',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                autofocus: false,
                controller: controller,
                cursorColor: themeColor,
                textAlign: TextAlign.left,
                onChanged: (p0) => setState(() {}),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                CommonSvg(
                  name: 'check',
                  onTap: onCompleted,
                  padding: const EdgeInsets.all(5),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
