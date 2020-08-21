import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:dio/dio.dart';

Future<Map<DateTime, List<double>>> getLogs(String query) async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/logs$query');
  // print(res.data);
  final Map<String, dynamic> result = res.data as Map<String, dynamic>;
  return result.map<DateTime, List<double>>((String key, dynamic value) =>
      MapEntry<DateTime, List<double>>(
          DateTime.parse(key),
          value
              .map<double>((dynamic item) => item.toDouble() as double)
              .toList() as List<double>));
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
