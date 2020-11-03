import 'package:company_id_new/common/services/logs.service.dart';
import 'package:company_id_new/common/services/refresh.service.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> getLogsEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is GetLogsPending).switchMap(
      (dynamic action) => Stream<Map<String, dynamic>>.fromFuture(
                  getLogs(action.date as String, s.store.state.filter))
              .expand<dynamic>((Map<String, dynamic> full) {
            return <dynamic>[
              GetLogsSuccess(
                  full['logs'] as Map<DateTime, List<CalendarModel>>),
              GetHolidaysLogsSuccess(
                  full['logs'] as Map<DateTime, List<CalendarModel>>),
              GetStatisticSuccess(full['statistic'] as StatisticModel)
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> getLogByDateEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetLogByDatePending)
      .switchMap((dynamic action) => Stream<LogResponse>.fromFuture(
                  getLogsByDate(action.date as String, s.store.state.filter))
              .expand<dynamic>((LogResponse logResponse) {
            return <dynamic>[
              GetLogByDateSuccess(logResponse.logs),
              SetVacationSickAvail(VacationSickAvailable(
                  sickAvailable: logResponse.sickAvailable,
                  vacationAvailable: logResponse.vacationAvailable))
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> addLogEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is AddLogPending).switchMap(
      (dynamic action) =>
          Stream<LogModel>.fromFuture(addLog(action.log as LogModel))
              .expand<dynamic>((LogModel log) {
            return <dynamic>[
              AddLogSuccess(log),
              GetLogsPending(s.store.state.currentDate.currentMohth.toString()),
              Notify(NotifyModel(
                  NotificationType.success, 'Timelog has been added')),
              PopAction(key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> editLogEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is EditLogPending).switchMap(
      (dynamic action) =>
          Stream<LogModel>.fromFuture(editLog(action.log as LogModel))
              .expand<dynamic>((LogModel log) {
            return <dynamic>[
              EditLogSuccess(log),
              GetLogsPending(s.store.state.currentDate.currentMohth.toString()),
              Notify(NotifyModel(
                  NotificationType.success, 'Timelog has been edited')),
              PopAction(key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> deleteLogEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is DeleteLogPending)
      .switchMap((dynamic action) =>
          Stream<void>.fromFuture(deleteLog(action.id as String))
              .expand<dynamic>((_) {
            return <dynamic>[
              DeleteLogSuccess(action.id as String),
              GetLogsPending(s.store.state.currentDate.currentMohth.toString()),
              Notify(NotifyModel(
                  NotificationType.success, 'Timelog has been deleted')),
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> requestVacationEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is RequestVacationPending)
      .switchMap((dynamic action) =>
          Stream<void>.fromFuture(requestVacation(action.vacation as LogModel))
              .expand<dynamic>((_) {
            return <dynamic>[
              RequestVacationSuccess(action.vacation as LogModel),
              GetLogsPending(s.store.state.currentDate.currentMohth.toString()),
              Notify(NotifyModel(
                  NotificationType.success, 'Request has been added')),
              PopAction(key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> getRequestsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetRequestsPending)
      .switchMap((dynamic action) =>
          Stream<List<LogModel>>.fromFuture(getRequests())
              .map((List<LogModel> requests) {
            refresh.refreshController.refreshCompleted();
            return GetRequestsSuccess(requests);
          }))
      .handleError((dynamic e) => print(e));
}
