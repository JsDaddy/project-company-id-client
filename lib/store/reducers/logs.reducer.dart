import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:redux/redux.dart';

final Reducer<Map<DateTime, List<double>>> adminLogsReducer =
    combineReducers<Map<DateTime, List<double>>>(<
        Map<DateTime, List<double>> Function(
            Map<DateTime, List<double>>, dynamic)>[
  TypedReducer<Map<DateTime, List<double>>, GetAdminLogsSuccess>(
      _saveAdminLogs),
]);

Map<DateTime, List<double>> _saveAdminLogs(
    Map<DateTime, List<double>> adminLogs, GetAdminLogsSuccess action) {
  return action.logs;
}
