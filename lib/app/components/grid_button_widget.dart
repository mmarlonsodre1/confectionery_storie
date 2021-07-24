import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class GridButtonWidget extends StatefulWidget {
  GridButtonWidget({
    Key key,
    this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  _GridButtonWidgetState createState() => _GridButtonWidgetState();
}

class _GridButtonWidgetState extends State<GridButtonWidget> {
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
            onTap: widget.onTap,
            child: Container(
              child: Align(
                alignment: Alignment(0, 0),
                child: Text(
                  widget.title,
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

