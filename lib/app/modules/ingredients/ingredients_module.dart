 import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_page.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredient_into_ingredient/ingredient_into_ingredient_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'ingredients_page.dart';
  
 class IngredientsModule extends Module {
   @override
   void routes(r) {
     r.child(Modular.initialRoute, child: (context) => IngredientsPage(isSelection: r.args.data ?? false));
     r.child("/create_ingredient", child: (context) => CreateIngredientPage(ingredient: r.args.data));
     r.child("/ingredient_into_ingredient", child: (context) => IngredientIntoIngredientPage(ingredient: r.args.data));
   }
 }