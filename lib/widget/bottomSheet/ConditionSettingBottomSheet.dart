import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonTextFormField.dart';
import 'package:my_weight_app/util/constant.dart';

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

  onCompleted() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '컨디션 ${widget.id == null ? ' 추가' : '수정'}',
        height: 185,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonTextFormField(controller: controller),
              CommonSpace(height: 15),
              CommonButton(
                text: '완료',
                textColor: Colors.white,
                buttonColor: darkButtonColor,
                verticalPadding: 10,
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
