import 'package:confectionery_storie/app/modules/products/products_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/ingredients/ingredients_module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: HomeModule());
    r.module("/ingredients", module: IngredientsModule());
    r.module("/products", module: ProductsModule());
  }
}
