import 'package:confectionery_storie/app/components/simple_product_widget.dart';
import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'products_store.dart';

class ProductsPage extends StatefulWidget {
  final String title;
  const ProductsPage({this.title = "Products"}) : super();

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsStore _store = ProductsStore();
  late List<ProductEntity> _state;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _store.getProducts();
    });
  }

  List<SimpleProductWidget> _products(List<ProductEntity> items) {
    return items.map((product) =>
        SimpleProductWidget(
          product: product,
          onTap: (item) async {
            await Modular.to.pushNamed("create_product", arguments: item);
            _store.getProducts();
          },
          onDeleteAction: (item) async {
            await _store.deleteProduct(item, context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} apagado(a)'),
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Voltar ação',
                  onPressed: () => _store.undo(),
                ),
              ),
            );
          },
        )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _store,
      builder: (context, widget) {
        _state = _store.value;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: true,
            title: Text(
              'Produtos',
              style: textTitle2.copyWith(color: Colors.white)
            ),
            actions: [],
            centerTitle: true,
            elevation: 4,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Modular.to.pushNamed("/products/create_product");
              _store.getProducts();
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
                      children: _products(_state),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}