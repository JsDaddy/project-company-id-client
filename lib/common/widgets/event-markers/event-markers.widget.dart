import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/widgets/event-marker/event-marker.widget.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:flutter/material.dart';

class BadgeModel {
  BadgeModel(this.color, this.value, this.weight);
  int weight;
  dynamic value;
  Color color;
}

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
          }).toList()
            // [
            // Container(
            //   decoration:
            //       const BoxDecoration(shape: BoxShape.circle, color: AppColors.red),
            //   width: 24,
            //   height: 24,
            //   child: Center(
            //     child: Text(
            //       '48.5',
            //       style: TextStyle(fontSize: 11),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Container(
            //     decoration: const BoxDecoration(
            //         shape: BoxShape.circle, color: AppColors.green),
            //     width: 6,
            //     height: 6,
            //   ),
            // ),
            //   Positioned(
            //     top: 0,
            //     right: 0,
            //     child: Container(
            //       decoration: const BoxDecoration(
            //           shape: BoxShape.circle, color: AppColors.orange),
            //       width: 6,
            //       height: 6,
            //     ),
            //   )
            // ],
            );
    // return events[0].timelogs != null
    //     ? EventMarkerWidget(
    //         secondColor: Colors.orange,
    //         color:
    //             events[0].birthdays != null ? AppColors.orange : AppColors.red,
    //         size: 24,
    //         child: Center(
    //           child: Text(
    //             events[0].timelogs.round() != events[0].timelogs
    //                 ? events[0].timelogs.toString()
    //                 : events[0].timelogs.toInt().toString(),
    //             style: const TextStyle(
    //               fontSize: 12.0,
    //             ),
    //           ),
    //         ))
    //     : events[0].birthdays != null
    //         ? EventMarkerWidget(
    //             color: AppColors.orange,
    //             child: Center(
    //                 child: Text(events[0].vacations != null
    //                     ? events[0].vacations.toString()
    //                     : '')),
    //             size: 18,
    //           )
    //         : events[0].vacations != null
    //             ? EventMarkerWidget(
    //                 color: AppColors.green,
    //                 child:
    //                     Center(child: Text((events[0].vacations).toString())),
    //                 size: 18)
    //             : Container();
  }
}
