import 'package:hive/hive.dart';

part 'ingredient_into_addiction_entity.g.dart';

@HiveType(typeId: 2)
class IngredientIntoAddictionEntity extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String ingredientId;

  @HiveField(2)
  late double quantity;

  IngredientIntoAddictionEntity({required this.id, required this.ingredientId, required this.quantity});

}