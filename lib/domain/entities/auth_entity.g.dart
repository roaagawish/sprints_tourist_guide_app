// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationEntityAdapter extends TypeAdapter<AuthenticationEntity> {
  @override
  final int typeId = 0;

  @override
  AuthenticationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticationEntity(
      uid: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      phone: fields[3] as String?,
      photo: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticationEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
