import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-dropdowns.dart';
import 'package:company_id_new/common/helpers/app-query.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-dropdown-wrapper/app-dropdown-wrapper.widget.dart';
import 'package:company_id_new/common/widgets/calendar/calendar.widget.dart';
import 'package:company_id_new/common/widgets/event-marker/event-marker.widget.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:table_calendar/table_calendar.dart';

class _ViewModel {
  _ViewModel({this.logs, this.statistic, this.holidays});
  Map<DateTime, List<CalendarModel>> logs;
  Map<DateTime, List<CalendarModel>> holidays;
  StatisticModel statistic;
}

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  CalendarController _calendarController;
  int selectedValue;
  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onBackPressed(),
        child: StoreConnector<AppState, _ViewModel>(
            converter: (Store<AppState> store) => _ViewModel(
                // isLoading: store.state.isLoading,
                statistic: store.state.adminStatistic,
                holidays: store.state.holidays,
                logs: store.state.adminLogs),
            builder: (BuildContext context, _ViewModel state) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Image.asset('assets/filter.png',
                      width: 30, height: 30, color: Colors.white),
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                        context: context,
                        useRootNavigator: true,
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              child: Column(
                                children: <Widget>[
                                  const Text('Filters',
                                      style: TextStyle(fontSize: 24)),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppDropDownWrapperWidget(
                                    child: DropdownButtonFormField<int>(
                                      decoration: AppDropDownStyles.decoration,
                                      style: AppDropDownStyles.style,
                                      icon: AppDropDownStyles.icon,
                                      isExpanded: AppDropDownStyles.isExpanded,
                                      hint: const Text('Select user',
                                          style: AppDropDownStyles.hintStyle),
                                      value: selectedValue,
                                      onChanged: (int value) => setState(() {
                                        selectedValue = value;
                                      }),
                                      items: <int>[1, 2, 3].map((int value) {
                                        return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text('$value'));
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppButtonWidget(
                                      color: AppColors.green,
                                      title: 'Apply',
                                      onClick: () {})
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
                body: CalendarWidget(
                  // headerSubTitle: state.filter?.user != null &&
                  //         state.filter?.project == null
                  //     ? '\n ${_timeForMonth(state)} / ${state.workTimeMonth} h / ${workedTimeForMonth(state.workTimeMonth, _timeForMonth(state), context)}'
                  //     : '\n${_timeForMonth(state)}',
                  title: 'Timelog',
                  holidays: state.holidays,
                  onCalendarCreated: _onCalendarCreated,
                  onVisibleDaysChanged: _onVisibleDaysChanged,
                  events: state.logs,
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
                  onDaySelected: _onDaySelected,
                  buildEventList: _buildEventList(state),
                ),
              );
            }));
  }

  Widget _buildEventList(_ViewModel state) {
    return Container();
  }

  void _onDaySelected(DateTime day, List<dynamic> events) {
    // store.dispatch(GetAdminLogByDatePending())
    // store.dispatch(SetCurrentDayTimelogAll(day.toLocal()));
  }

  Widget _buildEventsMarker(
    DateTime date,
    List<dynamic> events,
  ) {
    if (events[0].timelogs != null) {
      return EventMarkerWidget(
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
          ));
    }
    return Container();

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

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    store.dispatch(GetAdminLogsPending(
        '?${AppQuery.dateQuery(first)}&${AppQuery.logTypeQuery(LogType.timelog)}'));
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    store.dispatch(GetAdminLogsPending(
        '?${AppQuery.dateQuery(first)}&${AppQuery.logTypeQuery(LogType.all)}'));
  }

  Future<bool> _onBackPressed() async {
    await SystemNavigator.pop();
    return true;
  }
}

// String sumTimeForMonth(List<LogModel> times, BuildContext context) {
//   int h = 0;
//   int m = 0;
//   final RegExp reg1 = RegExp(r'\d+(?=h)');
//   final RegExp reg2 = RegExp(r'\d+(?=m)');
//   for (final LogModel timelog in times) {
//     h += reg1.stringMatch(timelog.time) != null
//         ? int.parse(reg1.stringMatch(timelog.time))
//         : 0;
//     m += reg2.stringMatch(timelog.time) != null
//         ? int.parse(reg2.stringMatch(timelog.time))
//         : 0;
//   }
//   while (m >= 60) {
//     h++;
//     m -= 60;
//   }
//   return '$h h$m m';
// }
