import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonSvg.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/common/CommonTextFormField.dart';
import 'package:my_weight_app/page/ImageSlidePage.dart';
import 'package:my_weight_app/page/PremiumPage.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/ImageActionBottomSheet.dart';
import 'package:my_weight_app/widget/bottomSheet/ImageSelectionModalSheet.dart';
import 'package:my_weight_app/widget/popup/AlertPopup.dart';
import 'package:my_weight_app/widget/view/ImageView.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({
    super.key,
    this.diaryInfo,
    required this.isPremium,
    required this.onCompleted,
  });

  DiaryInfoClass? diaryInfo;
  bool isPremium;
  Function(DiaryInfoClass) onCompleted;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  TextEditingController controller = TextEditingController();
  TextAlign textAlign = TextAlign.left;
  List<Uint8List> memoImageList = [];

  @override
  void initState() {
    if (widget.diaryInfo != null) {
      controller.text = widget.diaryInfo!.text ?? '';
      textAlign = widget.diaryInfo!.textAlign;
      memoImageList = widget.diaryInfo!.memoImageList ?? [];
    }

    super.initState();
  }

  onPremiumImagePopup() {
    return showDialog(
      context: context,
      builder: (context) => AlertPopup(
        desc: '프리미엄 구매 시\n사진을 6장까지 추가할 있어요\n(미구매 시, 한 장만 추가 가능해요)',
        buttonText: '프리미엄 구매 페이지로 이동',
        height: 216,
        onTap: () => navigator(context: context, page: const PremiumPage()),
      ),
    );
  }

  onMaximumImagePopup() {
    return showDialog(
      context: context,
      builder: (context) => AlertPopup(
        desc: '사진은 최대 6장까지 추가할 수 있어요.',
        buttonText: '확인',
        height: 170,
        onTap: () => pop(context),
      ),
    );
  }

  onCamera(Uint8List uint8List) {
    pop(context);

    int listLength = memoImageList.length + 1;

    if (widget.isPremium == false && listLength > 1) {
      onPremiumImagePopup();
    } else if (listLength > 6) {
      onMaximumImagePopup();
    } else {
      setState(() => memoImageList = [...memoImageList, uint8List]);
    }
  }

  onGallery(List<Uint8List> uint8ListArray) {
    pop(context);

    int listLength = memoImageList.length + uint8ListArray.length;

    if (widget.isPremium == false && listLength > 1) {
      onPremiumImagePopup();
    } else if (listLength > 6) {
      onMaximumImagePopup();
    } else {
      setState(() => memoImageList = [...memoImageList, ...uint8ListArray]);
    }
  }

  onSlide(Uint8List uint8List) {
    navigator(
      context: context,
      page: ImageSlidePage(
        curIndex: memoImageList.indexOf(uint8List),
        uint8ListList: memoImageList,
      ),
    );
  }

  onRemove(Uint8List uint8List) {
    setState(() {
      memoImageList.removeWhere((uint8List_) => uint8List_ == uint8List);
    });

    pop(context);
  }

  onAddImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImageActionBottomSheet(
        onCamera: onCamera,
        onGallery: onGallery,
      ),
    );
  }

  onSelectionImage(Uint8List uint8List) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        uint8List: uint8List,
        onSlide: () => onSlide(uint8List),
        onRemove: () => onRemove(uint8List),
      ),
    );
  }

  onAlign() {
    setState(() => textAlign = nextTextAlign[textAlign]!);
  }

  onTime() {
    String locale = context.locale.toString();
    DateTime now = DateTime.now();
    String time = hmFormatter(locale: locale, dateTime: now);

    setState(() => controller.text = '${controller.text}$time');
  }

  onCompleted() {
    widget.onCompleted(
      DiaryInfoClass(
        text: controller.text,
        textAlign: textAlign,
        memoImageList: memoImageList.isNotEmpty ? memoImageList : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = controller.text != '' || memoImageList.isNotEmpty;

    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.all(0),
        appBarInfo: AppBarInfoClass(title: '메모'),
        body: Column(
          crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      ImageView(
                        uint8ListList: memoImageList,
                        onImage: onSelectionImage,
                      ),
                      CommonSpace(height: memoImageList.isNotEmpty ? 5 : 0),
                      CommonTextFormField(
                        hintText: '식단, 운동, 일기 등 자유롭게 메모해보세요 :D',
                        isContainer: false,
                        controller: controller,
                        textAlign: textAlign,
                        onChanged: (p0) => setState(() {}),
                      ),
                      CommonSpace(height: 50),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                CommonSvg(
                  width: 20,
                  name: 'image',
                  onTap: onAddImage,
                  padding: const EdgeInsets.fromLTRB(15, 10, 8, 10),
                ),
                CommonSvg(
                  width: 24,
                  name: 'align-${textAlignName[textAlign]}',
                  onTap: onAlign,
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                ),
                CommonSvg(
                  width: 21,
                  name: 'clock',
                  onTap: onTime,
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                ),
                const Spacer(),
                InkWell(
                  onTap: isCompleted ? onCompleted : () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                    child: CommonText(
                      text: '완료',
                      color: isCompleted ? Colors.black : grey.s400,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
