import 'package:flutter_modular/flutter_modular.dart';
import 'create_ingredient_page.dart';
import 'create_ingredient_store.dart';
  
 class CreateIngredientModule extends Module {
   @override
   final List<Bind> binds = [
  Bind.lazySingleton((i) => CreateIngredientStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => CreateIngredientPage()),
  ];
 }