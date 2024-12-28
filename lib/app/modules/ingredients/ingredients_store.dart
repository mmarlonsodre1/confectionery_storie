import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IngredientsStore extends ValueNotifier<List<IngredientEntity>> {
  IngredientsStore() : super([]);

  var _box = Hive.box('box');
  IngredientEntity? _lastDeleteIngredient;

  Future<void> getIngredients() async {
    List<IngredientEntity>? ingredients = _box.values.whereType<IngredientEntity>().toList();
    ingredients.sort((a, b) => a.name?.compareTo(b.name ?? "") ?? 0);

    for (var e in ingredients) {
      if (e.ingredients?.isNotEmpty == true && e.newIngredients.isEmpty == true) {
        for (var ingredient in e.ingredients!) {
          var id = DateTime
              .now()
              .toUtc()
              .millisecondsSinceEpoch
              .toString();

          e.newIngredients.add(
            IngredientIntoAddictionEntity(
              id: id,
              ingredientId: ingredient.id ?? '',
              quantity: ingredient.quantity ?? 0.0,
            ),
          );
          await Future.delayed(Duration(milliseconds: 1));
        }
        e.ingredients = [];
      }

      var excludeIngredientList = [];
      for (var ingredient in e.newIngredients) {
        var auxIngredient = _box.values.whereType<IngredientEntity>()
            .where((item) => item.id == ingredient.ingredientId).firstOrNull;
        if (auxIngredient == null) {
          excludeIngredientList.add(ingredient.id);
        }
      }
      e.newIngredients.removeWhere((i) => excludeIngredientList.contains(i));
      e.save();
    }

    value = ingredients;
    notifyListeners();
  }

  Future<void> deleteIngredient(IngredientEntity? ingredient, BuildContext context) async {
    if(ingredient != null) {
      await ingredient.delete();
      var ingredientList = _box.values.whereType<IngredientEntity>().toList();
      ingredientList.forEach((element) {
        element.newIngredients.removeWhere((intoIngredient) =>
          intoIngredient.ingredientId == ingredient.id);
      });

      var productList = _box.values.whereType<ProductEntity>().toList();
      productList.forEach((element) {
        element.newIngredients.removeWhere((intoIngredient) =>
        intoIngredient.ingredientId == ingredient.id);
      });
      _lastDeleteIngredient = ingredient;
      await getIngredients();
    }
  }

  Future<void> undo() async {
    _box.put(_lastDeleteIngredient?.id, _lastDeleteIngredient);
    await getIngredients();
  }
}