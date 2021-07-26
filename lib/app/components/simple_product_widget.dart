import 'package:confectionery_storie/app/modules/ingredients/ingredient_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class SimpleIngredientWidget extends StatefulWidget {
  SimpleIngredientWidget({
    this.ingredient,
    this.onTap,
    this.showArrow = true,
    this.showQuantity = false,
    this.showPrice = false
  }) : super();

  final IngredientEntity? ingredient;
  final Function(IngredientEntity?)? onTap;
  final bool showArrow;
  final bool showQuantity;
  final bool showPrice;

  @override
  _SimpleIngredientWidgetState createState() => _SimpleIngredientWidgetState();
}

class _SimpleIngredientWidgetState extends State<SimpleIngredientWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
                    child: widget.showArrow == true ?
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: black,
                        size: 24,
                      ),
                    ) : widget.showQuantity == true ?
                      Container(
                        child: Text(
                          "${widget.ingredient?.quantity} ${
                              widget.ingredient?.unity == 0 ? 'g'
                                  : (widget.ingredient?.unity == 1 ? 'ml' : "un")
                          }",
                          style: textBody1,
                        ),
                    ) : Container(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
