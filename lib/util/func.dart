// ad: banner, native, appOpening
// ignore_for_file: prefer_const_declarations

import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

String getAdId(String ad) {
  final platform = Platform.isIOS ? 'ios' : 'android';
  final env = kDebugMode ? 'debug' : 'real';
  final adId = {
    'android': {
      'banner': {
        'debug': androidBannerTestId,
        'real': androidBannerRealId,
      },
      'native': {
        'debug': androidNativeTestId,
        'real': androidNativeRealId,
      },
      'appOpening': {
        'debug': androidAppOpeningTestId,
        'real': androidAppOpeningRealId,
      }
    },
    'ios': {
      'banner': {
        'debug': iOSBannerTestId,
        'real': iOSBannerRealId,
      },
      'native': {
        'debug': iOSNativeTestId,
        'real': iOSNativeRealId,
      },
      'appOpening': {
        'debug': iOSAppOpeningTestId,
        'real': iOSAppOpeningRealId,
      }
    },
  };

  return adId[platform]![ad]![env]!;
}

// ignore_for_file: unused_local_variable, prefer_const_declarations

SvgPicture svgAsset({
  required bool isLight,
  required String name,
  required double width,
  Color? color,
  bool? isNotColor,
}) {
  if (isNotColor == true) {
    return SvgPicture.asset('assets/svgs/$name.svg', width: width);
  }

  return SvgPicture.asset(
    'assets/svgs/$name.svg',
    width: width,
    colorFilter: ColorFilter.mode(
        color ?? (isLight ? Colors.black : Colors.white), BlendMode.srcIn),
  );
}

String ymdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMd(locale).format(dateTime);
}

String ymdFullFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMMd(locale).format(dateTime);
}

String mdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMEd(locale).format(dateTime);
}

String mdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMd(locale).format(dateTime);
}

String ymdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMEd(locale).format(dateTime);
}

String ymdeShortFormatter(
    {required String locale, required DateTime dateTime}) {
  return DateFormat.yMEd(locale).format(dateTime);
}

String ymdeFullFormatter({
  required String locale,
  required DateTime dateTime,
}) {
  return DateFormat.yMMMMEEEEd(locale).format(dateTime);
}

String yMFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMM(locale).format(dateTime);
}

String yFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.y(locale).format(dateTime);
}

String dFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.d(locale).format(dateTime);
}

String eFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.E(locale).format(dateTime);
}

String eeeeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.EEEE(locale).format(dateTime);
}

String hmFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.jm(locale).format(dateTime);
}

