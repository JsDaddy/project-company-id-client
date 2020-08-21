import 'package:flutter/material.dart';

class EventMarkerWidget extends StatelessWidget {
  const EventMarkerWidget(
      {this.child, @required this.color, @required this.size});
  final double size;
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      width: size,
      child: child,
      height: size,
    );
  }
}
