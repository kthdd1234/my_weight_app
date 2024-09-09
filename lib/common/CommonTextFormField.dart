import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';

class CommonTextFormField extends StatelessWidget {
  CommonTextFormField({
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
    this.isContainer,
    this.onChanged,
  });

  TextEditingController controller;
  TextAlign? textAlign;
  String? hintText;
  double? fontSize;
  FocusNode? focusNode;
  TextInputAction? textInputAction;
  EdgeInsets? contentPadding;
  bool? autofocus, isUnderline, isSuffix, isContainer;
  int? maxLength;
  Color? textColor, focusedBorderColor, cursorColor;
  TextInputType? keyboardType;
  Function()? onEditingComplete;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    Widget textFormField = TextFormField(
      keyboardType: keyboardType,
      focusNode: focusNode,
      controller: controller,
      autofocus: autofocus ?? true,
      maxLines: null,
      maxLength: maxLength,
      minLines: null,
      cursorColor: cursorColor ?? darkButtonColor,
      textInputAction: textInputAction ?? TextInputAction.newline,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
      ),
      textAlign: textAlign ?? TextAlign.left,
      decoration: InputDecoration(
        suffixIconConstraints: isSuffix == true
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
        suffixStyle: TextStyle(
          color: cursorColor,
          fontSize: defaultFontSize - 2,
        ),
        suffixText: isSuffix != null ? userRepository.user.weightUnit : null,
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
                borderSide: BorderSide(color: focusedBorderColor ?? themeColor),
              )
            : null,
      ),
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );

    if (isContainer == false) {
      return textFormField;
    }

    return CommonContainer(
      child: textFormField,
    );
  }
}
