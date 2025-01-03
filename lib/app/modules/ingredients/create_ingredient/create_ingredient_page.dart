import 'package:confectionery_storie/app/components/app_text_form_field.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../models/ingredient_entity.dart';
import 'create_ingredient_entity.dart';
import 'create_ingredient_store.dart';

class CreateIngredientPage extends StatefulWidget {
  final IngredientEntity? ingredient;
  const CreateIngredientPage({this.ingredient}) : super();

  @override
  _CreateIngredientPageState createState() => _CreateIngredientPageState();
}

class _CreateIngredientPageState extends State<CreateIngredientPage> {
  final CreateIngredientStore _store = CreateIngredientStore();
  late CreateIngredientEntity _state;

  var _nameController = new TextEditingController();
  static final GlobalKey<FormState> _nameKey =
      new GlobalKey<FormState>(debugLabel: "_nameKey");
  var _quantityController = new TextEditingController();
  static final GlobalKey<FormState> _quantityKey =
      new GlobalKey<FormState>(debugLabel: "_quantityKey");
  var _amountController = new TextEditingController();
  static final GlobalKey<FormState> _amountKey =
      new GlobalKey<FormState>(debugLabel: "_amountKey");
  bool _isEnableButton = false;
  bool _hasMustIngredients = false;

  void _enableButton() {
    setState(() {
      _isEnableButton = _nameKey.currentState?.validate() == true &&
          (_hasMustIngredients ||
              (_quantityKey.currentState?.validate() == true &&
                  _amountKey.currentState?.validate() == true));
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.ingredient != null) {
        _nameController.text = widget.ingredient?.name ?? "";
        _quantityController.text = widget.ingredient?.quantity.toString() ?? "";
        _amountController.text = widget.ingredient?.amount.toString() ?? "";
        _store.setUnity(widget.ingredient?.unity ?? 0);
      }
    });
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
                _store.setUnity(index ?? 0);
              }),
          Container(
            height: 32,
          ),
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
          Container(
            height: 16,
          ),
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
    return ListenableBuilder(
      listenable: _store,
      builder: (context, old) {
        _state = _store.value;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: true,
            title: Text(
              "Criar Ingrediente",
              style: textTitle2.copyWith(color: Colors.white)
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
                  child: LayoutBuilder(builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
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
                              Container(
                                height: 16,
                              ),
                              MergeSemantics(
                                child: ListTile(
                                  title: const Text(
                                      'Feito a partir de outros ingredientes?'),
                                  trailing: CupertinoSwitch(
                                    value: _hasMustIngredients,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _hasMustIngredients = value;
                                      });
                                      _enableButton();
                                    },
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _hasMustIngredients =
                                      !_hasMustIngredients;
                                    });
                                    _enableButton();
                                  },
                                ),
                              ),
                              !_hasMustIngredients
                                  ? _showIngredientInfo(_state)
                                  : Container(),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CupertinoButton(
                                  color: primaryColor,
                                  child: Container(
                                      width: double.maxFinite,
                                      child: Align(
                                          alignment: Alignment(0, 0),
                                          child: Text(widget.ingredient != null
                                              ? 'Atualizar Ingrediente'
                                              : 'Criar ingrediente',
                                            style: TextStyle(
                                              color: Colors.white
                                            ),
                                          ))),
                                  onPressed: _isEnableButton == true
                                      ? () {
                                    var quantity = double.tryParse(
                                        _quantityController.text) ??
                                        0.0;
                                    var amount = double.tryParse(
                                        _amountController.text) ??
                                        0.0;
                                    _store.postIngredient(
                                        _nameController.text,
                                        _state.unity,
                                        quantity,
                                        amount,
                                        _hasMustIngredients,
                                        widget.ingredient);
                                    Modular.to.pop();
                                  }
                                      : null,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
