import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 1)
class UserBox extends HiveObject {
  UserBox({
    required this.id,
    required this.createDateTime,
    required this.fontFamily,
    required this.calendarMaker,
    required this.theme,
    required this.fontSize,
    required this.background,
    required this.weightUnit,
    required this.categoryOpenIdList,
    this.googleDriveInfo,
    this.alarmInfo,
    this.goalInfo,
    this.passwords,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime createDateTime;

  @HiveField(2)
  String calendarMaker;

  @HiveField(3)
  String theme;

  @HiveField(4)
  String fontFamily;

  @HiveField(5)
  double fontSize;

  @HiveField(6)
  int background;

  @HiveField(7)
  String weightUnit;

  @HiveField(8)
  List<String> categoryOpenIdList;

  @HiveField(9)
  Map<String, dynamic>? googleDriveInfo;

  @HiveField(10)
  Map<String, dynamic>? alarmInfo;

  @HiveField(11)
  Map<String, dynamic>? goalInfo;

  @HiveField(12)
  String? passwords;
}
