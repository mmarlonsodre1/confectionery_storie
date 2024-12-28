import 'package:confectionery_storie/app/models/ingredient_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class SimpleIngredientWidget extends StatelessWidget {
  SimpleIngredientWidget(
      {this.ingredient,
      this.onTap,
      this.showArrow = true,
      this.showQuantity = false,
      this.showPrice = false,
        this.quantity,
      required this.onDeleteAction})
      : super();

  final IngredientEntity? ingredient;
  final Function(IngredientEntity?)? onTap;
  final bool showArrow;
  final bool showQuantity;
  final double? quantity;
  final bool showPrice;
  final Function(IngredientEntity?) onDeleteAction;

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
            onTap?.call(ingredient);
          },
          child: Dismissible(
            key: UniqueKey(),
            background: Container(color: red),
            onDismissed: (direction) {
              onDeleteAction.call(ingredient);
            },
            child: Container(
              constraints: BoxConstraints(minHeight: 80),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ingredient?.name ?? '',
                            style: textBody1Bold,
                          ),
                          showPrice
                              ? Text(
                                  "Custo: R\$ ${(
                                      ingredient?.newIngredients.isNotEmpty == true
                                          ? ingredient?.newAmount
                                          : ingredient?.amount
                                  )?.toStringAsFixed(2) ?? 0.0}",
                                  style: textBody1,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
                    child: showArrow == true
                        ? Container(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: black,
                              size: 24,
                            ),
                          )
                        : showQuantity == true
                            ? Container(
                                child: Text(
                                  "${quantity ?? ingredient?.quantity} ${ingredient?.unity == 0 ? 'g' : (ingredient?.unity == 1 ? 'ml' : "un")}",
                                  style: textBody1,
                                ),
                              )
                            : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
