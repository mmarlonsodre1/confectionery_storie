import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';

class IngredientsStore extends NotifierStore<Exception, List<IngredientEntity>> {
  IngredientsStore() : super([
    IngredientEntity(
      "Ingrediente 1",
      0,
      1.0,
      1.0,
      true,
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
    IngredientEntity(
        "Ingrediente 2",
        0,
        2.0,
        1.0,
        false,
        []
    )
  ]);
}