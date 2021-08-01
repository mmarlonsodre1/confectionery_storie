import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/products/product_entity.dart';
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
      await ingredientEntity.save();

      var ingredientList = _ingredientBox.values.whereType<IngredientEntity>().toList();
      ingredientList.forEach((element) async {
        if (element.hasMustIngredients == true) await _updateIngredientValue(element, ingredientEntity);
      });

      var productList = _ingredientBox.values.whereType<ProductEntity>().toList();
      productList.forEach((element) async {
        await _updateProductValue(element, ingredientEntity);
      });
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

  Future<void> _updateProductValue(ProductEntity product, IngredientEntity updatetedIngredient) async {
    var value = 0.0;
    product.ingredients?.forEach((element) {
      var amount = 0.0;
      if (element.id == updatetedIngredient.id) {
        amount = ((updatetedIngredient.amount ?? 0.0)
            / (updatetedIngredient.quantity ?? 0.0)) *
            (element.quantity ?? 0.0);

        updatetedIngredient.quantity = element.quantity;
        value += amount;
      } else value += element.amount ?? 0.0;
    });
    product.amount = value;
    product.ingredients?.removeWhere((element1) => element1.id == updatetedIngredient.id);
    if(product.ingredients == null) product.ingredients = [];
    product.ingredients?.add(updatetedIngredient);
    await product.save();
  }

  Future<void> _updateIngredientValue(IngredientEntity ingredient, IngredientEntity updatetedIngredient) async {
    var value = 0.0;
    ingredient.ingredients?.forEach((element) {
      var amount = 0.0;
      if (element.id == updatetedIngredient.id) {
        amount = ((updatetedIngredient.amount ?? 0.0)
            / (updatetedIngredient.quantity ?? 0.0)) *
            (element.quantity ?? 0.0);

        updatetedIngredient.quantity = element.quantity;
        value += amount;
      } else value += element.amount ?? 0.0;
    });
    ingredient.amount = value;
    ingredient.ingredients?.removeWhere((element1) => element1.id == updatetedIngredient.id);
    if(ingredient.ingredients == null) ingredient.ingredients = [];
    ingredient.ingredients?.add(updatetedIngredient);
    await ingredient.save();
  }
}