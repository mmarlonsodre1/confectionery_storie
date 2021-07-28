import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:hive/hive.dart';

class IngredientIntoIngredientStore extends NotifierStore<Exception, IngredientEntity> with MementoMixin{
  IngredientIntoIngredientStore() : super(IngredientEntity(null, null, null, null, null, null));

  var _nullIngredient = IngredientEntity(null, null, null, null, null, null);
  var _ingredientBox = Hive.box('box');
  String? _ingredientId;
  IngredientEntity? _lastDeleteIngredient;
  IngredientEntity? ingredientEntity;

  Future<void> getIngredient(String id) async {
    _ingredientId = id;
    ingredientEntity = _ingredientBox.values.whereType<IngredientEntity>()
        .where((item) => item.id == id).first;
    update(ingredientEntity ?? _nullIngredient, force: true);
  }

  Future<void> setIngredient(IngredientEntity ingredient) async {
    if (ingredient.name != null && ingredient.name?.trim() != "") {
      state.name = ingredient.name;
      state.unity = ingredient.unity;
      state.quantity = ingredient.quantity;
      state.hasMustIngredients = ingredient.hasMustIngredients;
      state.ingredients = ingredient.ingredients;
      state.amount = ingredient.amount;

      if (ingredient.id == null) {
        var id = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
        state.id = id;
        _ingredientBox.put(id, this.state);
      } else await state.save();
    }
    await getIngredient(_ingredientId ?? "");
  }

  Future<void> updateName(String name) async {
    var newState = this.state;
    newState.name = name;
    setIngredient(newState);
  }

  Future<void> addIngredient(IngredientEntity ingredient, BuildContext context) async {
    if (ingredient.id == (_ingredientId ?? "")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Impossível adicionar ingrediente dentro dele mesmo'),
        ),
      );
    } else {
      if (ingredientEntity?.ingredients == null) ingredientEntity?.ingredients = [];
      ingredientEntity?.ingredients?.add(ingredient);
      await ingredientEntity?.save();
      await _updateValue(ingredientEntity?.ingredients);
    }
  }

  Future<void> _updateValue(List<IngredientEntity>? ingredients) async {
    var newState = this.state;
    var value = 0.0;
    newState.ingredients = ingredients;
    newState.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    newState.amount = value;
    await setIngredient(newState);
  }

  Future<void> deleteIngredient(IngredientEntity? ingredient, BuildContext context) async {
    if(ingredient != null) {
      ingredientEntity?.ingredients?.remove(ingredient);
      await ingredientEntity?.save();
      _lastDeleteIngredient = ingredient;
      await _updateValue(ingredientEntity?.ingredients);
    }
  }

  @override
  Future<void> undo() async {
    if (_lastDeleteIngredient != null) {
      ingredientEntity?.ingredients?.add(_lastDeleteIngredient!);
      await ingredientEntity?.save();
      await _updateValue(ingredientEntity?.ingredients);
    }
  }
}