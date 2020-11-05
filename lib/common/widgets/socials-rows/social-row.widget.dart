import 'package:company_id_new/common/helpers/app-images.dart';
import 'package:flutter/material.dart';

class SocialRowWidget extends StatelessWidget {
  const SocialRowWidget(
      {@required this.iconName, @required this.title, this.width});
  final String iconName;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          AppImages.getIconByName(iconName),
          color: Colors.grey,
          width: 16,
          height: 16,
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
            width: width,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }
}
