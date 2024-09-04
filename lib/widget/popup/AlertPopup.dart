import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonButton.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonPopup.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class AlertPopup extends StatelessWidget {
  AlertPopup({
    super.key,
    required this.desc,
    required this.buttonText,
    required this.height,
    required this.onTap,
    this.isCancel,
  });

  double height;
  String desc, buttonText;
  bool? isCancel;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonPopup(
      insetPaddingHorizontal: 20,
      height: height,
      child: Column(
        children: [
          CommonContainer(
            outerPadding: const EdgeInsets.all(20),
            child: CommonText(text: desc, isBold: !isLight),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: CommonButton(
                    text: buttonText,
                    textColor: Colors.white,
                    buttonColor: isLight ? red.s200 : darkButtonColor,
                    verticalPadding: 15,
                    borderRadius: 7,
                    onTap: onTap,
                  ),
                ),
                CommonSpace(width: isCancel == true ? 10 : 0),
                isCancel == true
                    ? Expanded(
                        child: CommonButton(
                          text: '취소',
                          textColor: Colors.black,
                          buttonColor: Colors.white,
                          verticalPadding: 15,
                          borderRadius: 7,
                          onTap: () => pop(context),
                        ),
                      )
                    : const CommonNull()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
