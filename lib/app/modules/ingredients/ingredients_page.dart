import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/components/simple_ingredient_widget.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ingredient_entity.dart';
import 'ingredients_store.dart';

class IngredientsPage extends StatefulWidget {
  final String title;
  final bool isSelection;
  const IngredientsPage({this.title = "Ingredientes", this.isSelection = false}) : super();

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends ModularState<IngredientsPage, IngredientsStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _quantityKey = GlobalKey<FormState>();
  var _quantityController = new TextEditingController();
  bool _isEnableDialogButton = false;

  @override
  void initState() {
    super.initState();
    store.getIngredients();
  }

  Future<void> _showQuantityDialog(IngredientEntity ingredient, BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CupertinoAlertDialog(
              title: const Text('Escolha a quantidade do ingrediente'),
              content: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Material(
                  color: CupertinoDynamicColor.resolve(
                    CupertinoDynamicColor.withBrightness(
                      color: Color(0xCCF2F2F2),
                      darkColor: Color(0xBF1E1E1E),
                    ), context,),
                  child: AppTextFormField(
                    refKey: _quantityKey,
                    labelText: 'Quantidade',
                    hintText: ingredient.quantity?.toString(),
                    controller: _quantityController,
                    isEnable: true,
                    textInputType: TextInputType.number,
                    suffixText: ingredient.unity == 0 ? 'g' : (ingredient.unity == 1 ? 'ml' : "un"),
                    onSaved: (String? value) async {
                      _isEnableDialogButton = (double.tryParse(_quantityController.text.trim()) ?? 0.0) > 0.0;
                      setState(() {});
                    },
                    horizontalPadding: 0.0,
                    showError: false,
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Confirmar'),
                  onPressed: _isEnableDialogButton ? () {
                    var quantity = double.tryParse(_quantityController.text);
                    var amount = ingredient.hasMustIngredients == true
                        ? (ingredient.amount ?? 0.0) * (quantity ?? 0.0)
                        : ((ingredient.amount ?? 0.0)/(ingredient.quantity ?? 0.0)) * (quantity ?? 0.0);
                    var newIngredient = new IngredientEntity(
                        ingredient.name,
                        ingredient.unity,
                        quantity,
                        amount,
                        ingredient.hasMustIngredients,
                        ingredient.ingredients
                    );
                    newIngredient.id = ingredient.id;
                    Modular.to.pop();
                    Modular.to.pop(newIngredient);
                  } : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<SimpleIngredientWidget> _ingredients(List<IngredientEntity> items) {
      return items.map((ingredient) =>
          SimpleIngredientWidget(
          ingredient: ingredient,
          showPrice: true,
          onTap: (item) async {
            if (widget.isSelection == true) {
              _showQuantityDialog(ingredient, context);
            }
            else if (item?.hasMustIngredients == true) {
              await Modular.to.pushNamed(
                  "ingredient_into_ingredient", arguments: item);
              store.getIngredients();
            } else if (item?.hasMustIngredients == false) {
              await Modular.to.pushNamed("create_ingredient", arguments: item);
              store.getIngredients();
            }
          },
          onDeleteAction: (item) async {
            await store.deleteIngredient(item, context);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${ingredient.name} apagado(a)'),
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
          'Ingredientes',
          style: textTitle2,
        ),
        centerTitle: true,
        elevation: 4,
      ),
      floatingActionButton: widget.isSelection == false
        ? FloatingActionButton(
          onPressed: () async {
            await Modular.to.pushNamed("create_ingredient");
            await store.getIngredients();
            setState(() {});
          },
          backgroundColor: primaryColor,
          elevation: 8,
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: white,
            size: 24,
          ),
        ) : Container(),
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