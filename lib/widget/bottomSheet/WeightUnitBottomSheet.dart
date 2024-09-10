// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonModalButton.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';

class WeightUnitBottomSheet extends StatefulWidget {
  const WeightUnitBottomSheet({super.key});

  @override
  State<WeightUnitBottomSheet> createState() => _WeightUnitBottomSheetState();
}

class _WeightUnitBottomSheetState extends State<WeightUnitBottomSheet> {
  UserBox user = userRepository.user;

  onUnit(String unit) async {
    user.weightUnit = unit;
    await user.save();

    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String weightUnit = user.weightUnit;

    return CommonModalSheet(
      title: '몸무게 단위',
      height: 190,
      child: Row(
        children: [
          CommonModalButton(
            isNotTr: true,
            isSelection: weightUnit == 'kg',
            fontSize: defaultFontSize + 5,
            actionText: 'kg',
            onTap: () => onUnit('kg'),
          ),
          CommonSpace(width: 5),
          CommonModalButton(
            isNotTr: true,
            isSelection: weightUnit == 'lb',
            fontSize: defaultFontSize + 5,
            actionText: 'lb',
            onTap: () => onUnit('lb'),
          )
        ],
      ),
    );
  }
}
