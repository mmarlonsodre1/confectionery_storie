import 'package:confectionery_storie/generated/json/base/json_convert_content.dart';

class CreateIngredientEntity with JsonConvert<CreateIngredientEntity> {
	String? name;
	int unity = 0;
	double? quantity;
	double? amount;
	bool hasMustIngredients = false;
	bool isSuccess = false;
}
