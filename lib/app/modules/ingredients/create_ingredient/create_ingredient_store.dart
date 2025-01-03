import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CreateIngredientStore extends ValueNotifier<CreateIngredientEntity> {
  CreateIngredientStore() : super(CreateIngredientEntity());

  var _ingredientBox = Hive.box('box');

  void setUnity(int unity) {
    value = value.copyWith(unity: unity);
    notifyListeners();
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
      value = value.copyWith(
        name: name,
        quantity: quantity,
        amount: amount,
        hasMustIngredients: hasMustIngredients,
      );
      var ingredient = IngredientEntity(name, hasMustIngredients ? 3 : unity, quantity, amount, hasMustIngredients, null, []);
      var id = DateTime
          .now()
          .toUtc()
          .millisecondsSinceEpoch
          .toString();
      ingredient.id = id;
      _ingredientBox.put(id, ingredient);
    }
    notifyListeners();
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