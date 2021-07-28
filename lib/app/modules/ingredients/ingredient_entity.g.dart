// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientEntityAdapter extends TypeAdapter<IngredientEntity> {
  @override
  final int typeId = 1;

  @override
  IngredientEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientEntity(
      fields[1] as String?,
      fields[2] as int?,
      fields[3] as double?,
      fields[4] as double?,
      fields[5] as bool?,
      (fields[6] as List?)?.cast<IngredientEntity>(),
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, IngredientEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.unity)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.hasMustIngredients)
      ..writeByte(6)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
