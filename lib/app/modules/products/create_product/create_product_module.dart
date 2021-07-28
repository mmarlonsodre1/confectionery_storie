import 'package:flutter_modular/flutter_modular.dart';
import 'create_product_page.dart';
import 'create_product_store.dart';
  
 class CreateProductsModule extends Module {
   @override
   final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateProductStore()),
  ];
 
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => CreateProductPage()),
  ];
 }