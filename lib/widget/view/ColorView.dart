import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonCircle.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class ColorView extends StatelessWidget {
  ColorView({
    super.key,
    required this.selectedColorName,
    required this.onColor,
  });

  String selectedColorName;
  Function(String) onColor;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 30,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: colorList
              .map(
                (color) => Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: GestureDetector(
                    onTap: () => onColor(color.colorName),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CommonCircle(
                          color: isLight ? color.s100 : color.s300,
                          size: 30,
                        ),
                        selectedColorName == color.colorName
                            ? svgAsset(
                                name: 'check',
                                width: 20,
                                color: Colors.white,
                                isLight: isLight,
                              )
                            : const CommonNull(),
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
