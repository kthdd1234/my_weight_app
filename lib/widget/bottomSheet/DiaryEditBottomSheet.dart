import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonModalButton.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/util/final.dart';

class DiaryEditBottomSheet extends StatelessWidget {
  DiaryEditBottomSheet({
    super.key,
    required this.onEdit,
    required this.onRemove,
  });

  Function() onEdit, onRemove;

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: '메모',
      height: 195,
      child: Row(
        children: [
          CommonModalButton(
            svgName: 'pencil',
            actionText: '수정',
            onTap: onEdit,
          ),
          CommonSpace(width: 10),
          CommonModalButton(
            color: red.original,
            svgName: 'trash',
            actionText: '삭제',
            onTap: onRemove,
          ),
        ],
      ),
    );
  }
}
