 import 'package:flutter_modular/flutter_modular.dart';
 import '../products/products_store.dart';
 
 import 'products_page.dart';
  
 class ProductsModule extends Module {
   @override
   final List<Bind> binds = [
  Bind.lazySingleton((i) => ProductsStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ProductsPage()),
  ];
 }