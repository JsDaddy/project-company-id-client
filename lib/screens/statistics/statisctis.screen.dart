import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/helpers/app-params.dart';
import 'package:company_id_new/common/helpers/app-query.dart';
import 'package:company_id_new/common/widgets/calendar/calendar.widget.dart';
import 'package:company_id_new/common/widgets/event-list/event-list.widget.dart';
import 'package:company_id_new/common/widgets/event-markers/event-markers.widget.dart';
import 'package:company_id_new/screens/statistics/filter/filter.widget.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/store/models/admin-filter.model.dart';
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
  _ViewModel({this.logs, this.statistic, this.holidays, this.logsByDate});
  Map<DateTime, List<CalendarModel>> logs;
  Map<DateTime, List<CalendarModel>> holidays;
  List<LogModel> logsByDate;
  StatisticModel statistic;
}

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  CalendarController _calendarController;
  DateTime firstDate;
  @override
  void initState() {
    _calendarController = CalendarController();
    store.dispatch(GetUsersPending());
    store.dispatch(GetProjectsPending());
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
                logsByDate: store.state.adminLogsByDate,
                logs: store.state.adminLogs),
            builder: (BuildContext context, _ViewModel state) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Image.asset('assets/filter.png',
                      width: 30, height: 30, color: Colors.white),
                  onPressed: () async {
                    final AdminFilterModel adminFilter =
                        await showModalBottomSheet<AdminFilterModel>(
                            context: context,
                            useRootNavigator: true,
                            builder: (BuildContext context) =>
                                AdminLogFilterWidget());
                    if (adminFilter != null) {
                      final String logType = AppConverting.getTypeLogQuery(
                          adminFilter.logType.logType);
                      final String vacQuery = AppQuery.vacationTypeQuery(
                          adminFilter.logType.vacationType);

                      final String vacModifedQuery =
                          vacQuery.isEmpty ? '' : '&$vacQuery';
                      String userQuery = '';
                      if (adminFilter.user != null) {
                        userQuery = '&uid=${adminFilter.user.id}';
                      }
                      String projectQuery = '';
                      if (adminFilter.project != null) {
                        projectQuery = '&project=${adminFilter.project.id}';
                      }
                      store.dispatch(SaveAdminFilter(adminFilter));
                      store.dispatch(GetAdminLogsPending(
                          '${AppParams.dateQuery(firstDate)}/$logType?$vacModifedQuery$userQuery'));
                      // store.dispatch(GetAdminLogByDatePending(
                      //     '?${AppQuery.logTypeQuery(LogType.all)}&${AppQuery.dateQuery(DateTime.now())}'));
                    }
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
                            child: EventMarkersWidget(date, events),
                          ),
                        );
                      }
                      return children;
                    },
                  ),
                  onDaySelected: _onDaySelected,
                  buildEventList: EventListWidget(state.logsByDate),
                ),
              );
            }));
  }

  void _onDaySelected(DateTime day, List<dynamic> events) {
    store.dispatch(GetAdminLogByDatePending(
        '${AppParams.dateQuery(day)}?${AppQuery.logTypeQuery(LogType.all)}'));
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    firstDate = first;
    store.dispatch(GetAdminLogsPending(
        '${AppParams.dateQuery(first)}${AppParams.logTypeQuery(LogType.timelog)}'));
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    firstDate = first;
    store.dispatch(GetAdminLogsPending(
        '${AppParams.dateQuery(first)}${AppParams.logTypeQuery(LogType.all)}'));
    store.dispatch(GetAdminLogByDatePending(
        '${AppParams.dateQuery(DateTime.now())}?${AppQuery.logTypeQuery(LogType.all)}'));
  }

  Future<bool> _onBackPressed() async {
    await SystemNavigator.pop();
    return true;
  }
}