void pop(context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

int ymdToInt(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

int dateTimeKey(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

String uuid() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}

Future<Map<String, dynamic>> getAppInfo() async {
  PackageInfo info = await PackageInfo.fromPlatform();

  return {
    "appVerstion": info.version,
    'appBuildNumber': info.buildNumber,
  };
}

navigator({required BuildContext context, required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (BuildContext context) => page),
  );
}

fadeNavigator({required BuildContext context, required Widget page}) {
  Navigator.push(context, FadePageRoute(page: page));
}

NativeAd loadNativeAd({
  required bool isLight,
  required String adUnitId,
  required Function() onAdLoaded,
  required Function() onAdFailedToLoad,
}) {
  return NativeAd(
    adUnitId: adUnitId,
    listener: NativeAdListener(
      onAdLoaded: (adLoaded) {
        log('$adLoaded loaded~~~!!');
        onAdLoaded();
      },
      onAdFailedToLoad: (ad, error) {
        log('$NativeAd failed to load: $error');
        onAdFailedToLoad();
        ad.dispose();
      },
    ),
    request: const AdRequest(),
    nativeTemplateStyle: NativeTemplateStyle(
      templateType: TemplateType.medium,
      mainBackgroundColor: isLight ? Colors.white : darkContainerColor,
      cornerRadius: 5.0,
      tertiaryTextStyle: NativeTemplateTextStyle(
        textColor: isLight ? Colors.black : Colors.white,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: isLight ? Colors.black : Colors.white,
      ),
      secondaryTextStyle: NativeTemplateTextStyle(
        textColor: isLight ? Colors.black : Colors.white,
      ),
      callToActionTextStyle: NativeTemplateTextStyle(
        style: NativeTemplateFontStyle.bold,
        textColor: Colors.white,
        backgroundColor: themeColor,
        size: 16.0,
      ),
    ),
  )..load();
}

Future<bool> setPurchasePremium(Package package) async {
  try {
    CustomerInfo customerInfo = await Purchases.purchasePackage(package);

    return customerInfo.entitlements.all[entitlementIdentifier]?.isActive ==
        true;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

Future<bool> isPurchasePremium() async {
  try {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    bool isActive =
        customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;

    return isActive;
    // return true;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

Future<bool> isPurchaseRestore() async {
  try {
    CustomerInfo customerInfo = await Purchases.restorePurchases();
    bool isActive =
        customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;
    return isActive;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

DateTime weeklyStartDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime;
  }

  return dateTime.subtract(Duration(days: dateTime.weekday));
}

DateTime weeklyEndDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime.add(const Duration(days: 6));
  }

  return dateTime.add(Duration(
    days: DateTime.daysPerWeek - dateTime.weekday - 1,
  ));
}

calendarHeaderStyle(bool isLight) {
  return HeaderStyle(
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: isLight ? Colors.black : Colors.white,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    formatButtonVisible: false,
    leftChevronIcon: Icon(
      Icons.chevron_left,
      color: isLight ? indigo.s200 : Colors.white,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right,
      color: isLight ? indigo.s200 : Colors.white,
    ),
  );
}

calendarDaysOfWeekStyle(bool isLight) {
  return DaysOfWeekStyle(
    weekdayStyle: TextStyle(
      fontSize: defaultFontSize - 2,
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    weekendStyle: TextStyle(
      fontSize: defaultFontSize - 2,
      color: red.s300,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
  );
}

calendarDetailStyle(bool isLight) {
  return CalendarStyle(
    defaultTextStyle: TextStyle(
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    weekendTextStyle: TextStyle(
      color: isLight ? Colors.black : red.s300,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    todayDecoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    todayTextStyle: TextStyle(
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    outsideDaysVisible: false,
  );
}

List<Uint8List>? getImageList(List<dynamic>? uint8ListList) {
  if (uint8ListList == null) return null;
  return uint8ListList.map((data) => data as Uint8List).toList();
}

String getBackgroundName(String path) {
  List<BackgroundClass> expandList =
      backgroundClassList.expand((info) => info).toList();
  int index = expandList.indexWhere((info) => info.path == path);

  return expandList[index].name;
}

String getFontFamilyName(String fontFamily) {
  int index =
      fontFamilyList.indexWhere((info) => info['fontFamily'] == fontFamily);

  return fontFamilyList[index]['name']!;
}

todayBuilder(bool isLight, DateTime dateTime) {
  return Padding(
    padding: const EdgeInsets.only(top: 14),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          decoration: BoxDecoration(
            color: darkButtonColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(100),
          ),
          child: CommonText(text: '${dateTime.day}', color: Colors.white),
        ),
      ],
    ),
  );
}

bool isDoubleTryParse({required String text}) {
  return double.tryParse(text) != null;
}

stringToDouble(String? str) {
  if (str == null) return null;

  return double.parse(str);
}

bool isErorr({required String unit, required double? value}) {
  if (value == null || value < 1) return true;

  switch (unit) {
    case 'cm':
      return value >= cmMax;
    case 'inch':
      return value >= inchMax;
    case 'kg':
      return value >= kgMax;
    case 'lb':
      return value >= lbMax;
    default:
      return true;
  }
}

ColorClass getColorClass(String? name) {
  if (name == null) {
    return indigo;
  }

  return colorList.firstWhere((info) => info.colorName == name);
}
