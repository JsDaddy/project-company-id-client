import 'package:company_id_new/common/services/refresh.service.dart';
import 'package:company_id_new/common/widgets/calendar/calendar.widget.dart';
import 'package:company_id_new/common/widgets/event-list/event-list.widget.dart';
import 'package:company_id_new/common/widgets/event-markers/event-markers.widget.dart';
import 'package:company_id_new/common/widgets/notifier/notifier.widget.dart';
import 'package:company_id_new/screens/statistics/add-edit-timelog/add-edit-timelog.widget.dart';
import 'package:company_id_new/screens/statistics/add-vacation/add-vacation.widget.dart';
import 'package:company_id_new/screens/statistics/filter/filter.widget.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/models/badge.model.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/log-filter.model.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:company_id_new/common/helpers/app-images.dart';
import 'package:company_id_new/store/models/current-day.model.dart';
import 'package:company_id_new/common/helpers/app-colors.dart';

class _ViewModel {
  _ViewModel(
      {this.logs,
      this.statistic,
      this.currentDate,
      this.filter,
      this.holidays,
      this.user,
      this.logsByDate});
  Map<DateTime, List<CalendarModel>> logs;
  Map<DateTime, List<CalendarModel>> holidays;
  CurrentDateModel currentDate;
  LogFilterModel filter;
  StatisticModel statistic;
  List<LogModel> logsByDate;
  UserModel user;
}

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  CalendarController _calendarController;
  List<SpeedDialChild> speedDials = <SpeedDialChild>[];
  @override
  void initState() {
    speedDials = <SpeedDialChild>[
      speedDialChild(
          () => !_isExisted(store.state)
              ? showModalBottomSheet<dynamic>(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (BuildContext context) => AddVacationDialogWidget(
                        choosedDate: store.state.currentDate.currentDay,
                      ))
              : store.dispatch(Notify(NotifyModel(
                  NotificationType.Error, 'Only one vacation per day'))),
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
    if (store.state.user.position == Positions.Owner) {
      speedDials.add(speedDialChild(() async {
        final LogFilterModel filter =
            await showModalBottomSheet<LogFilterModel>(
                context: context,
                useRootNavigator: true,
                builder: (BuildContext context) => AdminLogFilterWidget());
        store.dispatch(SaveLogFilter(filter));
        store.dispatch(
            GetLogsPending('${store.state.currentDate.currentMohth}'));
        store.dispatch(
            GetLogByDatePending('${store.state.currentDate.currentDay}'));
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refresh.refreshController,
      onRefresh: () {
        store.dispatch(
            GetLogsPending('${store.state.currentDate.currentMohth}'));
        store.dispatch(
            GetLogByDatePending('${store.state.currentDate.currentDay}'));
      },
      enablePullDown: true,
      child: Notifier(
        child: WillPopScope(
            onWillPop: () => _onBackPressed(),
            child: StoreConnector<AppState, _ViewModel>(
                converter: (Store<AppState> store) => _ViewModel(
                    statistic: store.state.statistic,
                    currentDate: store.state.currentDate,
                    holidays: store.state.holidays,
                    filter: store.state.filter,
                    logs: store.state.logs,
                    user: store.state.user,
                    logsByDate: store.state.logsByDate),
                onWillChange: (_ViewModel prev, _ViewModel curr) {
                  if (prev.filter != curr.filter) {
                    _updateLogs(curr);
                  }
                },
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
                        headerSubTitle: state.filter?.user?.id != null &&
                                    state.filter.project == null &&
                                    state.filter.logType.logType !=
                                        LogType.Vacation ||
                                state.user.position == Positions.Developer
                            ? '\n ${state.statistic?.workedOut ?? ''} / ${state.statistic?.toBeWorkedOut ?? ''} / ${state.statistic?.overtime ?? ''} '
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
                              final List<BadgeModel> badges = <BadgeModel>[];
                              final CalendarModel calendar =
                                  events[0] as CalendarModel;
                              if (calendar.timelogs != null) {
                                badges.add(BadgeModel(
                                    AppColors.red, calendar.timelogs));
                              }
                              if (calendar.vacations != null) {
                                badges.add(BadgeModel(
                                    AppColors.green, calendar.vacations));
                              }
                              if (calendar.birthdays != null) {
                                badges.add(BadgeModel(AppColors.orange, ''));
                              }
                              children.add(
                                Positioned(
                                  right: 1,
                                  bottom: 1,
                                  child: EventMarkersWidget(badges),
                                ),
                              );
                            }
                            return children;
                          },
                        ),
                        onDaySelected: _onDaySelected,
                        buildEventList: EventListWidget()),
                  );
                })),
      ),
    );
  }

  void _onDaySelected(DateTime day, List<dynamic> events) {
    store.dispatch(SetCurrentDay(day));
    store.dispatch(GetLogByDatePending('$day'));
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    store.dispatch(SetCurrentMonth(first));
    store.dispatch(GetLogsPending('$first'));
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    store.dispatch(SetCurrentMonth(first));
    store.dispatch(GetLogsPending('${store.state.currentDate.currentMohth}'));
    store
        .dispatch(GetLogByDatePending('${store.state.currentDate.currentDay}'));
  }

  bool _isExisted(AppState state) {
    final String authId = state.user.id;
    return state.logsByDate.any(
        (LogModel log) => log.user.id == authId && log.vacationType != null);
  }

  Future<bool> _onBackPressed() async {
    await SystemNavigator.pop();
    return true;
  }

  SpeedDialChild speedDialChild(Function func, Widget icon) {
    return SpeedDialChild(
        child: icon, backgroundColor: AppColors.red, onTap: () => func());
  }

  void _updateLogs(_ViewModel state) {
    store.dispatch(GetLogsPending('${state.currentDate.currentMohth}'));
    store.dispatch(GetLogByDatePending('${state.currentDate.currentDay}'));
  }
}
