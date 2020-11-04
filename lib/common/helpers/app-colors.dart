import 'package:flutter/material.dart';

class AppColors {
  static const Color red = Color.fromRGBO(224, 103, 100, 1);
  static const Color lightGrey = Color.fromRGBO(204, 204, 204, 1);
  static const Color semiGrey = Color.fromRGBO(204, 204, 204, 0.5);
  static const Color bg = Color.fromRGBO(54, 49, 56, 1);
  static const Color secondary = Color.fromRGBO(63, 59, 64, 1);
  static const Color green = Color.fromRGBO(46, 161, 120, 1);
  static const Color darkRed = Color.fromRGBO(227, 76, 76, 1);
  static const Color yellow = Color.fromRGBO(231, 190, 51, 1);
  static const Color orange = Color.fromRGBO(231, 143, 52, 1);
  static Color getColorTextVacation(String text) {
    switch (text) {
      case 'pending':
        return yellow;
      case 'approved':
        return green;
      case 'rejected':
        return red;
      default:
        return Colors.white;
    }
  }
}
