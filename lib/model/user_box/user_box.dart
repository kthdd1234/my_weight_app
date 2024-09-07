import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 1)
class UserBox extends HiveObject {
  UserBox({
    required this.id,
    required this.createDateTime,
    required this.fontFamily,
    required this.theme,
    required this.fontSize,
    required this.background,
    required this.weightUnit,
    required this.categoryOpenIdList,
    required this.conditionOrderIdList,
    required this.goalInfo,
    this.googleDriveInfo,
    this.alarmInfo,
    this.passwords,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime createDateTime;

  @HiveField(2)
  String theme;

  @HiveField(3)
  String fontFamily;

  @HiveField(4)
  double fontSize;

  @HiveField(5)
  int background;

  @HiveField(6)
  String weightUnit;

  @HiveField(7)
  List<String> categoryOpenIdList;

  @HiveField(8)
  List<String> conditionOrderIdList;

  @HiveField(9)
  Map<String, dynamic> goalInfo;

  @HiveField(10)
  Map<String, dynamic>? googleDriveInfo;

  @HiveField(11)
  Map<String, dynamic>? alarmInfo;

  @HiveField(12)
  String? passwords;
}
