import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/page/ImageSlidePage.dart';
import 'package:my_weight_app/page/PremiumPage.dart';
import 'package:my_weight_app/provider/PremiumProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/container/ConditionContainer.dart';
import 'package:my_weight_app/widget/container/DiaryContainer.dart';
import 'package:my_weight_app/widget/container/ImageContainer.dart';
import 'package:my_weight_app/widget/container/WeightContainer.dart';
import 'package:my_weight_app/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  double? morningWeight;
  double? nightWeight;

  List<Uint8List> imageList = [];

  onViewWeight(bool isView) {
    //
  }

  onViewImage(bool isView) {
    //
  }

  onViewCondition(bool isView) {
    //
  }

  onViewDiary(bool isView) {
    //
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

  onCamera(Uint8List uint8List, bool isPremium) {
    pop(context);

    int listLength = imageList.length + 1;

    if (isPremium == false && listLength > 1) {
      onPremiumImagePopup();
    } else if (listLength > 6) {
      onMaximumImagePopup();
    } else {
      setState(() => imageList = [...imageList, uint8List]);
    }
  }

  onGallery(List<Uint8List> uint8ListArray, bool isPremium) {
    pop(context);

    int listLength = imageList.length + uint8ListArray.length;

    if (isPremium == false && listLength > 1) {
      onPremiumImagePopup();
    } else if (listLength > 6) {
      onMaximumImagePopup();
    } else {
      setState(() => imageList = [...imageList, ...uint8ListArray]);
    }
  }

  onSlide(Uint8List uint8List) {
    navigator(
      context: context,
      page: ImageSlidePage(
        curIndex: imageList.indexOf(uint8List),
        uint8ListList: imageList,
      ),
    );
  }

  onRemoveWeight(String id) {
    setState(() {
      id == 'morning' ? morningWeight = null : nightWeight = null;
    });
  }

  onRemoveImage(Uint8List uint8List) {
    setState(() {
      imageList.removeWhere((uint8List_) => uint8List_ == uint8List);
    });

    pop(context);
  }

  onCompletedWeight(String id, double weight) {
    setState(() {
      id == 'morning' ? morningWeight = weight : nightWeight = weight;
    });

    pop(context);
  }

  onSaveRecord() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '9월 3일 수요일'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      WeightContainer(
                        morningWeight: morningWeight,
                        nightWeight: nightWeight,
                        onViewWeight: onViewWeight,
                        onCompleted: onCompletedWeight,
                        onRemoveWeight: onRemoveWeight,
                      ),
                      ImageContainer(
                        imageList: imageList,
                        onCamera: (uint8List) => onCamera(uint8List, isPremium),
                        onGallery: (uint8ListArray) =>
                            onGallery(uint8ListArray, isPremium),
                        onSlide: onSlide,
                        onRemove: onRemoveImage,
                        onView: onViewImage,
                      ),
                      ConditionContainer(onViewCondition: onViewCondition),
                      DiaryContainer(onView: onViewDiary),
                    ],
                  ),
                ),
              ),
              CommonButton(
                outerPadding: const EdgeInsets.only(top: 10),
                text: '저장',
                textColor: Colors.white,
                buttonColor: darkButtonColor,
                verticalPadding: 12.5,
                borderRadius: 7,
                onTap: onSaveRecord,
              )
            ],
          ),
        ),
      ),
    );
  }
}
