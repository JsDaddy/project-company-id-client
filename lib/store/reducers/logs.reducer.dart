import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:redux/redux.dart';

final Reducer<Map<DateTime, List<CalendarModel>>> adminLogsReducer =
    combineReducers<Map<DateTime, List<CalendarModel>>>(<
        Map<DateTime, List<CalendarModel>> Function(
            Map<DateTime, List<CalendarModel>>, dynamic)>[
  TypedReducer<Map<DateTime, List<CalendarModel>>, GetAdminLogsSuccess>(
      _saveAdminLogs),
]);

Map<DateTime, List<CalendarModel>> _saveAdminLogs(
    Map<DateTime, List<CalendarModel>> adminLogs, GetAdminLogsSuccess action) {
  return action.logs;
}

final Reducer<StatisticModel> adminStatisticReducers = combineReducers<
    StatisticModel>(<StatisticModel Function(StatisticModel, dynamic)>[
  TypedReducer<StatisticModel, GetAdmingStatisticSuccess>(_saveAdminStatistic)
]);

StatisticModel _saveAdminStatistic(
    StatisticModel adminLogs, GetAdmingStatisticSuccess action) {
  return action.statistic;
}

final Reducer<Map<DateTime, List<CalendarModel>>> holidaysReducers =
    combineReducers<Map<DateTime, List<CalendarModel>>>(<
        Map<DateTime, List<CalendarModel>> Function(
            Map<DateTime, List<CalendarModel>>, dynamic)>[
  TypedReducer<Map<DateTime, List<CalendarModel>>, GetHolidaysLogsSuccess>(
      _saveHolidays),
]);

Map<DateTime, List<CalendarModel>> _saveHolidays(
    Map<DateTime, List<CalendarModel>> holidays,
    GetHolidaysLogsSuccess action) {
  final Map<DateTime, List<CalendarModel>> newHolidays =
      <DateTime, List<CalendarModel>>{};
  for (final MapEntry<DateTime, List<CalendarModel>> log
      in action.holidays.entries) {
    if (log.value.firstWhere((CalendarModel log) => log.holiday != null,
            orElse: () => null) !=
        null) {
      newHolidays.addAll(<DateTime, List<CalendarModel>>{log.key: log.value});
    }
  }
  return newHolidays;
}
