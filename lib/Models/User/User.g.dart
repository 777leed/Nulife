// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[4] as String,
    )
      ..xp = fields[5] as int?
      ..PowerPuffs = (fields[6] as List?)?.cast<Power>();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(3)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.xp)
      ..writeByte(6)
      ..write(obj.PowerPuffs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
