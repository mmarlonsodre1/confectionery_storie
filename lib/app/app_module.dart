import 'package:confectionery_storie/app/modules/home/home_store.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredients_store.dart';
import 'package:confectionery_storie/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/ingredients/ingredients_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => IngredientsStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute("/ingredients", module: IngredientsModule())
  ];
}
