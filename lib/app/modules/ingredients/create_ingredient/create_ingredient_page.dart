import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../ingredient_entity.dart';
import 'create_ingredient_entity.dart';
import 'create_ingredient_store.dart';

class CreateIngredientPage extends StatefulWidget {
  final IngredientEntity? ingredient;
  const CreateIngredientPage({this.ingredient}) : super();

  @override
  _CreateIngredientPageState createState() => _CreateIngredientPageState();
}

class _CreateIngredientPageState
    extends ModularState<CreateIngredientPage, CreateIngredientStore> {
  static final _scaffoldKey = new Key("scaffoldKey");
  var _nameController = new TextEditingController();
  static final GlobalKey<FormState> _nameKey = new GlobalKey<FormState>(debugLabel: "_nameKey");
  var _quantityController = new TextEditingController();
  static final GlobalKey<FormState> _quantityKey = new GlobalKey<FormState>(debugLabel: "_quantityKey");
  var _amountController = new TextEditingController();
  static final GlobalKey<FormState> _amountKey = new GlobalKey<FormState>(debugLabel: "_amountKey");
  bool _isEnableButton = false;
  bool _hasMustIngredients = false;

  void _enableButton() {
    setState(() {
      _isEnableButton = _nameKey.currentState?.validate() == true && (
          _hasMustIngredients || (_quantityKey.currentState?.validate() == true
              && _amountKey.currentState?.validate() == true)
      );
    });
  }


  @override
  void initState() {
    super.initState();
    if (widget.ingredient != null) {
      _nameController.text = widget.ingredient?.name ?? "";
      _quantityController.text = widget.ingredient?.quantity.toString() ?? "";
      _amountController.text = widget.ingredient?.amount.toString() ?? "";
      store.setUnity(widget.ingredient?.unity ?? 0);
    }
  }

  Widget _showIngredientInfo(CreateIngredientEntity data) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 64,
          ),

          CupertinoSlidingSegmentedControl(
              children: {
                0: Text('grama'),
                1: Text('mililítro'),
                2: Text('unidade'),
              },
              groupValue: data.unity,
              onValueChanged: (int? index) {
                store.setUnity(index ?? 0);
              }),
          Container(height: 32,),
          AppTextFormField(
            refKey: _quantityKey,
            labelText: 'Quantidade',
            hintText: '500',
            controller: _quantityController,
            isEnable: true,
            onSaved: (String? value) async {
              _enableButton();
            },
            suffixText: data.unity == 0 ? 'g' : (data.unity == 1 ? 'ml' : "un"),
            textInputType: TextInputType.number,
          ),
          Container(height: 16,),
          AppTextFormField(
            refKey: _amountKey,
            labelText: 'Valor',
            hintText: '10.00',
            controller: _amountController,
            isEnable: true,
            onSaved: (String? value) async {
              _enableButton();
            },
            prefixText: "R\$ ",
            textInputType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          "Criar Ingrediente",
          style: textTitle2,
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Container(
          child: Align(
            alignment: Alignment(0, -1.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: ScopedBuilder<CreateIngredientStore, Exception, CreateIngredientEntity>(
                store: store,
                onState: (_, data) {
                  return Column(
                    children: [
                      AppTextFormField(
                        refKey: _nameKey,
                        labelText: 'Nome',
                        hintText: 'Margarina',
                        controller: _nameController,
                        isEnable: true,
                        onSaved: (String? value) async {
                          _enableButton();
                        },
                      ),
                      Container(height: 16,),
                      MergeSemantics(
                        child: ListTile(
                          title: const Text('Feito a partir de outros ingredientes?'),
                          trailing: CupertinoSwitch(
                            value: _hasMustIngredients,
                            onChanged: (bool value) {
                              setState(() { _hasMustIngredients = value; });
                              _enableButton();
                            },
                          ),
                          onTap: () {
                            setState(() { _hasMustIngredients = !_hasMustIngredients; });
                            _enableButton();
                          },
                        ),
                      ),
                      !_hasMustIngredients ? _showIngredientInfo(data) : Container(),
                      Expanded(child: Container(),),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CupertinoButton(
                          color: primaryColor,
                          child: Container(
                            width: double.maxFinite,
                            child: Align(
                              alignment: Alignment(0,0),
                              child: Text(
                                  'Criar ingrediente'
                              )
                            )
                          ),
                          onPressed: _isEnableButton == true ? () {
                            if (widget.ingredient != null) {
                              store.updateIngredient(
                                  _nameController.text,
                                  double.parse(_quantityController.text),
                                  double.parse(_amountController.text),
                                  _hasMustIngredients
                              );
                            } else {
                              store.postIngredient(
                                  _nameController.text,
                                  double.parse(_quantityController.text),
                                  double.parse(_amountController.text),
                                  _hasMustIngredients
                              );
                            }
                            Modular.to.pop();
                          } : null,
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
