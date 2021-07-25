import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_entity.dart';

createIngredientModelEntityFromJson(CreateIngredientEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['unity'] != null) {
		data.unity = json['unity'].toInt();
	}
	if (json['quantity'] != null) {
		data.quantity = json['quantity'] is String
				? double.tryParse(json['quantity'])
				: json['quantity'].toDouble();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? double.tryParse(json['amount'])
				: json['amount'].toDouble();
	}
	if (json['hasMustIngredients'] != null) {
		data.unity = json['hasMustIngredients'].toBool();
	}
	return data;
}

Map<String, dynamic> createIngredientModelEntityToJson(CreateIngredientEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['unity'] = entity.unity;
	data['quantity'] = entity.quantity;
	data['amount'] = entity.amount;
	data['hasMustIngredients'] = entity.hasMustIngredients;
	return data;
}