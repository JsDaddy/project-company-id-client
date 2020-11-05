import 'dart:convert';

import 'package:company_id_new/common/helpers/app-images.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({this.avatar, this.sizes});
  final String avatar;
  final double sizes;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: sizes,
        height: sizes,
        child: ClipOval(
            child: avatar != null
                ? Image.memory(
                    base64.decode(avatar.split(',').last),
                    gaplessPlayback: true,
                    fit: BoxFit.cover,
                  )
                : Image.asset(AppImages.noAvatar)));
  }
}
