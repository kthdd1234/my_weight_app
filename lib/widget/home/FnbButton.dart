import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/page/ContainerPage.dart';
import 'package:my_weight_app/provider/SelectedDateTimeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class FnbButton extends StatefulWidget {
  const FnbButton({super.key});

  @override
  State<FnbButton> createState() => _FnbButtonState();
}

class _FnbButtonState extends State<FnbButton> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: darkButtonColor,
      onPressed: () => navigator(
        context: context,
        page: ContainerPage(
          dateTime: selectedDateTime,
        ),
      ),
      child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
    );
  }
}
