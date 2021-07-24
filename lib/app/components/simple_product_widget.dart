import 'package:confectionery_storie/app/utils/color.dart';
import 'package:confectionery_storie/app/utils/text_style.dart';
import 'package:flutter/material.dart';

class SimpleProductWidget extends StatefulWidget {
  SimpleProductWidget({
    Key key,
    this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  _SimpleProductWidgetState createState() => _SimpleProductWidgetState();
}

class _SimpleProductWidgetState extends State<SimpleProductWidget> {
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
        onTap: widget.onTap,
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
                    widget.title,
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
