// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_into_addiction_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientIntoAddictionEntityAdapter
    extends TypeAdapter<IngredientIntoAddictionEntity> {
  @override
  final int typeId = 2;

  @override
  IngredientIntoAddictionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientIntoAddictionEntity(
      id: fields[0] as String,
      ingredientId: fields[1] as String,
      quantity: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientIntoAddictionEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ingredientId)
      ..writeByte(2)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientIntoAddictionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
