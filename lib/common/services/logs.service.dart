import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> getLogs(String query) async {
  print('logs by month');
  print('/logs$query');
  final Response<dynamic> res = await api.dio.get<dynamic>('/logs/$query');
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

Future<List<LogModel>> getLogsByDate(String query) async {
  print('logs by date');
  print('/logs/solo/$query');
  final Response<dynamic> res = await api.dio.get<dynamic>('/logs/solo/$query');
  final List<dynamic> logs = res.data['logs'] as List<dynamic>;
  return logs.isEmpty
      ? <LogModel>[]
      : logs
          .map<LogModel>(
              (dynamic log) => LogModel.fromJson(log as Map<String, dynamic>))
          .toList();
}

Future<LogModel> addLog(LogModel log) async {
  print(log.toJson());
  final Response<dynamic> res = await api.dio
      .post<dynamic>('/timelogs/${log.project.id}', data: log.toJson());
  final Map<String, dynamic> addedLog =
      res.data['logs'] as Map<String, dynamic>;
  return LogModel.fromJson(addedLog);
}
