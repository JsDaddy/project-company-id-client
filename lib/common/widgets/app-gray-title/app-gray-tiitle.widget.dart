import 'package:flutter/material.dart';

class GrayTitleWidget extends StatelessWidget {
  const GrayTitleWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 18));
  }
}
