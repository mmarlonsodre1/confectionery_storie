 import 'package:flutter_modular/flutter_modular.dart';
 import '../ingredients/ingredients_store.dart';
 
 import 'ingredients_page.dart';
  
 class IngredientsModule extends Module {
   @override
   final List<Bind> binds = [
  Bind.lazySingleton((i) => IngredientsStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => IngredientsPage()),
  ];
 }