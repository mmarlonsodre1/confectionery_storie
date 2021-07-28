import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity  extends HiveObject{
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

	ProductEntity(this.name, this.amount, this.percent, this.ingredients);
}