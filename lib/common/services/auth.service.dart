import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:dio/dio.dart';

Future<UserModel> checkToken() async {
  final Response<dynamic> res = await api.dio.post<dynamic>('/auth/checktoken');
  return UserModel.fromJson(res.data as Map<String, dynamic>);
}

Future<UserModel> singIn(String email, String password) async {
  final Response<dynamic> res = await api.dio.post<dynamic>('/auth/signin',
      data: <String, dynamic>{'email': email, 'password': password});
  await api.localStorageService.saveTokenKey(res.data['accessToken'] as String);
  return UserModel.fromJson(res.data as Map<String, dynamic>);
}

Future<void> setPassword(String password) async {
  await api.dio.post<dynamic>('/auth/set-password',
      data: <String, dynamic>{'password': password});

  // return res.data;
  // if (res.statusCode == 200) {
  //   await api.localStorageService
  //       .saveTokenKey(res.data['accessToken'] as String);
  // }
  // return UserModel.fromJson(res.data as Map<String, dynamic>);
}
