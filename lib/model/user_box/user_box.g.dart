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
      fontFamily: fields[4] as String,
      calendarMaker: fields[2] as String,
      theme: fields[3] as String,
      fontSize: fields[5] as double,
      background: fields[6] as int,
      weightUnit: fields[7] as String,
      categoryOpenIdList: (fields[8] as List).cast<String>(),
      googleDriveInfo: (fields[9] as Map?)?.cast<String, dynamic>(),
      alarmInfo: (fields[10] as Map?)?.cast<String, dynamic>(),
      goalInfo: (fields[11] as Map?)?.cast<String, dynamic>(),
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
      ..write(obj.calendarMaker)
      ..writeByte(3)
      ..write(obj.theme)
      ..writeByte(4)
      ..write(obj.fontFamily)
      ..writeByte(5)
      ..write(obj.fontSize)
      ..writeByte(6)
      ..write(obj.background)
      ..writeByte(7)
      ..write(obj.weightUnit)
      ..writeByte(8)
      ..write(obj.categoryOpenIdList)
      ..writeByte(9)
      ..write(obj.googleDriveInfo)
      ..writeByte(10)
      ..write(obj.alarmInfo)
      ..writeByte(11)
      ..write(obj.goalInfo)
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
