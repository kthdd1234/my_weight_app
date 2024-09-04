import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:provider/provider.dart';

class WeightTextFormField extends StatelessWidget {
  WeightTextFormField({
    super.key,
    required this.controller,
    this.textAlign,
    this.focusNode,
    this.fontSize,
    this.autofocus,
    this.onEditingComplete,
    this.textInputAction,
    this.hintText,
    this.contentPadding,
    this.isUnderline,
    this.maxLength,
    this.focusedBorderColor,
    this.textColor,
    this.cursorColor,
    this.keyboardType,
    this.isSuffix,
    this.onChanged,
  });

  TextEditingController controller;
  TextAlign? textAlign;
  String? hintText;
  double? fontSize;
  bool? autofocus;
  FocusNode? focusNode;
  TextInputAction? textInputAction;
  EdgeInsets? contentPadding;
  bool? isUnderline, isSuffix;
  int? maxLength;
  Color? textColor, focusedBorderColor, cursorColor;
  TextInputType? keyboardType;
  Function()? onEditingComplete;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: TextFormField(
        keyboardType: keyboardType,
        focusNode: focusNode,
        controller: controller,
        autofocus: autofocus ?? true,
        maxLines: null,
        maxLength: maxLength,
        minLines: null,
        cursorColor: cursorColor,
        textInputAction: textInputAction ?? TextInputAction.newline,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
        textAlign: textAlign ?? TextAlign.left,
        decoration: InputDecoration(
          suffixIcon: isSuffix == true
              ? CommonText(
                  text: 'kg',
                  color: controller.text == '' ? grey.s400 : textColor,
                  fontSize: defaultFontSize - 2,
                )
              : null,
          suffixIconConstraints: isSuffix == true
              ? const BoxConstraints(minWidth: 0, minHeight: 0)
              : null,
          suffixStyle: TextStyle(
            color: cursorColor,
            fontSize: defaultFontSize - 2,
          ),
          suffixText: isSuffix == null ? 'kg' : null,
          counterText: "",
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(color: grey.s400),
          border: isUnderline != true ? InputBorder.none : null,
          enabledBorder: isUnderline == true
              ? UnderlineInputBorder(borderSide: BorderSide(color: grey.s400))
              : null,
          focusedBorder: isUnderline == true
              ? UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: focusedBorderColor ?? themeColor),
                )
              : null,
        ),
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
      ),
    );
  }
}
