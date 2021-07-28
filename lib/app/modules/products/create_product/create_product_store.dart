import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:hive/hive.dart';

class CreateProductStore extends NotifierStore<Exception, ProductEntity> with MementoMixin{
  CreateProductStore() : super(ProductEntity(null, null, null, []));

  var _productBox = Hive.box('box');
  String? _productId;
  IngredientEntity? _lastDeleteIngredient;
  ProductEntity? _productEntity;

  Future<void> getProduct(String id) async {
    _productId = id;
    _productEntity = _productBox.values.whereType<ProductEntity>()
        .where((item) => item.id == id).first;
    update(_productEntity ?? ProductEntity(null, null, null, []));
  }


  Future<void> setProduct(ProductEntity product) async {
    if (product.name != null
        && product.name?.trim() != ""
        && product.percent != null
        && product.ingredients != null
    ) {
      this.state.name = product.name;
      this.state.percent = product.percent;
      this.state.ingredients = product.ingredients;
      this.state.amount = product.amount;

      if (product.id == null) {
        var id = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
        this.state.id = id;
        _productBox.put(id, this.state);
      } else this.state.save();
      update(this.state);
    }
  }

  Future<void> updateName(String name) async {
    var newState = this.state;
    newState.name = name;
    setProduct(newState);
  }

  Future<void> updatePercent(double percent, double? ingredientsValue) async {
    var newState = this.state;
    var value = 0.0;

    newState.percent = percent;
    if(ingredientsValue != null) {
      value = ingredientsValue;
    } else {
      newState.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    }
    if(percent == 0.0) newState.amount = value;
    else newState.amount = value * (1 + (newState.percent ?? 0)/100);
    setProduct(newState);
  }

  Future<void> addIngredient(IngredientEntity ingredient) async {
    var newState = this.state;
    if (newState.ingredients == null) newState.ingredients = [];
    newState.ingredients?.add(ingredient);
    _updateValue(newState.ingredients);
  }

  Future<void> _updateValue(List<IngredientEntity>? ingredients) async {
    var newState = this.state;
    var value = 0.0;
    newState.ingredients = ingredients;
    newState.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    newState.amount = value;
    updatePercent(newState.percent ?? 0.0, newState.amount);
  }

  Future<void> deleteIngredient(IngredientEntity? ingredient, BuildContext context) async {
    if(ingredient != null) {
      _productEntity?.ingredients?.remove(ingredient);
      await _productEntity?.save();
      await _updateValue(_productEntity?.ingredients);
      _lastDeleteIngredient = ingredient;
      await getProduct(_productId ?? "");
    }
  }

  @override
  Future<void> undo() async {
    if (_lastDeleteIngredient != null) {
      _productEntity?.ingredients?.add(_lastDeleteIngredient!);
      await _productEntity?.save();
      await _updateValue(_productEntity?.ingredients);
    }
  }
}