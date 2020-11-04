import 'package:flutter/material.dart';

class EventMarkerWidget extends StatelessWidget {
  const EventMarkerWidget(
      {this.child,
      @required this.color,
      @required this.size,
      this.secondChild,
      this.secondColor});
  final double size;
  final Color color;
  final Color secondColor;
  final Widget secondChild;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          width: size,
          child: child,
          height: size,
        ),
        Positioned(
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: secondColor),
            width: 30,
            height: 30,
          ),
        )
      ],
    );
  }
}
