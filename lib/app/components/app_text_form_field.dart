import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final GlobalKey<FormState>? refKey;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final bool? isEnable;
  final FormFieldSetter<String>? onSaved;
  bool autoFocus;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType textInputType;
  final String prefixText;
  final double horizontalPadding;
  final bool showError;
  final bool isPercentage;

  AppTextFormField(
      {
        this.controller,
        this.labelText,
        this.hintText,
        this.suffixText = '',
        this.isEnable,
        this.onSaved,
        this.autoFocus = false,
        this.onFieldSubmitted,
        this.textInputType = TextInputType.text,
        this.prefixText = '',
        this.refKey,
        this.horizontalPadding = 16.0,
        this.showError = true,
        this.isPercentage = false
      })
      : super();

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.refKey,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        try {
          if (primaryFocus?.context != null) Form.of(primaryFocus!.context!)!.save();
        } catch (_) {}
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: widget.horizontalPadding,
          left: widget.horizontalPadding
        ),
        child: Container(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              suffixText: widget.suffixText,
              prefixText: widget.prefixText,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
            ),
            controller: widget.controller,
            enabled: widget.isEnable,
            keyboardType: widget.textInputType,
            autofocus: widget.autoFocus,
            validator: (String? value) {
              if (!widget.showError) return null;
              if (widget.textInputType == TextInputType.number) {
                  if (double.tryParse(value!.trim()) == null) return 'Campo vazio';
                  else if (!widget.isPercentage
                      && double.tryParse(value.trim())! <= 0.0)
                    return 'Necessário ser valor numérico e maior que 0';
              } else if (widget.textInputType == TextInputType.text &&
                  value?.trim() == ''
              ) {
                return 'Campo vazio';
              }
              else return null;
            },
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}