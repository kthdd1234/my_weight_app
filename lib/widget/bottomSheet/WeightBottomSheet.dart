import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonTextFormField.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';

class WeightBottomSheet extends StatefulWidget {
  WeightBottomSheet({
    super.key,
    required this.id,
    required this.title,
    required this.onCompleted,
    this.initWeight,
  });

  String id, title;
  double? initWeight;
  Function(String id, double weight) onCompleted;

  @override
  State<WeightBottomSheet> createState() => _WeightBottomSheetState();
}

class _WeightBottomSheetState extends State<WeightBottomSheet> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initWeight != null) {
      controller.text = widget.initWeight!.toString();
    }

    super.initState();
  }

  onChanged(_) {
    bool isInit = isDoubleTryParse(text: controller.text) == false ||
        isErorr(
          unit: userRepository.user.weightUnit,
          value: stringToDouble(controller.text),
        );

    if (isInit || controller.text.length > 5) {
      controller.text = '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = isDoubleTryParse(text: controller.text);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '${widget.title} 몸무게',
        height: 185,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonTextFormField(
                isSuffix: true,
                autofocus: true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: controller,
                cursorColor: widget.id == 'morning' ? blue.s400 : red.s300,
                textColor: widget.id == 'morning' ? blue.original : red.s400,
                hintText: '몸무게를 입력해주세요'.tr(),
                onChanged: onChanged,
              ),
              CommonSpace(height: 5),
              CommonButton(
                outerPadding: const EdgeInsets.only(top: 10),
                text: '완료',
                textColor: isCompleted ? Colors.white : grey.s400,
                buttonColor: isCompleted
                    ? widget.id == 'morning'
                        ? blue.s300
                        : red.s200
                    : Colors.white,
                verticalPadding: 10,
                borderRadius: 7,
                onTap: () {
                  if (isCompleted) {
                    widget.onCompleted(
                      widget.id,
                      stringToDouble(controller.text),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
