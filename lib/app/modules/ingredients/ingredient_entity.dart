import 'package:hive_flutter/hive_flutter.dart';

part 'ingredient_entity.g.dart';

@HiveType(typeId: 1)
class IngredientEntity extends HiveObject{
	@HiveField(0)
	String? id;

	@HiveField(1)
	String? name;

	@HiveField(2)
	int? unity;

	@HiveField(3)
	double? quantity;

	@HiveField(4)
	double? amount;

	@HiveField(5)
	bool? hasMustIngredients;

	@HiveField(6)
	List<IngredientEntity>? ingredients;

	IngredientEntity(this.name, this.unity, this.quantity, this.amount,
      this.hasMustIngredients, this.ingredients);
}