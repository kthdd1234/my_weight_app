import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonDivider.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonTag.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/common/CommonTextFormField.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:provider/provider.dart';

class DietExerciseBottomSheet extends StatefulWidget {
  const DietExerciseBottomSheet({super.key});

  @override
  State<DietExerciseBottomSheet> createState() =>
      _DietExerciseBottomSheetState();
}

class _DietExerciseBottomSheetState extends State<DietExerciseBottomSheet> {
  TextEditingController textController = TextEditingController();
  String? selectedTypeId;

  onType(String id) {
    setState(() => selectedTypeId = id);
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = defaultFontSize - 2;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '식단 추가',
        isClose: true,
        height: 350,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BottomSheetItem(
                      title: '사진',
                      child: CommonTag(
                        text: '+ 사진 추가',
                        isColor: true,
                        colorName: '청회색',
                        onTap: () {},
                        fontSize: fontSize,
                      ),
                    ),
                    BottomSheetItem(
                      title: '시간',
                      child: CommonTag(
                        text: '오후 2:04',
                        onTap: () {},
                        fontSize: fontSize,
                      ),
                    ),
                    BottomSheetItem(
                      title: '분류',
                      child: Row(
                        children: dietTypeClassList
                            .map((info) => Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CommonTag(
                                    text: info.name,
                                    fontSize: fontSize,
                                    isColor: true,
                                    isSelection: info.id == selectedTypeId,
                                    colorName: info.colorName,
                                    onTap: () => onType(info.id),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    CommonTextFormField(
                      controller: textController,
                      hintText: '먹은 음식 또는 메모를 간단히 남겨주세요.',
                    ),
                  ],
                ),
              ),
            ),
            CommonButton(
              outerPadding: const EdgeInsets.only(top: 10),
              text: '완료',
              textColor: grey.s400,
              buttonColor: Colors.white,
              verticalPadding: 10,
              borderRadius: 7,
              onTap: () {
                //
              },
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  BottomSheetItem({super.key, required this.title, required this.child});

  String title;
  Widget child;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Column(
      children: [
        Row(children: [CommonText(text: title), const Spacer(), child]),
        CommonDivider(vertical: 15)
      ],
    );
  }
}

/**
 * 사진
 * 시간
 * 분류
 * 메모
 */