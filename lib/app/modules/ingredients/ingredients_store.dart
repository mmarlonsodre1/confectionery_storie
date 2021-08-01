import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:hive/hive.dart';

class IngredientsStore extends NotifierStore<Exception, List<IngredientEntity>> with MementoMixin {
  IngredientsStore() : super([]);

  var _ingredientBox = Hive.box('box');
  IngredientEntity? _lastDeleteIngredient;

  Future<void> getIngredients() async {
    List<IngredientEntity>? ingredients = _ingredientBox.values.whereType<IngredientEntity>().toList();
    ingredients.sort((a, b) => a.name?.compareTo(b.name ?? "") ?? 0);
    update(ingredients);
  }

  Future<void> deleteIngredient(IngredientEntity? ingredient, BuildContext context) async {
    if(ingredient != null) {
      await ingredient.delete();
      var ingredientList = _ingredientBox.values.whereType<IngredientEntity>().toList();
      ingredientList.forEach((element) {
        element.ingredients?.removeWhere((element1) => element1.id == ingredient.id);
        _updateIngredientValue(element);
      });

      var productList = _ingredientBox.values.whereType<ProductEntity>().toList();
      productList.forEach((element) async {
        element.ingredients?.removeWhere((element1) => element1.id == ingredient.id);
        await _updateProductValue(element);
      });
      _lastDeleteIngredient = ingredient;
      await getIngredients();
    }
  }

  Future<void> _updateProductValue(ProductEntity product) async {
    var value = 0.0;
    product.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    product.amount = value;
    await product.save();
  }

  Future<void> _updateIngredientValue(IngredientEntity ingredient) async {
    var value = 0.0;
    ingredient.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    ingredient.amount = value;
    await ingredient.save();
  }

  @override
  Future<void> undo() async {
    super.undo();
    _ingredientBox.put(_lastDeleteIngredient?.id, _lastDeleteIngredient);
    await getIngredients();
  }
}