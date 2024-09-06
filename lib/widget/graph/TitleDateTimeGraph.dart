import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';

class TitleDateTimeGraph extends StatelessWidget {
  TitleDateTimeGraph({
    super.key,
    required this.startDateTime,
    required this.endDateTime,
  });

  DateTime startDateTime, endDateTime;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommonText(
            text: '${ymdeShortFormatter(
              locale: locale,
              dateTime: startDateTime,
            )} ~ ${ymdeShortFormatter(
              locale: locale,
              dateTime: endDateTime,
            )}',
            fontSize: defaultFontSize - 3,
            color: grey.original,
            isNotTr: true,
          )
        ],
      ),
    );
  }
}
