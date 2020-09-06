import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
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
  // return result.map<DateTime, List<LogModel>>((String key, dynamic value) =>
  //     MapEntry<DateTime, List<LogModel>>(
  //         DateTime.parse(key),
  //         value
  //             .map<LogModel>((dynamic item) =>
  //                 LogModel.fromJson(item as Map<String, dynamic>))
  //             .toList() as List<LogModel>));
  // print(finalRes);
  // return res.data.map<LogModel>((dynamic item) {
  //   return {res.data LogModel.fromJson(item as Map<String, dynamic>)};
  // }).toList() as List<LogModel>;
}
