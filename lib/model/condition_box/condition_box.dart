import 'package:hive/hive.dart';

part 'condition_box.g.dart';

@HiveType(typeId: 3)
class ConditionBox extends HiveObject {
  ConditionBox({
    required this.id,
    required this.colorName,
    required this.text,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String colorName;

  @HiveField(2)
  String text;
}
