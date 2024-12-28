import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/components/simple_ingredient_widget.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/ingredient_entity.dart';
import 'ingredients_store.dart';

class IngredientsPage extends StatefulWidget {
  final String title;
  final bool isSelection;
  const IngredientsPage({this.title = "Ingredientes", this.isSelection = false}) : super();

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final IngredientsStore _store = IngredientsStore();
  late List<IngredientEntity> _state;

  final _quantityKey = GlobalKey<FormState>();
  var _quantityController = new TextEditingController();
  bool _isEnableDialogButton = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _store.getIngredients();
    });
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
                        ingredient.ingredients,
                        ingredient.newIngredients,
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
            } else if (item?.hasMustIngredients == false) {
              await Modular.to.pushNamed("create_ingredient", arguments: item);
            }
            _store.getIngredients();
          },
          onDeleteAction: (item) async {
            await _store.deleteIngredient(item, context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${ingredient.name} apagado(a)'),
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
      builder: (context, old) {
        _state = _store.value;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: true,
            title: Text(
              'Ingredientes',
              style: textTitle2.copyWith(color: Colors.white)
            ),
            centerTitle: true,
            elevation: 4,
          ),
          floatingActionButton: widget.isSelection == false
            ? FloatingActionButton(
              onPressed: () async {
                await Modular.to.pushNamed("create_ingredient");
                _store.getIngredients();
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
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: _ingredients(_state),
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