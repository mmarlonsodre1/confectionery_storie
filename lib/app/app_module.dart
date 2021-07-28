import 'package:confectionery_storie/app/modules/home/home_store.dart';
import 'package:confectionery_storie/app/modules/login/login_store.dart';
import 'package:confectionery_storie/app/modules/products/create_product/create_product_module.dart';
import 'package:confectionery_storie/app/modules/products/products_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/ingredients/ingredients_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => LoginStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute("/ingredients", module: IngredientsModule()),
    ModuleRoute("/products", module: ProductsModule()),
    ModuleRoute("/create_product", module: CreateProductsModule())
  ];
}
