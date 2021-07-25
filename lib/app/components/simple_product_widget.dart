import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class SimpleIngredientWidget extends StatefulWidget {
  SimpleIngredientWidget({
    this.ingredient,
    this.onTap,
  }) : super();

  final IngredientEntity? ingredient;
  final Function(IngredientEntity?)? onTap;

  @override
  _SimpleIngredientWidgetState createState() => _SimpleIngredientWidgetState();
}

class _SimpleIngredientWidgetState extends State<SimpleIngredientWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: whiteBackground,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          widget.onTap?.call(widget.ingredient);
        },
        child: Container(
          constraints: BoxConstraints(
            minHeight: 80
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    widget.ingredient?.name ?? '',
                    style: textBody1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                  right: 16.0
                ),
                child: Container(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: black,
                    size: 24,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
