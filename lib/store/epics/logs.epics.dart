import 'package:company_id_new/common/services/logs.service.dart';
import 'package:company_id_new/common/services/refresh.service.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
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
            refresh.refreshController.refreshCompleted();
            return <dynamic>[
              GetLogsSuccess(
                  full['logs'] as Map<DateTime, List<CalendarModel>>),
              GetHolidaysLogsSuccess(
                  full['logs'] as Map<DateTime, List<CalendarModel>>),
              GetStatisticSuccess(full['statistic'] as StatisticModel)
            ];
          }).handleError((dynamic e) {
            // TODO: return aciton in error
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetLogsError());
          }));
}

Stream<void> getLogByDateEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetLogByDatePending)
      .switchMap((dynamic action) => Stream<LogResponse>.fromFuture(
                  getLogsByDate(action.date as String, s.store.state.filter))
              .expand<dynamic>((LogResponse logResponse) {
            refresh.refreshController.refreshCompleted();
            return <dynamic>[
              GetLogByDateSuccess(logResponse.logs),
              SetVacationSickAvail(VacationSickAvailable(
                  sickAvailable: logResponse.sickAvailable,
                  vacationAvailable: logResponse.vacationAvailable))
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetLogByDateError());
          }));
}

Stream<void> addLogEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is AddLogPending).switchMap(
      (dynamic action) =>
          Stream<String>.fromFuture(addLog(action.log as LogModel))
              .expand<dynamic>((String id) {
            (action.log as LogModel).id = id;
            return <dynamic>[
              Notify(NotifyModel(
                  NotificationType.Success, 'Timelog has been added')),
              AddLogSuccess(action.log as LogModel),
              GetLogsPending(s.store.state.currentDate.currentMohth.toString()),
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(AddLogError());
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
                  NotificationType.Success, 'Timelog has been edited')),
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(EditLogError());
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
                  NotificationType.Success, 'Timelog has been deleted')),
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(DeleteLogError());
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
                  NotificationType.Success, 'Request has been added')),
              PopAction(key: mainNavigatorKey)
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(RequestVacationError());
          }));
}

Stream<void> getRequestsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetRequestsPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<LogModel>>.fromFuture(getRequests())
              .map<dynamic>((List<LogModel> requests) {
            refresh.refreshController.refreshCompleted();
            return GetRequestsSuccess(requests);
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetRequestsError());
          }));
}
