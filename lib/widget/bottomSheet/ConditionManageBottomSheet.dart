// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonDivider.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/model/condition_box/condition_box.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/ConditionSettingBottomSheet.dart';
import 'package:my_weight_app/widget/container/ConditionContainer.dart';
import 'package:my_weight_app/widget/popup/AlertPopup.dart';

class ConditionManageBottomSheet extends StatefulWidget {
  const ConditionManageBottomSheet({super.key});

  @override
  State<ConditionManageBottomSheet> createState() =>
      _ConditionManageBottomSheetState();
}

class _ConditionManageBottomSheetState
    extends State<ConditionManageBottomSheet> {
  UserBox user = userRepository.user;

  onItem(String? id) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ConditionSettingBottomSheet(id: id),
    );
  }

  onRemove(String id) {
    List<ConditionBox> conditionList = conditionRepository.conditionList;

    if (conditionList.length == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '최소 1개 이상의 컨디션이 존재해야 해요',
          buttonText: '확인',
          height: 170,
          onTap: () => pop(context),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '정말로 삭제할까요?',
          buttonText: '삭제',
          isCancel: true,
          height: 170,
          onTap: () async {
            await conditionRepository.conditionBox.delete(id);
            user.conditionOrderIdList.remove(id);

            await user.save();
            pop(context);
          },
        ),
      );
    }
  }

  onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    String orderId = user.conditionOrderIdList.removeAt(oldIndex);
    user.conditionOrderIdList.insert(newIndex, orderId);

    await userRepository.user.save();
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (context, values, child) {
          List<ConditionBox> conditionList = getConditionList();

          return CommonModalSheet(
            title: '컨디션 관리',
            isClose: true,
            height: 520,
            child: Column(
              children: [
                Expanded(
                  child: ReorderableListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: conditionList.length,
                    itemBuilder: (_, index) {
                      ConditionBox conditionInfo = conditionList[index];

                      return ConditionItem(
                        key: Key(conditionInfo.id),
                        conditionInfo: conditionInfo,
                        onRemove: onRemove,
                        onEdit: (id) => onItem(id),
                      );
                    },
                    onReorder: onReorder,
                  ),
                ),
                CommonButton(
                  outerPadding: const EdgeInsets.only(top: 15),
                  text: '+ 컨디션 추가',
                  textColor: Colors.black,
                  buttonColor: Colors.white,
                  verticalPadding: 10,
                  borderRadius: 7,
                  onTap: () => onItem(null),
                )
              ],
            ),
          );
        });
  }
}

class ConditionItem extends StatelessWidget {
  ConditionItem({
    super.key,
    required this.conditionInfo,
    required this.onRemove,
    required this.onEdit,
  });

  ConditionBox conditionInfo;
  Function(String) onRemove, onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonSpace(height: 10),
        Row(
          children: [
            InkWell(
              onTap: () => onRemove(conditionInfo.id),
              child: Icon(Icons.remove_circle, size: 18, color: red.original),
            ),
            CommonSpace(width: 15),
            ConditionInfo(
              info: conditionInfo,
              isOutline: true,
              isFilled: conditionRepository.conditionList.any(
                (info) => info.id == conditionInfo.id,
              ),
              onItem: (item) => onEdit(item.id),
            ),
            const Spacer(),
            InkWell(
              onTap: () => onEdit(conditionInfo.id),
              child: Icon(Icons.edit_rounded, size: 20, color: grey.s400),
            ),
            CommonSpace(width: 10),
            Icon(Icons.reorder_rounded, size: 20, color: grey.s400),
          ],
        ),
        CommonSpace(height: 10),
        CommonDivider(color: grey.s300)
      ],
    );
  }
}
