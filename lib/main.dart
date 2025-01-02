import 'dart:convert';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:confectionery_storie/ads/ads_util.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/models/ingredient_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppTrackingTransparency.requestTrackingAuthorization();
  initCasAiAds();

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
  Hive.registerAdapter(IngredientIntoAddictionEntityAdapter());
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(IngredientEntityAdapter());
  await Hive.openBox('box', encryptionCipher: HiveAesCipher(encryptionKey));

  runApp(
      ModularApp(module: AppModule(), child: AppWidget())
  );
}