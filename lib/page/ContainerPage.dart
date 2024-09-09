import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/model/condition_box/condition_box.dart';
import 'package:my_weight_app/model/reocrd_box/record_box.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/page/ImageSlidePage.dart';
import 'package:my_weight_app/page/PremiumPage.dart';
import 'package:my_weight_app/provider/PremiumProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/container/ConditionContainer.dart';
import 'package:my_weight_app/widget/container/DiaryContainer.dart';
import 'package:my_weight_app/widget/container/ImageContainer.dart';
import 'package:my_weight_app/widget/container/WeightContainer.dart';
import 'package:my_weight_app/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({super.key, required this.dateTime});

  DateTime dateTime;

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  UserBox user = userRepository.user;

  double? morningWeight, nightWeight;
  List<Uint8List> imageList = [];
  List<ConditionBox> conditionList = [];
  DiaryInfoClass? diaryInfo;

  @override
  void initState() {
    int recordKey = dateTimeKey(widget.dateTime);
    RecordBox? record = recordRepository.recordBox.get(recordKey);

    conditionList = conditionRepository.conditionList.where((condition) {
      List<String> conditionIdList = record?.conditionIdList ?? [];
      return conditionIdList.contains(condition.id);
    }).toList();

    if (record != null) {
      morningWeight = record.morningWeight;
      nightWeight = record.nightWeight;
      imageList = record.imageList ?? [];
      conditionList = conditionList;

      diaryInfo = record.diaryInfo != null
          ? DiaryInfoClass(
              text: record.diaryInfo!['text'] ?? '',
              textAlign: textAlignInfo[record.diaryInfo!['textAlign']] ??
                  TextAlign.left,
              memoImageList: getMemoImageList(
                record.diaryInfo!['memoImageList'],
              ),
            )
          : null;
    }

    super.initState();
  }

  onViewWeight() async {
    bool isView = user.categoryOpenIdList.contains(eWegihtId);

    isView
        ? user.categoryOpenIdList.remove(eWegihtId)
        : user.categoryOpenIdList.add(eWegihtId);

    await user.save();
  }

  onViewImage() async {
    bool isView = user.categoryOpenIdList.contains(eImageId);

    isView
        ? user.categoryOpenIdList.remove(eImageId)
        : user.categoryOpenIdList.add(eImageId);

    await user.save();
  }

  onViewDiet() async {
    bool isView = user.categoryOpenIdList.contains(eDietId);

    isView
        ? user.categoryOpenIdList.remove(eDietId)
        : user.categoryOpenIdList.add(eDietId);

    await user.save();
  }

  onViewExericse() async {
    bool isView = user.categoryOpenIdList.contains(eExerciseId);

    isView
        ? user.categoryOpenIdList.remove(eExerciseId)
        : user.categoryOpenIdList.add(eExerciseId);

    await user.save();
  }

  onViewCondition() async {
    bool isView = user.categoryOpenIdList.contains(eConditionId);

    isView
        ? user.categoryOpenIdList.remove(eConditionId)
        : user.categoryOpenIdList.add(eConditionId);

    await user.save();
  }

  onViewDiary() async {
    bool isView = user.categoryOpenIdList.contains(eDiaryId);

    isView
        ? user.categoryOpenIdList.remove(eDiaryId)
        : user.categoryOpenIdList.add(eDiaryId);

    await user.save();
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

  onRemoveWeight(String id) {
    setState(() {
      id == 'morning' ? morningWeight = null : nightWeight = null;
    });
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

  onRemoveImage(Uint8List uint8List) {
    setState(() {
      imageList.removeWhere((uint8List_) => uint8List_ == uint8List);
    });

    pop(context);
  }

  onSeletedCondition(ConditionBox selectionInfo) {
    int index = conditionList.indexWhere((info) => info.id == selectionInfo.id);

    setState(() {
      index == -1
          ? conditionList.add(selectionInfo)
          : conditionList.removeAt(index);
    });
  }

  onCompletedWeight(String id, double weight) {
    setState(() {
      id == 'morning' ? morningWeight = weight : nightWeight = weight;
    });

    pop(context);
  }

  onCompletedDiary(DiaryInfoClass completedDiaryInfo) {
    pop(context);
    setState(() => diaryInfo = completedDiaryInfo);
  }

  onRemoveDiary() {
    pop(context);
    setState(() => diaryInfo = null);
  }

  onSaveRecord() async {
    int recordKey = dateTimeKey(widget.dateTime);
    RecordBox? record = recordRepository.recordBox.get(recordKey);

    List<Uint8List>? imageList_ = imageList.isNotEmpty ? imageList : null;
    List<String>? conditionIdList_ = conditionList.isNotEmpty
        ? conditionList.map((condition) => condition.id).toList()
        : null;
    Map<String, dynamic>? diaryInfo_ = diaryInfo != null
        ? {
            'text': diaryInfo?.text ?? '',
            'textAlign':
                diaryInfo?.textAlign.toString() ?? TextAlign.left.toString(),
            'memoImageList': diaryInfo?.memoImageList
          }
        : null;

    if (record == null) {
      recordRepository.updateRecord(
        key: dateTimeKey(widget.dateTime),
        record: RecordBox(
          createDateTime: widget.dateTime,
          morningWeight: morningWeight,
          nightWeight: nightWeight,
          imageList: imageList_,
          conditionIdList: conditionIdList_,
          diaryInfo: diaryInfo_,
        ),
      );
    } else {
      record.morningWeight = morningWeight;
      record.nightWeight = nightWeight;
      record.imageList = imageList_;
      record.conditionIdList = conditionIdList_;
      record.diaryInfo = diaryInfo_;

      await record.save();
    }

    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isSaveButton = morningWeight != null ||
        nightWeight != null ||
        imageList.isNotEmpty ||
        conditionList.isNotEmpty ||
        diaryInfo != null;

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) => CommonBackground(
        child: CommonScaffold(
          appBarInfo: AppBarInfoClass(
            title: mdeFormatter(locale: locale, dateTime: widget.dateTime),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                          onCamera: (uint8List) =>
                              onCamera(uint8List, isPremium),
                          onGallery: (uint8ListArray) => onGallery(
                            uint8ListArray,
                            isPremium,
                          ),
                          onSlide: onSlide,
                          onRemove: onRemoveImage,
                          onView: onViewImage,
                        ),
                        // DietContainer(onView: onViewDiet),
                        // ExerciseContainer(onView: onViewExericse),
                        ConditionContainer(
                          conditionList: conditionList,
                          onViewCondition: onViewCondition,
                          onSeletedCondition: onSeletedCondition,
                        ),
                        DiaryContainer(
                          isPremium: isPremium,
                          diaryInfo: diaryInfo,
                          onCompleted: onCompletedDiary,
                          onRemove: onRemoveDiary,
                          onView: onViewDiary,
                        ),
                      ],
                    ),
                  ),
                ),
                CommonButton(
                  outerPadding: const EdgeInsets.only(top: 10),
                  text: '저장',
                  textColor: isSaveButton ? Colors.white : grey.s400,
                  buttonColor: isSaveButton ? darkButtonColor : Colors.white,
                  verticalPadding: 12.5,
                  borderRadius: 7,
                  onTap: isSaveButton ? onSaveRecord : () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
