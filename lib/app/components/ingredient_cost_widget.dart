import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class IngredientCostWidget extends StatelessWidget {
  IngredientCostWidget({
    this.title,
    this.value,
  }) : super();

  final String? title;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Color(0xFFF5F5F5),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 70,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(-0.75, 0),
              child: Text(
                title ?? '',
                style: textBody1,
              ),
            ),
            Align(
              alignment: Alignment(0.86, 0),
              child: Text(
                value.toString(),
                style: textBody1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

