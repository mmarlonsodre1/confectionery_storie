import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductsStore extends NotifierStore<Exception, List<ProductEntity>> {
  ProductsStore() : super([
    ProductEntity(
        "Produto 1",
        3.0,
        40.0,
        [
          IngredientEntity(
              "Ingrediente 3",
              0,
              3.0,
              1.0,
              true,
              []
          ),
        ]
    ),
    ProductEntity(
        "Produto 2",
        0,
        40.0,
        []
    )
  ]);
}