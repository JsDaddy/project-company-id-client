import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/common/helpers/enums.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:dio/dio.dart';

Future<LogModel> changeStatusVacation(String id, RequestStatus status) async {
  final String statusValue = getStringFromRequestStatus(status);
  final Response<dynamic> res =
      await api.dio.put<dynamic>('/vacations/$id', data: <String, dynamic>{
    'status': statusValue,
  });
  final Map<String, dynamic> vacation = res.data as Map<String, dynamic>;
  return LogModel.fromJson(vacation);
}
