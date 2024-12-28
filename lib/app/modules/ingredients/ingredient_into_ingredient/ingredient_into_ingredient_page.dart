import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/components/simple_ingredient_widget.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/ingredient_entity.dart';
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

class _IngredientIntoIngredientPageState extends State<IngredientIntoIngredientPage> {
  final IngredientIntoIngredientStore _store = IngredientIntoIngredientStore();
  late IngredientEntity _state;

  var _nameController = new TextEditingController();
  final _nameKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _store.getIngredient(widget.ingredient.id ?? "");
      _nameController.text = widget.ingredient.name ?? "";
    });
  }

  List<SimpleIngredientWidget> _ingredients(List<IngredientIntoAddictionEntity> items) {
    return items.map((e) {
      var ingredient = _store.getIngredientIntoIngredient(e.ingredientId);
      return SimpleIngredientWidget(
        ingredient: ingredient,
        showArrow: false,
        showQuantity: true,
        quantity: e.quantity,
        onTap: (item) {},
        onDeleteAction: (item) async {
          await _store.deleteIngredient(e, context);
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
      );
    }).toList();
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
              widget.ingredient.name ?? "",
              style: textTitle2.copyWith(color: Colors.white)
            ),
            centerTitle: true,
            elevation: 4,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var ingredient = await Modular.to.pushNamed<IngredientEntity?>("/ingredients", arguments: true);
              if(ingredient != null) await _store.addIngredient(ingredient, context);
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
                              "Custo Total: R\$ ${_state.newAmount.toStringAsFixed(2)}",
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
                          _store.updateName(value ?? "");
                        },
                      ),
                      Container(height: 16,),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: _ingredients(_state.newIngredients),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
