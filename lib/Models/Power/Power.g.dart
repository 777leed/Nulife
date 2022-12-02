// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Power.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PowerAdapter extends TypeAdapter<Power> {
  @override
  final int typeId = 0;

  @override
  Power read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Power(
      fields[0] as String,
      fields[2] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Power obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.power_name)
      ..writeByte(1)
      ..write(obj.streak)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PowerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
