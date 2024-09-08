import 'dart:typed_data';

import 'package:flutter/material.dart';

class AppBarInfoClass {
  AppBarInfoClass({
    required this.title,
    this.isCenter,
    this.actions,
    this.isNotTr,
  });

  String title;
  bool? isCenter, isNotTr;
  List<Widget>? actions;
}

class PremiumBenefitsClass {
  PremiumBenefitsClass({
    required this.svgName,
    required this.title,
    required this.subTitle,
  });

  String svgName, title, subTitle;
}

class BackgroundClass {
  BackgroundClass({required this.path, required this.name});
  String path, name;
}

class ColorClass {
  ColorClass({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.original,
    required this.colorName,
  });

  String colorName;
  Color s50, s100, s200, s300, s400, original;
}

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
}

class ImageClass {
  ImageClass({required this.dateTime, required this.uint8List});
  DateTime dateTime;
  Uint8List uint8List;
}

class SettingItemClass {
  SettingItemClass({
    required this.name,
    required this.svg,
    required this.onTap,
    this.value,
  });

  String name, svg;
  Widget? value;
  Function() onTap;
}

class WeightInfoClass {
  WeightInfoClass({
    required this.id,
    required this.name,
    this.value,
  });

  String id, name;
  double? value;
}

class ConditionInfoClass {
  ConditionInfoClass({
    required this.id,
    required this.text,
    required this.colorName,
  });

  String id, text, colorName;
}

class DiaryInfoClass {
  DiaryInfoClass({required this.text, required this.textAlign});

  String text;
  TextAlign textAlign;
}

class GoalInfoClass {
  GoalInfoClass({this.goalDateTime, this.goalWeight});

  DateTime? goalDateTime;
  double? goalWeight;
}

class DietExerciseInfoClass {}

class DietExerciseTypeClass {
  DietExerciseTypeClass({
    required this.id,
    required this.name,
    required this.colorName,
    required this.emoji,
  });

  String id, name, colorName, emoji;
}
