import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:provider/provider.dart';

class CommonSwitch extends StatelessWidget {
  CommonSwitch({
    super.key,
    required this.activeColor,
    required this.value,
    required this.onChanged,
  });

  Color activeColor;
  bool value;
  Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CupertinoSwitch(
      trackColor: isLight ? null : darkNotSelectedBgColor,
      activeColor: isLight ? activeColor : grey.s300,
      value: value,
      onChanged: onChanged,
    );
  }
}
