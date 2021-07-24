import 'package:confectionery_storie/app/components/simple_product_widget.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'products_store.dart';

class ProductsPage extends StatefulWidget {
  final String title;
  const ProductsPage({this.title = "Products"}) : super();

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends ModularState<ProductsPage, ProductsStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Produtos',
          style: textTitle2
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: primaryColor,
        elevation: 8,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
          size: 24,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    SimpleProductWidget(
                      title: 'Produto1',
                    ),
                    SimpleProductWidget(
                      title: 'Produto2',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}