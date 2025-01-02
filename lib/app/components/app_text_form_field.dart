import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final GlobalKey<FormState>? refKey;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final bool? isEnable;
  final FormFieldSetter<String>? onSaved;
  final bool autoFocus;
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
  Widget build(BuildContext context) {
    return Form(
      key: refKey,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        try {
          if (primaryFocus?.context != null) Form.of(primaryFocus!.context!).save();
        } catch (_) {}
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: horizontalPadding,
          left: horizontalPadding
        ),
        child: Container(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              suffixText: suffixText,
              prefixText: prefixText,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
            ),
            controller: controller,
            enabled: isEnable,
            keyboardType: textInputType,
            autofocus: autoFocus,
            validator: (String? value) {
              if (!showError) return null;
              if (textInputType == TextInputType.number) {
                  if (double.tryParse(value!.trim()) == null) return 'Campo vazio';
                  else if (!isPercentage
                      && double.tryParse(value.trim())! <= 0.0)
                    return 'Necessário ser valor numérico e maior que 0';
              } else if (textInputType == TextInputType.text &&
                  value?.trim() == ''
              ) {
                return 'Campo vazio';
              }
              return null;
            },
            onSaved: onSaved,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}