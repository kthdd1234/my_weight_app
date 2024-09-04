import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class ConditionContainer extends StatelessWidget {
  ConditionContainer({super.key, required this.onViewCondition});

  Function(bool) onViewCondition;

  @override
  Widget build(BuildContext context) {
    onItem(String id) {
      //
    }

    onRemove(String id) {
      //
    }

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '컨디션', isView: true, onView: onViewCondition),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 7,
            runSpacing: 7,
            children: initConditionTagList
                .map((tag) => ConditionTag(
                      id: tag.id,
                      text: tag.text,
                      colorName: tag.colorName,
                      isOutline: true,
                      isFilled: false,
                      isEditMode: false,
                      onRemove: onRemove,
                      onItem: onItem,
                    ))
                .toList(),
          ),
          CommonSpace(height: 10),
          CommonContainer(
            height: 50,
            isAddShadow: true,
            child: CommonText(text: '컨디션 관리', color: grey.s400),
          )
        ],
      ),
    );
  }
}

class ConditionTag extends StatelessWidget {
  ConditionTag({
    super.key,
    required this.id,
    required this.text,
    required this.colorName,
    required this.isFilled,
    required this.isEditMode,
    required this.onItem,
    required this.onRemove,
    this.isOutline,
  });

  String id, text, colorName;
  bool isFilled, isEditMode;
  bool? isOutline;
  Function(String id) onItem, onRemove;

  @override
  Widget build(BuildContext context) {
    ColorClass color = getColorClass(colorName);

    return Row(
      mainAxisSize: isEditMode ? MainAxisSize.min : MainAxisSize.min,
      children: [
        isEditMode
            ? Padding(
                padding: const EdgeInsets.only(right: 2, left: 7),
                child: InkWell(
                  child: Icon(
                    Icons.remove_circle,
                    color: red.original,
                    size: 18,
                  ),
                  onTap: () => onRemove(id),
                ),
              )
            : const CommonNull(),
        InkWell(
          onTap: () => onItem(id),
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
              text: text,
              fontSize: defaultFontSize - 2,
              color: isFilled ? color.s300 : grey.s400,
            ),
          ),
        )
      ],
    );
  }
}
