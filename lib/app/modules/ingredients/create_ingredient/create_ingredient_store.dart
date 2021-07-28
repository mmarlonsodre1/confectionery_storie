import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:hive/hive.dart';

class CreateIngredientStore extends NotifierStore<Exception, CreateIngredientEntity> {
  CreateIngredientStore() : super(CreateIngredientEntity());

  var _ingredientBox = Hive.box('box');

  Future<void> setUnity(int unity) async {
    update(CreateIngredientEntity()..unity = unity);
  }

  Future<void> postIngredient(String name, int unity, double quantity,
      double amount, bool hasMustIngredients, IngredientEntity? ingredientEntity) async {
    if (ingredientEntity != null) {
      ingredientEntity.name = name;
      ingredientEntity.quantity = quantity;
      ingredientEntity.amount = amount;
      ingredientEntity.hasMustIngredients = hasMustIngredients;
      ingredientEntity.unity = hasMustIngredients ? 3 : unity;
      ingredientEntity.save();
    } else {
      state.name = name;
      state.quantity = quantity;
      state.amount = amount;
      state.hasMustIngredients = hasMustIngredients;
      var ingredient = IngredientEntity(name, hasMustIngredients ? 3 : unity, quantity, amount, hasMustIngredients, null);
      var id = DateTime
          .now()
          .toUtc()
          .millisecondsSinceEpoch
          .toString();
      ingredient.id = id;
      _ingredientBox.put(id, ingredient);
    }
    update(state);
  }
}