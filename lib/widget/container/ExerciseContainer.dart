import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class ExerciseContainer extends StatelessWidget {
  ExerciseContainer({super.key, required this.onView});

  Function() onView;

  @override
  Widget build(BuildContext context) {
    bool isView = userRepository.user.categoryOpenIdList.contains(eExerciseId);

    return CommonContainer(
      isAddShadow: true,
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '운동', isView: isView, onView: onView),
        ],
      ),
    );
  }
}
