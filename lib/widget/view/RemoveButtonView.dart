import 'package:flutter/material.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';

class RemoveButtonView extends StatelessWidget {
  RemoveButtonView({super.key, required this.id, required this.onRemove});

  String id;
  Function(String id) onRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onRemove(id),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 3, 0, 3),
        child: Icon(
          Icons.highlight_remove_rounded,
          color: grey.s400,
          size: defaultFontSize,
        ),
      ),
    );
  }
}
