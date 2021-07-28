import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IngredientsStore extends NotifierStore<Exception, List<IngredientEntity>> with MementoMixin {
  IngredientsStore() : super([]);

  var _ingredientBox = Hive.box('ingredient');
  IngredientEntity? _lastDeleteIngredient;

  Future<void> getIngredients() async {
    List<IngredientEntity>? ingredients = _ingredientBox.values.cast<IngredientEntity>().toList();
    ingredients.sort((a, b) => a.name?.compareTo(b.name ?? "") ?? 0);
    update(ingredients);
  }

  Future<void> deleteIngredient(IngredientEntity? ingredient, BuildContext context) async {
    if(ingredient != null) {
      await ingredient.delete();
      _lastDeleteIngredient = ingredient;
      await getIngredients();
    }
  }

  @override
  Future<void> undo() async {
    super.undo();
    _ingredientBox.put(_lastDeleteIngredient?.id, _lastDeleteIngredient);
    await getIngredients();
  }
}