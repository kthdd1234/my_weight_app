import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/widget/bottomSheet/WeightBottomSheet.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class WeightContainer extends StatefulWidget {
  WeightContainer({
    super.key,
    this.morningWeight,
    this.nightWeight,
    required this.onCompleted,
    required this.onViewWeight,
    required this.onRemoveWeight,
  });

  double? morningWeight, nightWeight;
  Function(String id, double weight) onCompleted;
  Function() onViewWeight;
  Function(String id) onRemoveWeight;

  @override
  State<WeightContainer> createState() => _WeightContainerState();
}

class _WeightContainerState extends State<WeightContainer> {
  onWeightBottomSheet({
    required String id,
    required String title,
    double? value,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => WeightBottomSheet(
        id: id,
        title: title,
        initWeight: value,
        onCompleted: widget.onCompleted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isView = userRepository.user.categoryOpenIdList.contains(eWegihtId);
    List<WeightInfoClass> weightInfoList = [
      WeightInfoClass(id: 'morning', name: '아침', value: widget.morningWeight),
      WeightInfoClass(id: 'night', name: '저녁', value: widget.nightWeight),
    ];

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '체중', isView: isView, onView: widget.onViewWeight),
          isView
              ? Column(
                  children: weightInfoList.map(
                    (info) {
                      bool isValue = info.value != null;
                      Color color = isValue
                          ? info.id == 'morning'
                              ? blue.original
                              : red.s400
                          : grey.s400;
                      double bottomPadding = info.id == 'morning' ? 10 : 0;

                      return CommonContainer(
                        isAddShadow: true,
                        onTap: () => onWeightBottomSheet(
                          id: info.id,
                          title: info.name,
                          value: info.value,
                        ),
                        outerPadding: EdgeInsets.only(bottom: bottomPadding),
                        child: info.value != null
                            ? Row(
                                children: [
                                  CommonText(
                                      text: '${info.value}kg', color: color),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () => widget.onRemoveWeight(info.id),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(3, 3, 0, 3),
                                      child: Icon(
                                        Icons.highlight_remove_rounded,
                                        color: grey.s400,
                                        size: defaultFontSize,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : CommonText(text: '${info.name} 기록', color: color),
                      );
                    },
                  ).toList(),
                )
              : const CommonNull(),
        ],
      ),
    );
  }
}
