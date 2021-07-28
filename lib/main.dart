import 'dart:convert';

import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/modules/ingredients/ingredient_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Chave de criptografia
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  if (!containsEncryptionKey) {
  var key = Hive.generateSecureKey();
  await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }
  var key = await secureStorage.read(key: 'key');
  var encryptionKey = base64Url.decode(key ?? "key");

  //Hive
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(IngredientEntityAdapter());
  await Hive.openBox('product', encryptionCipher: HiveAesCipher(encryptionKey));
  await Hive.openBox('ingredient', encryptionCipher: HiveAesCipher(encryptionKey));

  runApp(
      ModularApp(module: AppModule(), child: AppWidget())
  );
}