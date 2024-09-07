import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonImage.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class DietContainer extends StatelessWidget {
  DietContainer({super.key, required this.onView});

  Function() onView;

  onItem(_) {
    //
  }

  onConditionBottomSheet() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isView = userRepository.user.categoryOpenIdList.contains(eDietId);

    return CommonContainer(
      isAddShadow: true,
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '식단', isView: isView, onView: onView),
          isView
              ? Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonImage(
                          text: '☀️',
                          uint8List: null,
                          height: 100,
                          onTap: onItem,
                        ),
                        CommonSpace(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(text: '아침'),
                            CommonText(
                              text: '오전 12:15',
                              fontSize: defaultFontSize - 4,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              : const CommonNull(),
          CommonSpace(height: 15),
          CommonContainer(
            onTap: onConditionBottomSheet,
            height: 50,
            isAddShadow: true,
            child: CommonText(text: '+ 식단 추가', color: grey.s400),
          )
        ],
      ),
    );
  }
}
