import 'package:company_id_new/store/models/badge.model.dart';
import 'package:flutter/material.dart';

class EventMarkersWidget extends StatelessWidget {
  const EventMarkersWidget(this.badges);
  final List<BadgeModel> badges;
  @override
  Widget build(BuildContext context) {
    return badges != null && badges.isEmpty
        ? Container()
        : Stack(
            children: badges.map((BadgeModel badge) {
            final int index = badges.indexOf(badge);
            switch (index) {
              case 0:
                return Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: badge.color),
                  width: 24,
                  height: 24,
                  child: Center(
                    child: Text(
                      badge.value.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                );
              case 1:
                return Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: badge.color),
                    width: 6,
                    height: 6,
                  ),
                );
              case 2:
                return Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: badge.color),
                    width: 6,
                    height: 6,
                  ),
                );
            }
          }).toList());
  }
}
