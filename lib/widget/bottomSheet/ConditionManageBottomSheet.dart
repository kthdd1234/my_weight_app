import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonCircle.dart';
import 'package:my_weight_app/common/CommonDivider.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/ConditionSettingBottomSheet.dart';

class ConditionManageBottomSheet extends StatefulWidget {
  const ConditionManageBottomSheet({super.key});

  @override
  State<ConditionManageBottomSheet> createState() =>
      _ConditionManageBottomSheetState();
}

class _ConditionManageBottomSheetState
    extends State<ConditionManageBottomSheet> {
  onAdd() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ConditionSettingBottomSheet(),
    );
  }

  onEdit(String id) {
    //
  }

  onRemove(String id) {
    //
  }

  onReorder(int oldIndex, int newIndex) async {
    //
  }

  @override
  Widget build(BuildContext context) {
    final testList = [
      ConditionItem(
        id: '스트레스',
        name: '스트레스',
        colorName: '남색',
        onEdit: onEdit,
        onRemove: onRemove,
      ),
      ConditionItem(
        id: '스트레스2',
        name: '스트레스',
        colorName: '남색',
        onEdit: onEdit,
        onRemove: onRemove,
      ),
      ConditionItem(
        id: '스트레스3',
        name: '스트레스',
        colorName: '남색',
        onEdit: onEdit,
        onRemove: onRemove,
      ),
    ];

    return CommonModalSheet(
      title: '컨디션 관리',
      isClose: true,
      height: 520,
      child: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: testList.length,
              itemBuilder: (_, index) {
                final item = testList[index];

                return ConditionItem(
                  key: Key(item.id),
                  id: item.id,
                  name: item.name,
                  colorName: getColorClass(item.colorName).colorName,
                  onRemove: onRemove,
                  onEdit: onEdit,
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
            onTap: onAdd,
          )
        ],
      ),
    );
  }
}

class ConditionItem extends StatelessWidget {
  ConditionItem({
    super.key,
    required this.id,
    required this.name,
    required this.colorName,
    required this.onRemove,
    required this.onEdit,
  });

  String id, name, colorName;
  Function(String) onRemove, onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonSpace(height: 10),
        Row(
          children: [
            InkWell(
              onTap: () => onRemove(id),
              child: Icon(Icons.remove_circle, size: 18, color: red.original),
            ),
            CommonSpace(width: 15),
            CommonCircle(color: getColorClass(colorName).s200, size: 10),
            CommonSpace(width: 5),
            CommonText(text: name),
            const Spacer(),
            InkWell(
              onTap: () => onEdit(id),
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
