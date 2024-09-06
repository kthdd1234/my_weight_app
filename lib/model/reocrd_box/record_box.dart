import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'record_box.g.dart';

@HiveType(typeId: 2)
class RecordBox extends HiveObject {
  RecordBox({
    required this.createDateTime,
    this.morningWeight,
    this.nightWeight,
    this.imageList,
    this.conditionIdList,
    this.diaryInfo,
  });

  @HiveField(0)
  DateTime createDateTime;

  @HiveField(1)
  double? morningWeight;

  @HiveField(2)
  double? nightWeight;

  @HiveField(3)
  List<Uint8List>? imageList;

  @HiveField(4)
  List<String>? conditionIdList;

  @HiveField(5)
  Map<String, dynamic>? diaryInfo;
}
