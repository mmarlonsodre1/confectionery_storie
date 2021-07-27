 import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_page.dart';
import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_store.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredient_into_ingredient/ingredient_into_ingredient_page.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredient_into_ingredient/ingredient_into_ingredient_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
 import '../ingredients/ingredients_store.dart';
 
 import 'ingredients_page.dart';
  
 class IngredientsModule extends Module {
   @override
   final List<Bind> binds = [
     Bind.lazySingleton((i) => IngredientsStore()),
     Bind.lazySingleton((i) => CreateIngredientStore()),
     Bind.lazySingleton((i) => IngredientIntoIngredientStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute("/ingredients", child: (_, args) => IngredientsPage(isSelection: args.data ?? false,)),
    ChildRoute("/create_ingredient", child: (_, args) => CreateIngredientPage(ingredient: args.data,)),
    ChildRoute("/ingredient_into_ingredient", child: (_, args) => IngredientIntoIngredientPage(ingredient: args.data)),
  ];
 }