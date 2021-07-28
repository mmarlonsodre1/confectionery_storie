import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductsStore extends NotifierStore<Exception, List<ProductEntity>> with MementoMixin {
  ProductsStore() : super([]);
  var _productBox = Hive.box('product');
  ProductEntity? _lastDeleteProduct;
  
  Future<void> getProducts() async {
    List<ProductEntity>? products = _productBox.values.cast<ProductEntity>().toList();
    products.sort((a, b) => a.name?.compareTo(b.name ?? "") ?? 0);
    update(products);
  }

  Future<void> deleteProduct(ProductEntity? product, BuildContext context) async {
    if (product != null) {
      await product.delete();
      _lastDeleteProduct = product;
      await getProducts();
    }
  }

  @override
  Future<void> undo() async {
    super.undo();
    await _productBox.put(_lastDeleteProduct?.id, _lastDeleteProduct);
    await getProducts();
  }
}