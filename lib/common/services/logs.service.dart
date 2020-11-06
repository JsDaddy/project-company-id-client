import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/helpers/app-query.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/enums.model.dart';
import 'package:company_id_new/store/models/log-filter.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:company_id_new/store/store.dart';
import 'package:dio/dio.dart';

class StatisticLog {
  StatisticLog(this.fullQuery, this.logType);
  String fullQuery;
  String logType;
}

StatisticLog statisticLogs(LogFilterModel filter) {
  final List<String> queriesArr = <String>[];
  String fullQuery = '';
  String logType = AppConverting.getTypeLogQuery(LogType.all);
  if (store.state.user.position == Positions.DEVELOPER) {
    queriesArr.add(AppQuery.userQuery(store.state.user.id));
  }
  if (filter?.user?.id != null) {
    queriesArr.add(AppQuery.userQuery(filter.user.id));
  }
  if (filter?.project?.id != null) {
    queriesArr.add(AppQuery.projectQuery(filter.project.id));
  }

  if (filter?.logType?.logType != LogType.all &&
      filter?.logType?.logType != null) {
    logType = AppConverting.getTypeLogQuery(filter.logType?.logType);
    if (filter?.logType?.logType == LogType.vacation) {
      queriesArr.add(AppQuery.vacationTypeQuery(filter.logType?.vacationType));
    }
  }
  for (final String query in queriesArr) {
    if (fullQuery.isEmpty) {
      fullQuery = '?$query';
    } else {
      fullQuery += '&$query';
    }
  }
  return StatisticLog(fullQuery, logType);
}

Future<Map<String, dynamic>> getLogs(String date, LogFilterModel filter) async {
  final StatisticLog statLog = statisticLogs(filter);

  final Response<dynamic> res = await api.dio
      .get<dynamic>('/logs/$date/${statLog.logType}${statLog.fullQuery}');
  final Map<String, dynamic> logs = res.data['logs'] as Map<String, dynamic>;
  final Map<String, dynamic> statistics =
      res.data['statistic'] as Map<String, dynamic>;

  final Map<DateTime, List<CalendarModel>> mappedLogs =
      logs.map<DateTime, List<CalendarModel>>((String key, dynamic value) =>
          MapEntry<DateTime, List<CalendarModel>>(
              DateTime.parse(key),
              value.map<CalendarModel>((dynamic item) {
                return CalendarModel.fromJson(item as Map<String, dynamic>);
              }).toList() as List<CalendarModel>));
  final StatisticModel mappedStatistic = StatisticModel.fromJson(statistics);
  return <String, dynamic>{'logs': mappedLogs, 'statistic': mappedStatistic};
}

Future<LogResponse> getLogsByDate(String date, LogFilterModel filter) async {
  final StatisticLog statLog = statisticLogs(filter);
  final Response<dynamic> res = await api.dio
      .get<dynamic>('/logs/solo/$date/${statLog.logType}${statLog.fullQuery}');
  final Map<String, dynamic> logResponse = res.data as Map<String, dynamic>;
  return LogResponse.fromJson(logResponse);
}

Future<String> addLog(LogModel log) async {
  final Response<dynamic> res = await api.dio
      .post<dynamic>('/timelogs/${log.project.id}', data: log.toJson());
  final Map<String, dynamic> logResponse = res.data as Map<String, dynamic>;
  return logResponse['_id'] as String;
}

Future<LogModel> editLog(LogModel log) async {
  await api.dio.put<dynamic>('/timelogs/${log.id}', data: log.toJson());
  return log;
}

Future<String> deleteLog(String id) async {
  await api.dio.delete<dynamic>('/timelogs/$id');
  return id;
}

Future<void> requestVacation(LogModel vacation) async {
  await api.dio.post<dynamic>('/vacations', data: vacation.toVacJson());
}

Future<List<LogModel>> getRequests() async {
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/vacations/requests');

  final List<dynamic> requests = res.data as List<dynamic>;
  return requests.isEmpty
      ? <LogModel>[]
      : requests
          .map<LogModel>((dynamic request) =>
              LogModel.fromJson(request as Map<String, dynamic>))
          .toList();
}
