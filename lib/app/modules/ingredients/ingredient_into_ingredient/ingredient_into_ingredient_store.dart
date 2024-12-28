import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IngredientIntoIngredientStore extends ValueNotifier<IngredientEntity> {
  IngredientIntoIngredientStore() : super(IngredientEntity(null, null, null, null, null, null, []));

  var _nullIngredient = IngredientEntity(null, null, null, null, null, null, []);
  var _box = Hive.box('box');
  String? _ingredientId;
  IngredientIntoAddictionEntity? _lastDeleteIngredient;
  IngredientEntity? ingredientEntity;

  Future<void> getIngredient(String id) async {
    _ingredientId = id;
    ingredientEntity = _box.values.whereType<IngredientEntity>()
        .where((item) => item.id == id).first;
    value = ingredientEntity ?? _nullIngredient;
    notifyListeners();
  }

  IngredientEntity getIngredientIntoIngredient(String id) => _box.values
      .whereType<IngredientEntity>()
      .where((item) => item.id == id).first;

  Future<void> setIngredient() async {
    if (value.name != null && value.name?.trim() != "") {
      if (value.id == null) {
        var id = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
        value.id = id;
        _box.put(id, value);
      } else {
        await value.save();
      }
    }
    await getIngredient(_ingredientId ?? "");
  }

  void updateName(String name) {
    value.name = name;
    setIngredient();
  }

  Future<void> addIngredient(IngredientEntity ingredient, BuildContext context) async {
    if (ingredient.id == (_ingredientId ?? "")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Impossível adicionar ingrediente dentro dele mesmo'),
        ),
      );
    } else {
      var id = DateTime
          .now()
          .toUtc()
          .millisecondsSinceEpoch
          .toString();

      ingredientEntity?.newIngredients.add(
        IngredientIntoAddictionEntity(
            id: id,
            ingredientId: ingredient.id ?? '',
            quantity: ingredient.quantity ?? 0.0,
        ),
      );
      setIngredient();
    }
  }

  Future<void> deleteIngredient(IngredientIntoAddictionEntity? ingredient, BuildContext context) async {
    if(ingredient != null) {
      ingredientEntity?.newIngredients.remove(ingredient);
      await ingredientEntity?.save();
      _lastDeleteIngredient = ingredient;
      getIngredient(_ingredientId!);
    }
  }

  Future<void> undo() async {
    if (_lastDeleteIngredient != null) {
      ingredientEntity?.newIngredients.add(_lastDeleteIngredient!);
      await ingredientEntity?.save();
      getIngredient(_ingredientId!);
    }
  }
}