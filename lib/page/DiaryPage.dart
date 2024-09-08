import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/common/CommonSvg.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/common/CommonTextFormField.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/popup/AlertPopup.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({super.key, this.diaryInfo, required this.onCompleted});

  DiaryInfoClass? diaryInfo;
  Function(DiaryInfoClass) onCompleted;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  TextEditingController controller = TextEditingController();
  TextAlign textAlign = TextAlign.left;

  @override
  void initState() {
    if (widget.diaryInfo != null) {
      controller.text = widget.diaryInfo!.text;
      textAlign = widget.diaryInfo!.textAlign;
    }

    super.initState();
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
    if (controller.text != '') {
      widget.onCompleted(
        DiaryInfoClass(text: controller.text, textAlign: textAlign),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '한 글자 이상 입력해주세요',
          buttonText: '확인',
          height: 170,
          onTap: () => pop(context),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.all(0),
        appBarInfo: AppBarInfoClass(title: '일기'),
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
                  child: CommonTextFormField(
                    hintText: '오늘 하루 어땠는지 기록해보아요 :D',
                    isContainer: false,
                    controller: controller,
                    textAlign: textAlign,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                CommonSvg(
                  name: 'align-${textAlignName[textAlign]}',
                  onTap: onAlign,
                  padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                ),
                CommonSvg(
                  name: 'clock',
                  onTap: onTime,
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                ),
                const Spacer(),
                InkWell(
                  onTap: onCompleted,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                    child: CommonText(text: '완료'),
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
