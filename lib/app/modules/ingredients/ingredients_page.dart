import 'package:confectionery_storie/app/components/simple_product_widget.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ingredient_entity.dart';
import 'ingredients_store.dart';

class IngredientsPage extends StatefulWidget {
  final String title;
  const IngredientsPage({this.title = "Ingredientes"}) : super();

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends ModularState<IngredientsPage, IngredientsStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<SimpleIngredientWidget> _ingredients(List<IngredientEntity> items) {
      return items.map((ingredient) =>
          SimpleIngredientWidget(
          ingredient: ingredient,
          onTap: (item) {

          },
      )).toList();
    }

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
          Modular.to.pushNamed("create_ingredient");
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
                child: ScopedBuilder<IngredientsStore, Exception, List<IngredientEntity>>(
                  store: store,
                  onState: (_, data) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: _ingredients(data),
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