import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProductsStore extends ValueNotifier<List<ProductEntity>> {
  ProductsStore() : super([]);

  var _box = Hive.box('box');
  ProductEntity? _lastDeleteProduct;
  
  Future<void> getProducts() async {
    List<ProductEntity>? products = _box.values.whereType<ProductEntity>().toList();
    products.sort((a, b) => a.name?.compareTo(b.name ?? "") ?? 0);

    for (var e in products) {
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

    value = products;
    notifyListeners();
  }

  Future<void> deleteProduct(ProductEntity? product, BuildContext context) async {
    if (product != null) {
      await product.delete();
      _lastDeleteProduct = product;
      await getProducts();
    }
  }

  Future<void> undo() async {
    await _box.put(_lastDeleteProduct?.id, _lastDeleteProduct);
    await getProducts();
  }
}