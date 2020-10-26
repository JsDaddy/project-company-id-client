import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/helpers/app-query.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/filter.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> getLogs(String date, FilterModel filter) async {
  final List<String> queriesArr = <String>[];
  String fullQuery = '';
  String logType = AppConverting.getTypeLogQuery(LogType.all);
  print('cxzcjkascdasdasdascascas');
  print(logType);
  if (filter?.user != null) {
    queriesArr.add(AppQuery.userQuery(filter.user.id));
  }
  if (filter?.project != null) {
    queriesArr.add(AppQuery.projectQuery(filter.project.id));
  }
  if (filter?.logType?.logType == LogType.vacation) {
    logType = AppConverting.getTypeLogQuery(LogType.vacation);
    queriesArr.add(AppQuery.vacationTypeQuery(filter.logType.vacationType));
  }
  for (final String query in queriesArr) {
    if (fullQuery.isEmpty) {
      fullQuery = '?$query';
    } else {
      fullQuery += '&$query';
    }
  }
  print(fullQuery);
  print('/logs/$date/$logType/$fullQuery');
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/logs/$date/$logType$fullQuery');
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

Future<List<LogModel>> getLogsByDate(String date, FilterModel filter) async {
  final List<String> queriesArr = <String>[];
  String fullQuery = '';
  String logType = AppConverting.getTypeLogQuery(LogType.all);

  if (filter?.user != null) {
    queriesArr.add(AppQuery.userQuery(filter.user.id));
  }
  if (filter?.project != null) {
    queriesArr.add(AppQuery.projectQuery(filter.project.id));
  }
  if (filter?.logType?.logType == LogType.vacation) {
    logType = AppConverting.getTypeLogQuery(LogType.vacation);
    queriesArr.add(AppQuery.vacationTypeQuery(filter.logType.vacationType));
  }
  for (final String query in queriesArr) {
    if (fullQuery.isEmpty) {
      fullQuery = '?$query';
    } else {
      fullQuery += '&$query';
    }
  }
  print(fullQuery);
  print('/logs/solo/$date$fullQuery');
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/logs/solo/$date/$logType$fullQuery');
  final List<dynamic> logs = res.data['logs'] as List<dynamic>;
  return logs.isEmpty
      ? <LogModel>[]
      : logs
          .map<LogModel>(
              (dynamic log) => LogModel.fromJson(log as Map<String, dynamic>))
          .toList();
}

Future<LogModel> addLog(LogModel log) async {
  final Response<dynamic> res = await api.dio
      .post<dynamic>('/timelogs/${log.project.id}', data: log.toJson());
  final Map<String, dynamic> addedLog =
      res.data['logs'] as Map<String, dynamic>;
  return LogModel.fromJson(addedLog);
}
