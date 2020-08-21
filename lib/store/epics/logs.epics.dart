import 'package:company_id_new/common/services/logs.service.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> getAdminLogsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetAdminLogsPending)
      .switchMap((dynamic action) =>
          Stream<Map<DateTime, List<double>>>.fromFuture(
                  getLogs(action.query as String))
              .map<dynamic>((Map<DateTime, List<double>> logs) {
            return GetAdminLogsSuccess(logs);
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}
