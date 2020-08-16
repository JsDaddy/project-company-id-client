import 'package:company_id_new/common/widgets/calendar/calendar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  CalendarController _calendarController;
  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onBackPressed(),
        child: CalendarWidget(
          // headerSubTitle: state.filter?.user != null &&
          //         state.filter?.project == null
          //     ? '\n ${_timeForMonth(state)} / ${state.workTimeMonth} h / ${workedTimeForMonth(state.workTimeMonth, _timeForMonth(state), context)}'
          //     : '\n${_timeForMonth(state)}',
          title: 'Timelog',
          // holidays: state.holidaysSelector,
          onCalendarCreated: _onCalendarCreated,
          // onVisibleDaysChanged: _onVisibleDaysChanged,
          // events: state.timeLogSelected,
          calendarController: _calendarController,
          builders: CalendarBuilders(
            markersBuilder: (BuildContext context, DateTime date,
                List<dynamic> events, List<dynamic> holidays) {
              final List<Widget> children = <Widget>[];
              if (events.isNotEmpty) {
                children.add(
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: _buildEventsMarker(date, events),
                  ),
                );
              }
              return children;
            },
          ),
          // onDaySelected: _onDaySelected,
          buildEventList: _buildEventList(),
        ));
  }

  Widget _buildEventList() {
    return Container();
  }

  Widget _buildEventsMarker(
    DateTime date,
    List<dynamic> events,
  ) {
    return Container();
    // final int _totalTime = sumTime(events);
    // double totalTimeInMinutes = _totalTime / 60;
    // totalTimeInMinutes = (totalTimeInMinutes * 2).round() / 2;

    // if (state.filter?.user != null) {
    //   return _totalTime == 0
    //       ? _eventMarker(
    //           null,
    //           events[0].type == 1 || events[0].type == 2
    //               ? greenColor
    //               : redColor,
    //           16)
    //       : _eventMarker(
    //           Center(
    //             child: Text(
    //               '${totalTimeInMinutes.round() == totalTimeInMinutes ? totalTimeInMinutes.round() : totalTimeInMinutes}',
    //               style: TextStyle().copyWith(
    //                 color: Colors.white,
    //                 fontSize: 12.0,
    //               ),
    //             ),
    //           ),
    //           redColor,
    //           24);
    // }
    // return _totalTime == 0
    //     ? Container()
    //     : _eventMarker(
    //         Center(
    //           child: Text(
    //             '${totalTimeInMinutes.round() == totalTimeInMinutes ? totalTimeInMinutes.round() : totalTimeInMinutes}',
    //             style: TextStyle().copyWith(
    //               color: Colors.white,
    //               fontSize: 12.0,
    //             ),
    //           ),
    //         ),
    //         redColor,
    //         24);
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print(first.toIso8601String());
    // store.dispatch(GetAllTimelogPending(firstDay: first, lastDay: last));
    // store.dispatch(GetVacationAllPending(firstDay: first, lastDay: last));
  }

  Future<bool> _onBackPressed() async {
    await SystemNavigator.pop();
    return true;
  }
}
