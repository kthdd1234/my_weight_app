// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonTextFormField.dart';
import 'package:my_weight_app/model/condition_box/condition_box.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/view/ColorView.dart';

class ConditionSettingBottomSheet extends StatefulWidget {
  ConditionSettingBottomSheet({super.key, this.id});

  String? id;

  @override
  State<ConditionSettingBottomSheet> createState() =>
      _ConditionSettingBottomSheetState();
}

class _ConditionSettingBottomSheetState
    extends State<ConditionSettingBottomSheet> {
  TextEditingController controller = TextEditingController();
  String selectedColorName = '남색';

  @override
  void initState() {
    if (widget.id != null) {
      ConditionBox? conditionBox =
          conditionRepository.conditionBox.get(widget.id);

      if (conditionBox != null) {
        controller.text = conditionBox.text;
        selectedColorName = conditionBox.colorName;
      }
    }

    super.initState();
  }

  onColor(String colorName) {
    setState(() => selectedColorName = colorName);
  }

  onCompleted() async {
    if (widget.id == null) {
      String newId = uuid();

      conditionRepository.updateCondition(
        key: newId,
        condition: ConditionBox(
          id: newId,
          colorName: selectedColorName,
          text: controller.text,
        ),
      );
    } else {
      ConditionBox? conditionBox =
          conditionRepository.conditionBox.get(widget.id);

      if (conditionBox != null) {
        conditionBox.text = controller.text;
        conditionBox.colorName = selectedColorName;
      }

      await conditionBox?.save();
    }

    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = controller.text != '';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '컨디션 ${widget.id == null ? ' 추가' : '수정'}',
        height: 255,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonContainer(
                child: ColorView(
                  selectedColorName: selectedColorName,
                  onColor: onColor,
                ),
              ),
              CommonSpace(height: 10),
              CommonTextFormField(
                controller: controller,
                hintText: '컨디션 이름을 입력해주세요.'.tr(),
                onChanged: (_) => setState(() {}),
                maxLength: 20,
              ),
              CommonSpace(height: 15),
              CommonButton(
                text: '완료',
                textColor: isCompleted ? Colors.white : grey.s400,
                buttonColor: isCompleted ? darkButtonColor : Colors.white,
                verticalPadding: 10,
                borderRadius: 7,
                onTap: isCompleted ? onCompleted : () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
