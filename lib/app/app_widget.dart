import 'package:confectionery_storie/ads/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Slidy',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
      builder: (context, widget) => Scaffold(
        body: widget,
        bottomNavigationBar: BannerAds(),
      ),
    );
  }
}