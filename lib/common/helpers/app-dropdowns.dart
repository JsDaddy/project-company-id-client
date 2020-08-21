import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:flutter/material.dart';

class AppDropDownStyles {
  static const InputDecoration decoration =
      InputDecoration(border: InputBorder.none);
  static const TextStyle style = TextStyle(color: Colors.white);
  static const Widget icon = Icon(
    Icons.expand_more,
    color: AppColors.red,
  );
  static const bool isExpanded = true;
  static const TextStyle hintStyle = TextStyle(color: Colors.white);
}
