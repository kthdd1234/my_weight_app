import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonSegmented.dart';
import 'package:my_weight_app/common/CommonSvgText.dart';
import 'package:my_weight_app/common/CommonTag.dart';
import 'package:my_weight_app/provider/SelectedDateTimeProvider.dart';
import 'package:my_weight_app/provider/TitleDateTimeProvider.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:my_weight_app/widget/popup/CalendarPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarTitle extends StatefulWidget {
  CalendarTitle({
    super.key,
    required this.selectedSegment,
    required this.onSegmentedChanged,
  });

  SegmentedTypes selectedSegment;
  Function(SegmentedTypes?) onSegmentedChanged;

  @override
  State<CalendarTitle> createState() => _CalendarTitleState();
}

class _CalendarTitleState extends State<CalendarTitle> {
  onCalendar(DateTime titleDateTime) {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.year,
        initialdDateTime: titleDateTime,
        onSelectionChanged: (args) {
          context
              .read<SelectedDateTimeProvider>()
              .changeSelectedDateTime(dateTime: args.value);
          context
              .read<TitleDateTimeProvider>()
              .changeTitleDateTime(dateTime: args.value);

          pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;

    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 7,
      ),
      child: Row(
        children: [
          CommonSvgText(
            text: yMFormatter(
              locale: locale,
              dateTime: titleDateTime,
            ),
            fontSize: 20,
            svgWidth: 5,
            svgName: 'dir-right-bold',
            svgDirection: SvgDirection.right,
            onTap: () => onCalendar(titleDateTime),
          ),
          const Spacer(),
          SizedBox(
            width: 100,
            child: CommonSegmented(
              selectedSegment: widget.selectedSegment,
              children: categorySegmented(widget.selectedSegment),
              onSegmentedChanged: widget.onSegmentedChanged,
            ),
          )
        ],
      ),
    );
  }
}
