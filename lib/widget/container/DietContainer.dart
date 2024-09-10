import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/etc/DietExercisePage.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/DietExerciseBottomSheet.dart';
import 'package:my_weight_app/widget/view/DietExerciseView.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class DietContainer extends StatefulWidget {
  DietContainer({super.key, required this.onView});

  Function() onView;

  @override
  State<DietContainer> createState() => _DietContainerState();
}

class _DietContainerState extends State<DietContainer> {
  onEdit() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const DietExerciseBottomSheet(),
    );
  }

  onAdd() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const DietExerciseBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isView = userRepository.user.categoryOpenIdList.contains(eDietId);

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '식단', isView: isView, onView: widget.onView),
          isView
              ? Column(
                  children: [
                    DietExerciseView(onTap: onEdit),
                    DietExerciseView(onTap: onEdit),
                    DietExerciseView(onTap: onEdit),
                    CommonContainer(
                      outerPadding: const EdgeInsets.only(top: 5),
                      onTap: onAdd,
                      height: 50,
                      isAddShadow: true,
                      child: CommonText(text: '+ 식단 추가', color: grey.original),
                    )
                  ],
                )
              : const CommonNull(),
        ],
      ),
    );
  }
}
