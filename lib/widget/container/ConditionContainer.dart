import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/model/condition_box/condition_box.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/ConditionManageBottomSheet.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class ConditionContainer extends StatelessWidget {
  ConditionContainer({
    super.key,
    required this.conditionList,
    required this.onViewCondition,
    required this.onSeletedCondition,
  });

  List<ConditionBox> conditionList;
  Function() onViewCondition;
  Function(ConditionBox) onSeletedCondition;

  @override
  Widget build(BuildContext context) {
    bool isView = userRepository.user.categoryOpenIdList.contains(eConditionId);

    onConditionBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => const ConditionManageBottomSheet(),
      );
    }

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '컨디션', isView: isView, onView: onViewCondition),
          isView
              ? Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 7,
                      runSpacing: 7,
                      children: getConditionList()
                          .map((conditionInfo) => ConditionInfo(
                                info: conditionInfo,
                                isOutline: true,
                                isFilled: conditionList.any(
                                  (info) => info.id == conditionInfo.id,
                                ),
                                onItem: onSeletedCondition,
                              ))
                          .toList(),
                    ),
                    CommonSpace(height: 15),
                    CommonContainer(
                      onTap: onConditionBottomSheet,
                      height: 50,
                      isAddShadow: true,
                      child: CommonText(text: '컨디션 관리', color: grey.original),
                    )
                  ],
                )
              : const CommonNull()
        ],
      ),
    );
  }
}

class ConditionInfo extends StatelessWidget {
  ConditionInfo({
    super.key,
    required this.info,
    required this.isFilled,
    required this.onItem,
    this.isOutline,
  });

  ConditionBox info;
  bool isFilled;
  bool? isOutline;
  Function(ConditionBox id) onItem;

  @override
  Widget build(BuildContext context) {
    ColorClass color = getColorClass(info.colorName);

    return InkWell(
      onTap: () => onItem(info),
      child: Container(
        padding: isOutline == true
            ? const EdgeInsets.symmetric(vertical: 5, horizontal: 15)
            : null,
        decoration: isOutline == true
            ? BoxDecoration(
                color: isFilled ? color.s50 : null,
                border: Border.all(
                  width: 0.5,
                  color: isFilled ? color.s50 : grey.s300,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              )
            : null,
        child: CommonText(
          text: info.text,
          fontSize: defaultFontSize - 2,
          color: isFilled ? color.s300 : grey.s400,
          isNotTr: true,
        ),
      ),
    );
  }
}
