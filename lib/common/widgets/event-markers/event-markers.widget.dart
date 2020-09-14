import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/widgets/event-marker/event-marker.widget.dart';
import 'package:flutter/material.dart';

class EventMarkersWidget extends StatelessWidget {
  const EventMarkersWidget(this.date, this.events);
  final DateTime date;
  final List<dynamic> events;
  @override
  Widget build(BuildContext context) {
    return events[0].timelogs != null
        ? EventMarkerWidget(
            color: AppColors.red,
            size: 24,
            child: Center(
              child: Text(
                events[0].timelogs.round() != events[0].timelogs
                    ? events[0].timelogs.toString()
                    : events[0].timelogs.toInt().toString(),
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ))
        : events[0].vacations != null
            ? Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.green),
                child: Center(child: Text(events.length.toString())),
                width: 16.0,
                height: 16.0,
              )
            : Container();
  }
}
