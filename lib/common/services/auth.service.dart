import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:dio/dio.dart';

Future<UserModel> checkToken() async {
  final Response<dynamic> res = await api.dio.post<dynamic>('/auth/checktoken');
  return UserModel.fromJson(res.data as Map<String, dynamic>);
}
