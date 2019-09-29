import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  IconWidget(this.iconData, this.description);

  final IconData iconData;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Icon(
            iconData,
            size: 120,
          ),
          SizedBox(
            height: 16,
          ),
          Text(description),
        ],
      ),
    );
  }
}