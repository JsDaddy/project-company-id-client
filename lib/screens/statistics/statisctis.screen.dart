import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/helpers/app-query.dart';
import 'package:company_id_new/common/widgets/calendar/calendar.widget.dart';
import 'package:company_id_new/common/widgets/event-list/event-list.widget.dart';
import 'package:company_id_new/common/widgets/event-markers/event-markers.widget.dart';
import 'package:company_id_new/screens/statistics/add-edit-timelog/add-edit-timelog.widget.dart';
import 'package:company_id_new/screens/statistics/filter/filter.widget.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/models/filter.model.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:redux/redux.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:company_id_new/common/helpers/app-images.dart';
import 'package:company_id_new/store/models/current-day.model.dart';
import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/store/models/user.model.dart';

class _ViewModel {
  _ViewModel({
    this.logs,
    this.statistic,
    this.currentDate,
    this.filter,
    this.holidays,
  });
  Map<DateTime, List<CalendarModel>> logs;
  Map<DateTime, List<CalendarModel>> holidays;
  CurrentDateModel currentDate;
  FilterModel filter;
  StatisticModel statistic;
}

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  CalendarController _calendarController;
  String logType = AppConverting.getTypeLogQuery(LogType.all);
  String vacQuery = '';
  String userQuery = '';
  String projectQuery = '';
  List<String> queries = <String>[];
  String fullQuery = '';
  List<SpeedDialChild> speedDials = <SpeedDialChild>[];
  @override
  void initState() {
    speedDials = <SpeedDialChild>[
      speedDialChild(
          () {},
          // () => showModalBottomSheet<dynamic>(
          //     context: context,
          //     useRootNavigator: true,
          //     isScrollControlled: true,
          //     builder: (BuildContext context) =>
          //         AddVacationDialogWidget(
          //           choosedDate: state.currentDay,
          //         )),
          const Icon(Icons.snooze)),
      speedDialChild(
          () => showModalBottomSheet<dynamic>(
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              builder: (BuildContext ontext) => AddEditTimelogDialogWidget(
                    choosedDate: store.state.currentDate.currentDay,
                  )),
          const Icon(Icons.alarm_add))
    ];
    if (store.state.user.position == Positions.OWNER) {
      speedDials.add(speedDialChild(() async {
        //TODO REDUX !
        final FilterModel filter = await showModalBottomSheet<FilterModel>(
            context: context,
            useRootNavigator: true,
            builder: (BuildContext context) => AdminLogFilterWidget());
        queries = <String>[];
        fullQuery = '';
        if (filter != null) {
          logType = AppConverting.getTypeLogQuery(filter.logType.logType);
          vacQuery = AppQuery.vacationTypeQuery(filter.logType.vacationType);
          queries.add(vacQuery);
          if (filter.user != null) {
            userQuery = 'uid=${filter.user.id}';
            queries.add(userQuery);
          }

          if (filter.project != null) {
            projectQuery = 'project=${filter.project.id}';
            queries.add(projectQuery);
          }
          getFullQuery();
          store.dispatch(SaveFilter(filter));
        }
        store.dispatch(GetLogsPending(
            '${store.state.currentDate.currentMohth}/$logType$fullQuery'));
        store.dispatch(GetLogByDatePending(
            '${store.state.currentDate.currentDay}/$logType$fullQuery'));
      },
          Stack(
            children: <Widget>[
              Center(
                child: Image.asset(AppImages.filter,
                    width: 24, height: 24, color: Colors.white),
              ),
            ],
          )));
    }
    _calendarController = CalendarController();

    if (vacQuery.isNotEmpty) {
      queries.add(vacQuery);
    }
    if (userQuery.isNotEmpty) {
      queries.add(userQuery);
    }

    if (projectQuery.isNotEmpty) {
      queries.add(projectQuery);
    }
    getFullQuery();
    super.initState();
  }

  String getFullQuery() {
    if (queries.isNotEmpty) {
      for (int i = 0; i < queries.length; i++) {
        if (i == 0) {
          fullQuery = '?${queries[i]}';
        } else {
          fullQuery = '$fullQuery&${queries[i]}';
        }
      }
    }
    return fullQuery;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onBackPressed(),
        child: StoreConnector<AppState, _ViewModel>(
            converter: (Store<AppState> store) => _ViewModel(
                statistic: store.state.statistic,
                currentDate: store.state.currentDate,
                holidays: store.state.holidays,
                filter: store.state.filter,
                logs: store.state.logs),
            builder: (BuildContext context, _ViewModel state) {
              return Scaffold(
                floatingActionButton: SpeedDial(
                  child: const Icon(Icons.menu),
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  curve: Curves.bounceIn,
                  animatedIcon: AnimatedIcons.menu_close,
                  animatedIconTheme: const IconThemeData(size: 22.0),
                  overlayColor: Colors.black,
                  overlayOpacity: 0.5,
                  children: speedDials,
                ),
                body: CalendarWidget(
                  headerSubTitle: state.filter?.user != null &&
                          state.filter.project == null &&
                          state.filter.logType.logType != LogType.vacation
                      ? '\n ${state.statistic.workedOut} / ${state.statistic.toBeWorkedOut} / ${state.statistic.overtime} '
                      : '',
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
                  buildEventList: EventListWidget(),
                ),
              );
            }));
  }

  void _onDaySelected(DateTime day, List<dynamic> events) {
    store.dispatch(SetCurrentDay(day));
    if (store.state.user.position == Positions.DEVELOPER) {
      store
          .dispatch(GetLogByDatePending('$day/all?uid=${store.state.user.id}'));
    } else {
      store.dispatch(GetLogByDatePending('$day/$logType$fullQuery'));
    }
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    store.dispatch(SetCurrentMonth(first));
    if (store.state.user.position == Positions.DEVELOPER) {
      store.dispatch(GetLogsPending('$first/all?uid=${store.state.user.id}'));
    } else {
      store.dispatch(GetLogsPending('$first/$logType$fullQuery'));
    }
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    store.dispatch(SetCurrentMonth(first));
    if (store.state.user.position == Positions.DEVELOPER) {
      store.dispatch(GetLogsPending('$first/all?uid=${store.state.user.id}'));
      store.dispatch(GetLogByDatePending(
          '${store.state.currentDate.currentDay}/all?uid=${store.state.user.id}'));
    } else {
      store.dispatch(GetLogsPending(
          '${store.state.currentDate.currentMohth}/$logType$fullQuery'));
      store.dispatch(
          GetLogByDatePending('${DateTime.now()}/$logType$fullQuery'));
    }
  }

  Future<bool> _onBackPressed() async {
    await SystemNavigator.pop();
    return true;
  }

  SpeedDialChild speedDialChild(Function func, Widget icon) {
    return SpeedDialChild(
        child: icon, backgroundColor: AppColors.red, onTap: () => func());
  }
}
