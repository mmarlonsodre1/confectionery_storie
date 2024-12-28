import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class GridButtonWidget extends StatelessWidget {
  GridButtonWidget({
    this.title,
    this.onTap,
  }) : super();

  final String? title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Align(
        alignment: Alignment(0, -0.55),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFFF5F5F5),
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              child: Align(
                alignment: Alignment(0, 0),
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: textTitle1
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

