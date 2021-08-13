// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeactionAdapter extends TypeAdapter<Timeaction> {
  @override
  final int typeId = 0;

  @override
  Timeaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timeaction()
      ..work = fields[0] as String
      ..todayDate = fields[1] as DateTime
      ..groupwork = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Timeaction obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.work)
      ..writeByte(1)
      ..write(obj.todayDate)
      ..writeByte(2)
      ..write(obj.groupwork);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
