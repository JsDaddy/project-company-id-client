import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> getLogs(String query) async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/logs$query');
  final Map<String, dynamic> logs = res.data['logs'] as Map<String, dynamic>;
  final Map<String, dynamic> statistics =
      res.data['statistic'] as Map<String, dynamic>;
  final Map<DateTime, List<CalendarModel>> mappedLogs =
      logs.map<DateTime, List<CalendarModel>>((String key, dynamic value) =>
          MapEntry<DateTime, List<CalendarModel>>(
              DateTime.parse(key),
              value
                  .map<CalendarModel>((dynamic item) =>
                      CalendarModel.fromJson(item as Map<String, dynamic>))
                  .toList() as List<CalendarModel>));
  final StatisticModel mappedStatistic = StatisticModel.fromJson(statistics);
  return <String, dynamic>{'logs': mappedLogs, 'statistic': mappedStatistic};
}

Future<List<LogModel>> getAdmingLogsByDate(String query) async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/logs/date$query');
  final List<dynamic> logs = res.data['logs'] as List<dynamic>;
  return logs.isEmpty
      ? <LogModel>[]
      : logs
          .map<LogModel>(
              (dynamic log) => LogModel.fromJson(log as Map<String, dynamic>))
          .toList();
}
