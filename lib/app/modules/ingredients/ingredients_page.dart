import 'package:confectionery_storie/app/components/simple_product_widget.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ingredients_store.dart';

class IngredientsPage extends StatefulWidget {
  final String title;
  const IngredientsPage({Key key, this.title = "Ingredientes"}) : super(key: key);

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends ModularState<IngredientsPage, IngredientsStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Ingredientes',
          style: textTitle2,
        ),
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
          color: white,
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
                      title: 'Ingrediente 1 asda  asdas asd ad a ad asdasdasd a a a ds \na dasdadasdada \n asdasdasd',
                      onTap: () {},
                    ),
                    SimpleProductWidget(
                      title: 'Ingrediente 2',
                      onTap: () {},
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