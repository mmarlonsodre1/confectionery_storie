import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CreateProductStore extends ValueNotifier<ProductEntity> {
  CreateProductStore() : super(ProductEntity(null, null, null, [], []));

  var _box = Hive.box('box');
  String? _productId;
  IngredientIntoAddictionEntity? _lastDeleteIngredient;
  ProductEntity? _productEntity;

  Future<void> getProduct(String id) async {
    _productId = id;
    _productEntity = _box.values.whereType<ProductEntity>()
        .where((item) => item.id == id).first;

    value = _productEntity ?? ProductEntity(null, null, null, [], []);
    notifyListeners();

    updatePercent(_productEntity!.percent ?? 0.0);
  }

  Future<void> setProduct() async {
    if (value.name != null
        && value.name?.trim() != ""
        && value.percent != null
        && value.newIngredients.isNotEmpty
    ) {
      if (value.id == null) {
        var id = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
        value.id = id;
        _box.put(id, value);
      } else {
        value.save();
      }
    }
    notifyListeners();
  }

  Future<void> updateName(String name) async {
    value.name = name;
    setProduct();
  }

  Future<void> updatePercent(double percent) async {
    value.percent = percent;
    setProduct();
  }

  IngredientEntity getIngredient(String id) => _box.values.whereType<IngredientEntity>()
        .where((item) => item.id == id).first;

  Future<void> addIngredient(IngredientEntity ingredient) async {
    var id = DateTime
        .now()
        .toUtc()
        .millisecondsSinceEpoch
        .toString();

    value.newIngredients.add(
      IngredientIntoAddictionEntity(
        id: id,
        ingredientId: ingredient.id ?? '',
        quantity: ingredient.quantity ?? 0.0,
      ),
    );
    setProduct();
  }

  Future<void> deleteIngredient(IngredientIntoAddictionEntity? ingredient, BuildContext context) async {
    if(ingredient != null) {
      _productEntity?.newIngredients.remove(ingredient);
      await _productEntity?.save();
      _lastDeleteIngredient = ingredient;
      await getProduct(_productId ?? "");
    }
  }

  Future<void> undo() async {
    if (_lastDeleteIngredient != null) {
      _productEntity?.newIngredients.add(_lastDeleteIngredient!);
      await _productEntity?.save();
      await getProduct(_productId ?? "");
    }
  }
}