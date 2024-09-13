import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonTextFormField.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';

class GoalWeightBottomSheet extends StatefulWidget {
  GoalWeightBottomSheet({
    super.key,
    this.initWeight,
    required this.onCompleted,
  });

  double? initWeight;
  Function(double) onCompleted;

  @override
  State<GoalWeightBottomSheet> createState() => _GoalWeightBottomSheetState();
}

class _GoalWeightBottomSheetState extends State<GoalWeightBottomSheet> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initWeight != null) {
      controller.text = widget.initWeight!.toString();
    }

    super.initState();
  }

  onChanged(_) {
    bool isInit = isDoubleTryParse(text: controller.text) == false ||
        isErorr(
          unit: userRepository.user.weightUnit,
          value: stringToDouble(controller.text),
        );

    if (isInit || controller.text.length > 5) {
      controller.text = '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = isDoubleTryParse(text: controller.text);

    commonCompleted() {
      if (isCompleted) {
        widget.onCompleted(stringToDouble(controller.text));
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '목표 몸무게',
        height: 180,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonTextFormField(
                isSuffix: true,
                autofocus: true,
                cursorColor: purple.s400,
                textColor: purple.original,
                controller: controller,
                hintText: '목표 몸무게를 입력해주세요'.tr(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onEditingComplete: commonCompleted,
                onChanged: onChanged,
              ),
              CommonButton(
                outerPadding: const EdgeInsets.only(top: 10),
                text: '완료',
                textColor: isCompleted ? Colors.white : grey.s400,
                buttonColor: isCompleted ? purple.s300 : Colors.white,
                verticalPadding: 10,
                borderRadius: 7,
                onTap: commonCompleted,
              )
            ],
          ),
        ),
      ),
    );
  }
}
