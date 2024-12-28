import 'package:confectionery_storie/app/components/grid_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({this.title = "Home"}) : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                    Modular.to.pushNamed("products");
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