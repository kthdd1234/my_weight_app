import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/page/DiaryPage.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/DiaryEditBottomSheet.dart';
import 'package:my_weight_app/widget/view/ImageView.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class DiaryContainer extends StatefulWidget {
  DiaryContainer({
    super.key,
    this.diaryInfo,
    required this.isPremium,
    required this.onCompleted,
    required this.onRemove,
    required this.onView,
  });

  DiaryInfoClass? diaryInfo;
  bool isPremium;
  Function(DiaryInfoClass) onCompleted;
  Function() onView, onRemove;

  @override
  State<DiaryContainer> createState() => _DiaryContainerState();
}

class _DiaryContainerState extends State<DiaryContainer> {
  onNav() {
    navigator(
      context: context,
      page: DiaryPage(
        isPremium: widget.isPremium,
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
    bool isView = userRepository.user.categoryOpenIdList.contains(eDiaryId);

    String text = widget.diaryInfo?.text ?? '';
    List<Uint8List> memoImageList = widget.diaryInfo?.memoImageList ?? [];
    TextAlign textAlign = widget.diaryInfo?.textAlign ?? TextAlign.left;

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
        children: [
          TitleView(title: '메모', isView: isView, onView: widget.onView),
          isView
              ? widget.diaryInfo != null
                  ? InkWell(
                      onTap: onDiary,
                      child: Column(
                        crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
                        children: [
                          memoImageList.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    bottom: text != '' ? 10 : 0,
                                  ),
                                  child: ImageView(
                                    uint8ListList: memoImageList,
                                    onImage: (_) => onDiary(),
                                  ),
                                )
                              : const CommonNull(),
                          text != ''
                              ? CommonText(
                                  text: text,
                                  textAlign: textAlign,
                                  fontSize: defaultFontSize - 2,
                                  isNotTr: true,
                                )
                              : const CommonNull(),
                        ],
                      ),
                    )
                  : CommonContainer(
                      onTap: onNav,
                      height: 50,
                      isAddShadow: true,
                      child: CommonText(text: '메모 작성', color: grey.original),
                    )
              : const CommonNull()
        ],
      ),
    );
  }
}
