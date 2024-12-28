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

	double get newAmount {
		var price = 0.0;
		var finalValue = 0.0;

		var ingredientPrices = newIngredients.map((e) {
			var ingredient = Hive.box('box').values.whereType<IngredientEntity>()
					.where((item) => item.id == e.ingredientId).firstOrNull;
			return (e.quantity / (ingredient?.quantity ?? 0.0)) * (ingredient?.amount ?? 0.0);
		});

		ingredientPrices.forEach((element) => price += element);

		if(percent == 0.0) finalValue = price;
		else finalValue = price * (1 + (percent ?? 0)/100);
		return finalValue;
	}

	ProductEntity(this.name, this.amount, this.percent, this.ingredients, this.newIngredients);
}