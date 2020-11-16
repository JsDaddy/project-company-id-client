import 'package:flutter/widgets.dart';

class AppScreen {
  static double getRatio(BuildContext context) {
    return MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height;
  }
}
