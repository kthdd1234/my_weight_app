import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/model/user_box/user_box.dart';
import 'package:my_weight_app/page/PremiumPage.dart';
import 'package:my_weight_app/provider/PremiumProvider.dart';
import 'package:my_weight_app/provider/ReloadProvider.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/bottomSheet/LanguageBottomSheet.dart';
import 'package:my_weight_app/widget/bottomSheet/WeightUnitBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreBody extends StatefulWidget {
  const MoreBody({super.key});

  @override
  State<MoreBody> createState() => _MoreBodyState();
}

class _MoreBodyState extends State<MoreBody> {
  String appVerstion = '';
  String appBuildNumber = '';

  @override
  void initState() {
    getInfo() async {
      Map<String, dynamic> appInfo = await getAppInfo();

      appVerstion = appInfo['appVerstion'];
      appBuildNumber = appInfo['appBuildNumber'];

      setState(() {});
    }

    getInfo();
    super.initState();
  }

  onPremium() {
    navigator(context: context, page: const PremiumPage());
  }

  onPrivacy() async {
    Uri url = Uri(
      scheme: 'https',
      host: 'nettle-dill-e85.notion.site',
      path: 'ba155d3a708e4966bf3a9c06ece6e780',
      queryParameters: {'pvs': '4'},
    );

    await canLaunchUrl(url) ? await launchUrl(url) : throw 'launchUrl error';
  }

  onLanguage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  onUnit() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const WeightUnitBottomSheet(),
    );
  }

  onReview() {
    InAppReview inAppReview = InAppReview.instance;

    inAppReview.openStoreListing(
      appStoreId: appleId,
      microsoftStoreId: androidId,
    );
  }

  onShare() {
    Platform.isIOS
        ? Share.share(APP_STORE_LINK, subject: '몸무게 달력')
        : Share.share(PLAY_STORE_LINK, subject: '몸무게 달력');
  }

  onVersion() async {
    Uri url = Platform.isIOS ? iosUrl : androidUrl;
    await canLaunchUrl(url) ? await launchUrl(url) : print('err');
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        UserBox user = userRepository.user;
        String weightUnit = user.weightUnit;
        String locale = context.locale.toString();
        bool isPremium = context.watch<PremiumProvider>().isPremium;

        onReset() async {
          try {
            await recordRepository.recordBox.clear();
            await conditionRepository.conditionBox.clear();
            await userRepository.userBox.clear();

            context.read<ReloadProvider>().setReload(true);
            await Navigator.pushNamedAndRemoveUntil(
              context,
              'start-page',
              (_) => false,
            );
          } catch (e) {
            print('???????????/32032032030230203020');
            print('$e');
          }
        }

        List<MoreItem> moreItemList = [
          MoreItem(
            svgName: 'premium-free',
            title: '프리미엄',
            value: isPremium ? '구매 완료' : '미구매',
            onMore: onPremium,
          ),
          MoreItem(
            svgName: 'language',
            title: '언어',
            value: localeInfo[locale],
            isNotTr: true,
            onMore: onLanguage,
          ),
          MoreItem(
            svgName: 'unit',
            title: '단위',
            value: weightUnit,
            isNotTr: true,
            onMore: onUnit,
          ),
          MoreItem(
            svgName: 'review',
            title: '리뷰',
            value: '',
            isNotTr: true,
            onMore: onReview,
          ),
          MoreItem(
            svgName: 'share',
            title: '공유',
            value: '',
            isNotTr: true,
            onMore: onShare,
          ),
          MoreItem(
            svgName: 'trash',
            title: '초기화',
            value: '',
            isNotTr: true,
            onMore: onReset,
          ),
          MoreItem(
            svgName: 'privacy',
            title: '개인정보처리방침',
            onMore: onPrivacy,
          ),
          MoreItem(
            svgName: 'version',
            title: '앱 버전',
            value: '$appVerstion ($appBuildNumber)',
            isNotTr: true,
            onMore: onVersion,
          ),
        ];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CommonText(text: '설정', fontSize: defaultFontSize + 3),
                ),
                Column(
                  children: moreItemList
                      .map((more) => MoreItem(
                            svgName: more.svgName,
                            title: more.title,
                            value: more.value,
                            isNotTr: more.isNotTr,
                            onMore: more.onMore,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MoreItem extends StatelessWidget {
  MoreItem({
    super.key,
    required this.svgName,
    required this.title,
    required this.onMore,
    this.isNotTr,
    this.value,
  });

  String svgName, title;
  String? value;
  bool? isNotTr;
  Function() onMore;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: onMore,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.5),
        child: Row(
          children: [
            svgAsset(name: svgName, width: 18, isLight: isLight),
            CommonSpace(width: 15),
            CommonText(text: title),
            const Spacer(),
            value != null
                ? Row(
                    children: [
                      CommonText(
                        text: value!,
                        fontSize: defaultFontSize - 1,
                        color: isLight ? grey.original : grey.s400,
                        isNotTr: isNotTr,
                      ),
                      svgName != 'version'
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 1, left: 5),
                              child: svgAsset(
                                name: 'dir-right',
                                width: 6,
                                color: grey.original,
                                isLight: isLight,
                              ),
                            )
                          : const CommonNull()
                    ],
                  )
                : const CommonNull(),
          ],
        ),
      ),
    );
  }
}

  // MoreItem(
      //   svgName: 'screen',
      //   title: '화면',
      //   value: themesInfo[user.theme],
      //   onMore: onScreen,
      // ),
      // MoreItem(
      //   svgName: 'premium-backdrop',
      //   title: '배경',
      //   value: getBackgroundName(background),
      //   onMore: onBackground,
      // ),
      // MoreItem(
      //   svgName: 'font',
      //   title: '글꼴',
      //   value: getFontFamilyName(fontFamily),
      //   onMore: onFont,
      // ),
      // MoreItem(
      //   svgName: 'review',
      //   title: '앱 리뷰',
      //   onMore: onReview,
      // ),
      // MoreItem(
      //   svgName: 'share',
      //   title: '앱 공유',
      //   onMore: onShare,
      // ),