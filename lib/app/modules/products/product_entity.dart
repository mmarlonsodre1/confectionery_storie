import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';

class ProductEntity{
	String? id;
	String? name;
	double? amount;
	double? percent;
	List<IngredientEntity>? ingredients;

	ProductEntity(this.name, this.amount, this.percent, this.ingredients);
}