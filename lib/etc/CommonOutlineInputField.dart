import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:provider/provider.dart';

class CommonOutlineInputField extends StatelessWidget {
  CommonOutlineInputField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onEditingComplete,
    required this.onSuffixIcon,
    required this.selectedColor,
    this.autofocus,
    this.outerPadding,
    this.onChanged,
  });

  String hintText;
  TextEditingController controller;
  bool? autofocus;
  EdgeInsets? outerPadding;
  Color selectedColor;
  Function() onEditingComplete, onSuffixIcon;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: outerPadding ?? const EdgeInsets.all(0.0),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          style: TextStyle(
            color: isLight ? themeColor : darkTextColor,
            fontWeight: isLight ? FontWeight.normal : FontWeight.bold,
            fontSize: defaultFontSize - 1,
          ),
          controller: controller,
          autofocus: autofocus ?? false,
          cursorColor: selectedColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 25),
            hintText: hintText.tr(),
            hintStyle: TextStyle(color: grey.s400),
            filled: true,
            fillColor: isLight ? Color(0xffEAEAEA) : const Color(0xff3D3E4B),
            prefixIcon: Icon(Icons.search_rounded, color: grey.s400),
            // suffixIcon: GestureDetector(
            //   onTap: onSuffixIcon,
            //   child: UnconstrainedBox(
            //     child: Container(
            //       width: 30,
            //       height: 30,
            //       decoration: BoxDecoration(
            //         color: controller.text == ''
            //             ? isLight
            //                 ? grey.s300
            //                 : grey.original
            //             : selectedColor,
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //       child: const Icon(
            //         Icons.arrow_upward_rounded,
            //         color: Colors.white,
            //         size: 20,
            //       ),
            //     ),
            //   ),
            // ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
