import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    this.calendarController,
    this.title,
    this.builders,
    this.headerSubTitle = '',
    this.onCalendarCreated,
    this.buildEventsMarker,
    this.onDayLongPressed,
    this.onDaySelected,
    this.events,
    this.holidays,
    this.buildEventList,
    this.onVisibleDaysChanged,
  });
  final void Function(DateTime, DateTime, CalendarFormat) onCalendarCreated;
  final String title;
  final void Function(DateTime, DateTime, CalendarFormat) onVisibleDaysChanged;
  final void Function(DateTime, List<dynamic>) onDayLongPressed;
  final void Function(DateTime, List<dynamic>) onDaySelected;
  final CalendarController calendarController;
  final Map<DateTime, List<dynamic>> events;
  final Map<DateTime, List<dynamic>> holidays;
  final Widget buildEventList;
  final String headerSubTitle;
  final CalendarBuilders builders;
  final Widget buildEventsMarker;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TableCalendar(
            holidays: widget.holidays,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: AppColors.red),
            ),
            calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
                todayColor: AppColors.secondary,
                selectedColor: AppColors.red,
                holidayStyle: TextStyle(color: AppColors.red),
                weekendStyle: TextStyle(color: AppColors.red)),
            onCalendarCreated: widget.onCalendarCreated,
            onVisibleDaysChanged: widget.onVisibleDaysChanged,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              titleTextBuilder: (DateTime date, dynamic locale) {
                return '${converter.monthYearFromDate(date).split(' ')[0]} ${converter.monthYearFromDate(date).split(' ')[1]} ${widget.headerSubTitle}';
              },
              leftChevronIcon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              centerHeaderTitle: true,
              titleTextStyle: const TextStyle(fontSize: 16),
              formatButtonVisible: false,
            ),
            events: widget.events,
            onDayLongPressed: widget.onDayLongPressed,
            calendarController: widget.calendarController,
            onDaySelected: widget.onDaySelected,
            builders: widget.builders),
        Expanded(child: widget.buildEventList)
      ],
    );
  }
}
