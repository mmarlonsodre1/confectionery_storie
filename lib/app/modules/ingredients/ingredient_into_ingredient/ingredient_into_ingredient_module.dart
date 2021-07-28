import 'package:confectionery_storie/app/modules/ingredients/ingredient_into_ingredient/ingredient_into_ingredient_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
 
 import 'ingredient_into_ingredient_page.dart';
  
 class IngredientIntoIngredientModule extends Module {
   @override
   final List<Bind> binds = [
    Bind.lazySingleton((i) => IngredientIntoIngredientStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute("/ingredient_into_ingredient", child: (_, args) => IngredientIntoIngredientPage(ingredient: args.data)),
  ];
 }