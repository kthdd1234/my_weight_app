import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonImage.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';

class DietExerciseView extends StatelessWidget {
  DietExerciseView({super.key, required this.onTap});

  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonImage(
              text: '☀️',
              uint8List: null,
              height: 100,
              onTap: (_) => onTap(),
            ),
            CommonSpace(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(text: '아침'),
                  CommonText(
                    text: '오전 12:15',
                    fontSize: defaultFontSize - 3,
                  ),
                  CommonSpace(height: 5),
                  Expanded(
                    child: CommonText(
                      text: '현미밥 \n김치\n된장국\navigator',
                      color: grey.original,
                      fontSize: defaultFontSize - 5,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            Icon(Icons.more_vert_rounded, size: 15, color: grey.s400)
          ],
        ),
      ),
    );
  }
}
