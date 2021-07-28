import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CreateProductStore extends NotifierStore<Exception, ProductEntity> {
  CreateProductStore() : super(ProductEntity(null, null, null, []));

  Future<void> setProduct(ProductEntity product) async {
    if (product.name != null
        && product.percent != null
        && product.ingredients != null
    ) {
      if (product.id != null) {
        print("salvar produto");
      } else {
        print("editar produto");
      }
    }
  }

  Future<void> updateName(String name) async {
    var newState = this.state;
    newState.name = name;
    update(newState);
    setProduct(newState);
  }

  Future<void> updatePercent(double percent) async {
    var newState = this.state;
    var value = 0.0;

    newState.percent = percent;
    newState.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    if(percent == 0.0)
      newState.amount = value;
    else newState.amount = value * (1 + (newState.percent ?? 0)/100);
    update(newState);
    setProduct(newState);
  }

  Future<void> addIngredient(IngredientEntity ingredient) async {
    var newState = this.state;
    var value = 0.0;

    newState.ingredients?.add(ingredient);
    newState.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    newState.amount = value;
    update(newState);
    updatePercent(newState.percent ?? 0.0);
  }
}