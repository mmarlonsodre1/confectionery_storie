import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CreateIngredientStore extends NotifierStore<Exception, CreateIngredientEntity> {
  CreateIngredientStore() : super(CreateIngredientEntity());

  Future<void> setUnity(int unity) async {
    update(CreateIngredientEntity()..unity = unity);
  }

  Future<void> postIngredient(String name, double quantity, double amount) async {
    state.name = name;
    state.quantity = quantity;
    state.amount = amount;
    update(state);
  }
}