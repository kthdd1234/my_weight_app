import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:provider/provider.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    super.key,
    required this.body,
    this.appBarInfo,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.padding,
    this.floatingActionButton,
    this.leading,
    this.initFontSize,
  });

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset;
  Color? backgroundColor;
  EdgeInsets? padding;
  Widget? floatingActionButton;
  Widget? leading;
  double? initFontSize;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              foregroundColor: isLight ? Colors.black : darkTextColor,
              title: CommonText(
                text: appBarInfo!.title,
                fontSize: defaultFontSize + 1,
                isBold: !isLight,
                isNotTr: appBarInfo?.isNotTr,
              ),
              leading: leading,
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: backgroundColor ?? Colors.transparent,
              scrolledUnderElevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(10),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
