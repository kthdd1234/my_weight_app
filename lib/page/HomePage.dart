import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/body/CalendarBody.dart';
import 'package:my_weight_app/body/GraphBody.dart';
import 'package:my_weight_app/body/MoreBody.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonScaffold.dart';
import 'package:my_weight_app/provider/BottomTabIndexProvider.dart';
import 'package:my_weight_app/provider/SelectedDateTimeProvider.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/provider/TitleDateTimeProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/home/FnbButton.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initializePremium() async {
  //   bool isPremium = await isPurchasePremium();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     context.read<PremiumProvider>().setPremiumValue(isPremium);
  //   });
  // }

  onBottomNavigation(int newIndex) {
    if (newIndex == 0 || newIndex == 1) {
      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: DateTime.now());
      context
          .read<TitleDateTimeProvider>()
          .changeTitleDateTime(dateTime: DateTime.now());
    }

    context.read<BottomTabIndexProvider>().changeSeletedIdx(newIndex: newIndex);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    int currentIndex = context.watch<BottomTabIndexProvider>().seletedIdx;

    svg(int idx, String name) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: svgAsset(
          isLight: isLight,
          name: name,
          width: 20,
          color: idx == currentIndex ? Colors.black : grey.s400,
        ),
      );
    }

    List<BNClass> bnList = [
      BNClass(index: 0, name: '캘린더', icon: svg(0, 'calendar')),
      BNClass(index: 1, name: '그래프', icon: svg(1, 'graph')),
      BNClass(index: 2, name: '설정', icon: svg(2, 'more'))
    ];

    List<BottomNavigationBarItem> bnbItemList = bnList
        .map(
          (bn) => BottomNavigationBarItem(label: bn.name.tr(), icon: bn.icon),
        )
        .toList();

    Widget body = [
      const CalendarBody(),
      const GraphBody(),
      const MoreBody(),
    ][currentIndex];

    return CommonBackground(
      child: CommonScaffold(
        body: body,
        floatingActionButton: currentIndex == 0 ? const FnbButton() : null,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: BottomNavigationBar(
            items: bnbItemList,
            elevation: 0,
            selectedItemColor: isLight ? Colors.black : Colors.white,
            selectedLabelStyle: TextStyle(
              color: isLight ? Colors.black : Colors.white,
              fontWeight: isLight ? null : FontWeight.bold,
              fontSize: defaultFontSize - 2,
            ),
            unselectedItemColor: grey.s400,
            unselectedLabelStyle: TextStyle(
              fontWeight: isLight ? null : FontWeight.bold,
              fontSize: defaultFontSize - 2,
            ),
            currentIndex: currentIndex,
            onTap: onBottomNavigation,
          ),
        ),
      ),
    );
  }
}

// isLight
//                 ? const Color.fromARGB(255, 115, 120, 139)
//                 : const Color(0xff616261),