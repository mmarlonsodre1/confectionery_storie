import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:hive/hive.dart';

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

	@HiveField(7, defaultValue: [])
	List<IngredientIntoAddictionEntity> newIngredients;

	double get newAmount {
		var finalValue = 0.0;
		var ingredientPrices = newIngredients.map((e) {
			var ingredient = Hive.box('box').values.whereType<IngredientEntity>()
					.where((item) => item.id == e.ingredientId).firstOrNull;
			return (e.quantity / (ingredient?.quantity ?? 0.0)) * (ingredient?.amount ?? 0.0);
		});

		ingredientPrices.forEach((element) => finalValue += element);
		return finalValue;
	}

	IngredientEntity(this.name, this.unity, this.quantity, this.amount,
      this.hasMustIngredients, this.ingredients, this.newIngredients);
}
