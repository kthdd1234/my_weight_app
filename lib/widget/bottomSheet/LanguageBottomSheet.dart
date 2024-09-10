import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonModalButton.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/provider/ReloadProvider.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    bool isReload = context.watch<ReloadProvider>().isReload;
    String locale = context.locale.toString();

    onLang(String selectedLocale) {
      context.setLocale(Locale(selectedLocale));
      context.read<ReloadProvider>().setReload(!isReload);

      pop(context);
    }

    return CommonModalSheet(
      title: '언어',
      height: 195,
      child: Row(
        children: [
          CommonModalButton(
            isSelection: locale == 'en',
            isNotSvgColor: true,
            isNotTr: true,
            svgName: 'usa',
            actionText: 'English',
            onTap: () => onLang('en'),
          ),
          CommonSpace(width: 5),
          CommonModalButton(
            isSelection: locale == 'ko',
            isNotSvgColor: true,
            isNotTr: true,
            svgName: 'korea',
            actionText: '한국어',
            onTap: () => onLang('ko'),
          ),
          CommonSpace(width: 5),
          CommonModalButton(
            isSelection: locale == 'ja',
            isNotSvgColor: true,
            isNotTr: true,
            svgName: 'japan',
            actionText: '日本語',
            onTap: () => onLang('ja'),
          ),
        ],
      ),
    );
  }
}
