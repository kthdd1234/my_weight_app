import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/page/DiaryPage.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/DiaryEditBottomSheet.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class DiaryContainer extends StatefulWidget {
  DiaryContainer({
    super.key,
    this.diaryInfo,
    required this.onCompleted,
    required this.onRemove,
    required this.onView,
  });

  DiaryInfoClass? diaryInfo;
  Function(DiaryInfoClass) onCompleted;
  Function(bool isView) onView;
  Function() onRemove;

  @override
  State<DiaryContainer> createState() => _DiaryContainerState();
}

class _DiaryContainerState extends State<DiaryContainer> {
  onNav() {
    navigator(
      context: context,
      page: DiaryPage(
        diaryInfo: widget.diaryInfo,
        onCompleted: widget.onCompleted,
      ),
    );
  }

  onDiary() {
    showModalBottomSheet(
      context: context,
      builder: (context) => DiaryEditBottomSheet(
        onEdit: () {
          pop(context);
          onNav();
        },
        onRemove: widget.onRemove,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: crossAxisAlignmentInfo[
            widget.diaryInfo?.textAlign ?? TextAlign.left]!,
        children: [
          TitleView(title: '일기', isView: true, onView: widget.onView),
          widget.diaryInfo != null
              ? InkWell(
                  onTap: onDiary,
                  child: CommonText(
                    text: widget.diaryInfo!.text,
                    textAlign: widget.diaryInfo!.textAlign,
                    fontSize: defaultFontSize - 2,
                  ),
                )
              : CommonContainer(
                  onTap: onNav,
                  height: 50,
                  isAddShadow: true,
                  child: CommonText(text: '일기 작성', color: grey.s400),
                )
        ],
      ),
    );
  }
}
