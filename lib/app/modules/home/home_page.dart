import 'package:confectionery_storie/app/components/grid_button_widget.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredients_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -0.55),
                child: GridButtonWidget(
                  title: 'Ingredientes',
                  onTap: () {
                    Modular.to.pushNamed("ingredients");
                  },
                ),
              ),
              Align(
                alignment: Alignment(0, 0.45),
                child: GridButtonWidget(
                  title: 'Produtos',
                  onTap: () {

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}