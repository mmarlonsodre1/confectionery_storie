import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/components/simple_ingredient_widget.dart';
import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/models/ingredient_into_addiction_entity.dart';
import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'create_product_store.dart';

class CreateProductPage extends StatefulWidget {
  final ProductEntity? product;
  const CreateProductPage(
      {this.product})
      : super();

  @override
  _CreateProductPageState createState() =>
      _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final CreateProductStore _store = CreateProductStore();
  late ProductEntity _state;

  var _nameController = new TextEditingController();
  final _nameKey = GlobalKey<FormState>();
  var _percentController = new TextEditingController();
  final _percentKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.product != null) {
        _store.getProduct(widget.product?.id ?? "");
        _nameController.text = widget.product?.name ?? "";
        _percentController.text = widget.product?.percent?.toString() ?? "";
      }
    });
  }

  List<SimpleIngredientWidget> _ingredients(List<IngredientIntoAddictionEntity> items) {
    return items.map((e) {
      var ingredient = _store.getIngredient(e.ingredientId);
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
              widget.product?.name ?? "Criar Produto",
                style: textTitle2.copyWith(color: Colors.white)
            ),
            centerTitle: true,
            elevation: 4,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var ingredient = await Modular.to.pushNamed<IngredientEntity?>("/ingredients", arguments: true);
              if(ingredient != null) {
                await _store.addIngredient(ingredient);
                _store.getProduct(widget.product?.id ?? "");
              }
            },
            backgroundColor: primaryColor,
            elevation: 8,
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: white,
              size: 24,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Valor Total: R\$ ${_state.newAmount.toStringAsFixed(2)}",
                            style: textBody1,
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            "Custo: R\$ ${_state.cost.toStringAsFixed(2)}",
                            style: textBody1,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppTextFormField(
                  refKey: _nameKey,
                  labelText: 'Nome',
                  hintText: 'Bolo do pote',
                  controller: _nameController,
                  isEnable: true,
                  onSaved: (String? value) async {
                    _store.updateName(value ?? "");
                  },
                ),
                Container(height: 16.0,),
                AppTextFormField(
                  refKey: _percentKey,
                  labelText: 'Porcentagem de lucro',
                  hintText: '40',
                  controller: _percentController,
                  isEnable: true,
                  isPercentage: true,
                  onSaved: (String? value) async {
                    if (_percentKey.currentState?.validate() == true) {
                      if (value != null)
                        _store.updatePercent((double.tryParse(value) ?? 0.0));
                    }
                  },
                  suffixText: "%",
                  textInputType: TextInputType.number,
                ),
                Container(height: 16,),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: _ingredients(_state.newIngredients),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
