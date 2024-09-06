// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConditionBoxAdapter extends TypeAdapter<ConditionBox> {
  @override
  final int typeId = 3;

  @override
  ConditionBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConditionBox(
      id: fields[0] as String,
      colorName: fields[1] as String,
      text: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConditionBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.colorName)
      ..writeByte(2)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConditionBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
