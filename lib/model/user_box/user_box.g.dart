// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBoxAdapter extends TypeAdapter<UserBox> {
  @override
  final int typeId = 1;

  @override
  UserBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBox(
      id: fields[0] as String,
      createDateTime: fields[1] as DateTime,
      fontFamily: fields[3] as String,
      theme: fields[2] as String,
      fontSize: fields[4] as double,
      background: fields[5] as int,
      weightUnit: fields[6] as String,
      categoryOpenIdList: (fields[7] as List).cast<String>(),
      conditionOrderIdList: (fields[8] as List).cast<String>(),
      goalInfo: (fields[9] as Map).cast<String, dynamic>(),
      googleDriveInfo: (fields[10] as Map?)?.cast<String, dynamic>(),
      alarmInfo: (fields[11] as Map?)?.cast<String, dynamic>(),
      passwords: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createDateTime)
      ..writeByte(2)
      ..write(obj.theme)
      ..writeByte(3)
      ..write(obj.fontFamily)
      ..writeByte(4)
      ..write(obj.fontSize)
      ..writeByte(5)
      ..write(obj.background)
      ..writeByte(6)
      ..write(obj.weightUnit)
      ..writeByte(7)
      ..write(obj.categoryOpenIdList)
      ..writeByte(8)
      ..write(obj.conditionOrderIdList)
      ..writeByte(9)
      ..write(obj.goalInfo)
      ..writeByte(10)
      ..write(obj.googleDriveInfo)
      ..writeByte(11)
      ..write(obj.alarmInfo)
      ..writeByte(12)
      ..write(obj.passwords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
