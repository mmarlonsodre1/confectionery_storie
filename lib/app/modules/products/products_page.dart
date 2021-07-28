import 'package:confectionery_storie/app/components/simple_product_widget.dart';
import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
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
  void initState() {
    super.initState();
    store.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    List<SimpleProductWidget> _products(List<ProductEntity> items) {
      return items.map((product) =>
          SimpleProductWidget(
            product: product,
            onTap: (item) async {
                await Modular.to.pushNamed("create_product", arguments: item);
                store.getProducts();
            },
            onDeleteAction: (item) async {
              await store.deleteProduct(item, context);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} apagado(a)'),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'Voltar ação',
                    onPressed: () async {
                      await store.undo();
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          )).toList();
    }

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
        onPressed: () async {
          await Modular.to.pushNamed("/create_product");
          await store.getProducts();
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
                child: ScopedBuilder<ProductsStore, Exception, List<ProductEntity>>(
                    store: store,
                    onState: (_, data) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        children: _products(data),
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}