 import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_page.dart';
import 'package:confectionery_storie/app/modules/ingredients/create_ingredient/create_ingredient_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
 import '../ingredients/ingredients_store.dart';
 
 import 'ingredients_page.dart';
  
 class IngredientsModule extends Module {
   @override
   final List<Bind> binds = [
    Bind.lazySingleton((i) => IngredientsStore()),
     Bind.lazySingleton((i) => CreateIngredientStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => IngredientsPage()),
    ChildRoute("/create_ingredient", child: (_, args) => CreateIngredientPage()),
  ];
 }