import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/components/simple_ingredient_widget.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ingredient_entity.dart';
import 'ingredient_into_ingredient_store.dart';

class IngredientIntoIngredientPage extends StatefulWidget {
  final IngredientEntity ingredient;
  const IngredientIntoIngredientPage(
      {required this.ingredient})
      : super();

  @override
  _IngredientIntoIngredientPageState createState() =>
      _IngredientIntoIngredientPageState();
}

class _IngredientIntoIngredientPageState extends ModularState<
    IngredientIntoIngredientPage, IngredientIntoIngredientStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _nameController = new TextEditingController();
  final _nameKey = GlobalKey<FormState>();
  bool _isEnableButton = false;

  void _enableButton() {
    setState(() {
      _isEnableButton = _nameKey.currentState?.validate() == true;
    });
  }

  @override
  void initState() {
    super.initState();
    store.getIngredient(widget.ingredient.id ?? "");
    _nameController.text = widget.ingredient.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    List<SimpleIngredientWidget> _ingredients(List<IngredientEntity> items) {
      return items
          .map((ingredient) => SimpleIngredientWidget(
                ingredient: ingredient,
                showArrow: false,
                showQuantity: true,
                onTap: (item) {},
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
              ))
          .toList();
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          widget.ingredient.name ?? "",
          style: textTitle2,
        ),
        centerTitle: true,
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var ingredient = await Modular.to.pushNamed<IngredientEntity?>("ingredients", arguments: true);
          if(ingredient != null) await store.addIngredient(ingredient);
          setState(() {});
        },
        backgroundColor: primaryColor,
        elevation: 8,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: white,
          size: 24,
        ),
      ),
      body: ScopedBuilder<IngredientIntoIngredientStore, Exception, IngredientEntity>(
        store: store,
        onState: (_, data) {
          return SafeArea(
            child: Container(
              child: Align(
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Valor Total: R\$ ${data.amount}",
                              style: textBody1,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      AppTextFormField(
                        refKey: _nameKey,
                        labelText: 'Nome',
                        hintText: 'Margarina',
                        controller: _nameController,
                        isEnable: true,
                        onSaved: (String? value) async {
                          _enableButton();
                          store.updateName(value ?? "");
                        },
                      ),
                      Container(height: 16,),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: _ingredients(data.ingredients ?? []),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
