import 'package:confectionery_storie/app/modules/products/create_product/create_product_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'products_page.dart';
  
 class ProductsModule extends Module {
   @override
   void routes(r) {
     r.child(Modular.initialRoute, child: (context) => ProductsPage());
     r.child("/create_product", child: (context) => CreateProductPage(product: r.args.data));
   }
 }