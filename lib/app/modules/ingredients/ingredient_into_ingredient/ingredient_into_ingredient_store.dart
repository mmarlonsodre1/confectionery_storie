import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';

class IngredientIntoIngredientStore extends NotifierStore<Exception, IngredientEntity> {
  IngredientIntoIngredientStore() : super(IngredientEntity(null, null, null, null, null, null));

  Future<void> setIngredient(IngredientEntity ingredient) async {
    update(ingredient);
  }

  Future<void> addIngredient(IngredientEntity ingredient) async {
    var newState = this.state;
    var value = 0.0;
    newState.ingredients?.add(ingredient);
    newState.ingredients?.forEach((element) {value += element.amount ?? 0.0;});
    newState.amount = value;
    update(newState);
  }
}