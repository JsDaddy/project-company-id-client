import 'package:company_id_new/common/services/logs.service.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import '../actions/logs.action.dart';
import '../actions/logs.action.dart';
import '../models/log.model.dart';

Stream<void> getLogsEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is GetLogsPending).switchMap(
      (dynamic action) => Stream<Map<String, dynamic>>.fromFuture(
                  getLogs(action.query as String))
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
      .switchMap((dynamic action) => Stream<List<LogModel>>.fromFuture(
                  getLogsByDate(action.query as String))
              .map<dynamic>((List<LogModel> logs) {
            return GetLogByDateSuccess(logs);
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> addLogEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is AddLogPending).switchMap(
      (dynamic action) =>
          Stream<LogModel>.fromFuture(addLog(action.log as LogModel))
              .map<dynamic>((LogModel log) {
            return AddLogSuccess(log);
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}
