import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:dio/dio.dart';

Future<List<UserModel>> getUsers() async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/user');
  final List<dynamic> users = res.data as List<dynamic>;
  return users.isEmpty
      ? <UserModel>[]
      : users
          .map<UserModel>(
              (dynamic log) => UserModel.fromJson(log as Map<String, dynamic>))
          .toList();
}

Future<UserModel> getUser(String id) async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/user/$id');
  final Map<String, dynamic> user = res.data as Map<String, dynamic>;
  return UserModel.fromJson(user);
}

Future<void> addUserToProject(UserModel user, String projectId) async {
  await api.dio.post<dynamic>('/user/${user.id}/projects/$projectId');
}
