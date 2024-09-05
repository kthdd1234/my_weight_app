import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';

class CommonModalSheet extends StatelessWidget {
  CommonModalSheet({
    required this.height,
    required this.child,
    super.key,
    this.title,
    this.isNotTr,
    this.isClose,
    this.nameArgs,
  });

  String? title;
  double height;
  bool? isBack, isNotTr, isClose;
  Widget child;
  Map<String, String>? nameArgs;

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      height: height,
      isRadius: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              title != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          isClose == true
                              ? const Icon(Icons.close,
                                  color: Colors.transparent)
                              : const CommonNull(),
                          const Spacer(),
                          CommonText(text: title!, nameArgs: nameArgs),
                          const Spacer(),
                          isClose == true
                              ? InkWell(
                                  onTap: () => pop(context),
                                  child: Icon(
                                    Icons.close,
                                    color: grey.original,
                                  ),
                                )
                              : const CommonNull()
                        ],
                      ),
                    )
                  : const CommonNull(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
