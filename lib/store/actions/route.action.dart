import 'package:flutter/material.dart';

class PushAction {
  PushAction(this.destination, this.title, {this.key});
  GlobalKey<NavigatorState> key;
  String title;
  final Widget destination;
}

class PushReplacementAction {
  PushReplacementAction(this.destination, {this.key});
  GlobalKey<NavigatorState> key;
  final Widget destination;
}

class PopAction {
  PopAction({this.params, this.key});
  GlobalKey<NavigatorState> key;
  dynamic params;
}
