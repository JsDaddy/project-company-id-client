import 'package:flutter/material.dart';

class SocialRowIconWidget extends StatelessWidget {
  const SocialRowIconWidget(
      {@required this.icon, @required this.title, this.width});
  final IconData icon;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.grey,
          size: 16,
        ),
        const SizedBox(width: 8),
        Container(
          width: width,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
