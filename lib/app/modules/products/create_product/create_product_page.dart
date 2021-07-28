import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/components/simple_ingredient_widget.dart';
import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/modules/products/product_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
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

class _CreateProductPageState extends ModularState<CreateProductPage, CreateProductStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _nameController = new TextEditingController();
  final _nameKey = GlobalKey<FormState>();
  var _percentController = new TextEditingController();
  final _percentKey = GlobalKey<FormState>();
  bool _isEnableButton = false;

  void _enableButton() {
    setState(() {
      _isEnableButton = _nameKey.currentState?.validate() == true
        && _percentKey.currentState?.validate() == true;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      store.setProduct(widget.product!);
      _nameController.text = widget.product?.name ?? "";
      _percentController.text = widget.product?.percent?.toString() ?? "";
    }
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
              ))
          .toList();
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          widget.product?.name ?? "Criar Produto",
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
      body: ScopedBuilder<CreateProductStore, Exception, ProductEntity>(
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
                              "Valor Total: R\$ ${widget.product?.amount?.toStringAsFixed(2) ?? 0.0}",
                              style: textBody1,
                              textAlign: TextAlign.end,
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
                          _enableButton();
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
                          _enableButton();
                          if (_percentKey.currentState?.validate() == true) {
                            if (value != null)
                              store.updatePercent(
                                  double.tryParse(value) ?? 0.0);
                          }
                        },
                        suffixText: "%",
                        textInputType: TextInputType.number,
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
