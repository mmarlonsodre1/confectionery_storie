import 'package:confectionery_storie/app/modules/ingredients/ingredients_page.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredients_store.dart';
import 'package:confectionery_storie/app/modules/products/create_product/create_product_page.dart';
import 'package:confectionery_storie/app/modules/products/create_product/create_product_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../products/products_store.dart';
 
 import 'products_page.dart';
  
 class ProductsModule extends Module {
   @override
   final List<Bind> binds = [
     Bind.lazySingleton((i) => ProductsStore()),
     Bind.lazySingleton((i) => CreateProductStore()),
     Bind.lazySingleton((i) => IngredientsStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ProductsPage()),
    ChildRoute("/create_product", child: (_, args) => CreateProductPage(product: args.data,)),
    ChildRoute("/ingredients", child: (_, args) => IngredientsPage(isSelection: args.data ?? false,)),
  ];
 }