import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';

class CommonSegmented extends StatelessWidget {
  CommonSegmented({
    super.key,
    required this.selectedSegment,
    required this.children,
    required this.onSegmentedChanged,
  });

  SegmentedTypes selectedSegment;
  Map<SegmentedTypes, Widget> children;

  Function(SegmentedTypes? type) onSegmentedChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSlidingSegmentedControl(
            backgroundColor: Colors.white,
            thumbColor: const Color(0xffF6F6F6),
            groupValue: selectedSegment,
            children: children,
            onValueChanged: onSegmentedChanged,
          ),
        ),
      ],
    );
  }
}

onSegmentedWidget({
  required String title,
  required SegmentedTypes type,
  required SegmentedTypes selected,
  Map<String, String>? nameArgs,
}) {
  return CommonText(
    text: title,
    fontSize: defaultFontSize - 3,
    nameArgs: nameArgs,
    color: selected == type ? Colors.black : grey.original,
  );
}
