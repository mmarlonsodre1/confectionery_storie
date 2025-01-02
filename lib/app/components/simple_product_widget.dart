import 'package:confectionery_storie/app/models/product_entity.dart';
import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class SimpleProductWidget extends StatelessWidget {
  SimpleProductWidget({
    this.product,
    this.onTap,
    required this.onDeleteAction,
  }) : super();

  final ProductEntity? product;
  final Function(ProductEntity?)? onTap;
  final Function(ProductEntity?) onDeleteAction;

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
            onTap?.call(product);
          },
          child: Dismissible(
            key: UniqueKey(),
            background: Container(color: red),
            onDismissed: (direction) {
              onDeleteAction.call(product);
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
                            product?.name ?? '',
                            style: textBody1Bold,
                          ),
                          Text(
                            "Preço: R\$ ${product?.newAmount.toStringAsFixed(2) ?? 0.0}",
                            style: textBody1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
                    child: Container(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: black,
                        size: 24,
                      ),
                    ),
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
