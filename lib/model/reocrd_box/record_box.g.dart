// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordBoxAdapter extends TypeAdapter<RecordBox> {
  @override
  final int typeId = 2;

  @override
  RecordBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordBox(
      createDateTime: fields[0] as DateTime,
      morningWeight: fields[1] as double?,
      nightWeight: fields[2] as double?,
      imageList: (fields[3] as List?)?.cast<Uint8List>(),
      conditionIdList: (fields[4] as List?)?.cast<String>(),
      diaryInfo: (fields[5] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecordBox obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.createDateTime)
      ..writeByte(1)
      ..write(obj.morningWeight)
      ..writeByte(2)
      ..write(obj.nightWeight)
      ..writeByte(3)
      ..write(obj.imageList)
      ..writeByte(4)
      ..write(obj.conditionIdList)
      ..writeByte(5)
      ..write(obj.diaryInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
