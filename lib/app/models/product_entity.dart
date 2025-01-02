import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity extends HiveObject{
	@HiveField(0)
	String? id;

	@HiveField(1)
	String? name;

	@HiveField(2)
	double? amount;

	@HiveField(3)
	double? percent;

	@HiveField(4)
	List<IngredientEntity>? ingredients;

	@HiveField(5, defaultValue: [])
	List<IngredientIntoAddictionEntity> newIngredients;

	double get cost {
		var finalValue = 0.0;

		var ingredientPrices = newIngredients.map((e) {
			var ingredient = Hive.box('box').values.whereType<IngredientEntity>()
					.where((item) => item.id == e.ingredientId).firstOrNull;
			var hasMustIngredients = ingredient?.hasMustIngredients == true;
			var amount = hasMustIngredients ? ingredient?.newAmount : ingredient?.amount;

			if (hasMustIngredients) {
				return e.quantity * (amount ?? 0.0);
			}
			return (e.quantity / (ingredient?.quantity ?? 0.0)) * (amount ?? 0.0);
		});

		ingredientPrices.forEach((element) => finalValue += element);
		return finalValue;
	}

	double get newAmount => percent == 0.0
			? cost : cost * (1 + (percent ?? 0)/100);

	ProductEntity(this.name, this.amount, this.percent, this.ingredients, this.newIngredients);
}