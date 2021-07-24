import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'create_ingredient_entity.dart';
import 'create_ingredient_store.dart';

class CreateIngredientPage extends StatefulWidget {
  final String title;
  const CreateIngredientPage({this.title = "Criar Ingrediente"}) : super();

  @override
  _CreateIngredientPageState createState() => _CreateIngredientPageState();
}

class _CreateIngredientPageState
    extends ModularState<CreateIngredientPage, CreateIngredientStore> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  var _nameController = new TextEditingController();
  var _nameKey = new GlobalKey<FormState>();
  var _quantityController = new TextEditingController();
  var _quantityKey = new GlobalKey<FormState>();
  var _amountController = new TextEditingController();
  var _amountKey = new GlobalKey<FormState>();
  bool _isEnableButton = false;

  void _enableButton() {
    setState(() {
      _isEnableButton = _nameKey.currentState!.validate() == true
          && _quantityKey.currentState!.validate() == true
          && _amountKey.currentState!.validate() == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          widget.title,
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
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: ScopedBuilder<CreateIngredientStore, Exception, CreateIngredientEntity>(
                store: store,
                onState: (_, data) {
                  return Column(
                    children: [
                      AppTextFormField(
                        key: _nameKey,
                        labelText: 'Nome',
                        hintText: 'Margarina',
                        controller: _nameController,
                        isEnable: true,
                        onSaved: (String? value) async {
                          _enableButton();
                        },
                      ),
                      Container(height: 64,),
                      ToggleSwitch(
                        minWidth: 100,
                        labels: ['grama', 'mililítro', 'unidade'],
                        initialLabelIndex: data.unity,
                        activeBgColor: [green],
                        inactiveBgColor: lightBlue,
                        inactiveFgColor: white,
                        totalSwitches: 3,
                        onToggle: (index) {
                          store.setUnity(index);
                        },
                      ),
                      Container(height: 32,),
                      AppTextFormField(
                        key: _quantityKey,
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
                        key: _amountKey,
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
                      Expanded(child: Container(),),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Container(
                            width: double.maxFinite,
                            height: 48,
                            child: Align(
                              alignment: Alignment(0,0),
                              child: Text(
                                  'CRIAR INGREDIENTE'
                              )
                            )
                          ),
                          onPressed: _isEnableButton == true ? () {
                            store.postIngredient(
                              _nameController.text,
                              double.parse(_quantityController.text),
                              double.parse(_amountController.text)
                            );
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
