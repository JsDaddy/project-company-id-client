import 'package:company_id_new/common/services/logs.service.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> getAdminLogsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetAdminLogsPending)
      .switchMap((dynamic action) => Stream<Map<String, dynamic>>.fromFuture(
                  getLogs(action.query as String))
              .expand<dynamic>((Map<String, dynamic> full) {
            return <dynamic>[
              GetAdminLogsSuccess(
                  full['logs'] as Map<DateTime, List<CalendarModel>>),
              GetHolidaysLogsSuccess(
                  full['logs'] as Map<DateTime, List<CalendarModel>>),
              GetAdmingStatisticSuccess(full['statistic'] as StatisticModel)
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}

Stream<void> getAdminLogByDateEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetAdminLogByDatePending)
      .switchMap((dynamic action) => Stream<List<LogModel>>.fromFuture(
                  getAdmingLogsByDate(action.query as String))
              .map<dynamic>((List<LogModel> logs) {
            return GetAdminLogByDateSuccess(logs);
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}
