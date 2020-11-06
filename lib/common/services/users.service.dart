import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/enums.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:dio/dio.dart';

Future<List<UserModel>> getUsers(UsersType usersType, String projectId) async {
  Response<dynamic> res;
  if (usersType == UsersType.Absent) {
    res = await api.dio.get<dynamic>('/user/absent/projects/$projectId');
  } else {
    res = await api.dio.get<dynamic>('/user');
  }
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

Future<DateTime> archiveUser(String id) async {
  final Response<dynamic> res = await api.dio.put<dynamic>('/user/$id');
  final Map<String, dynamic> user = res.data as Map<String, dynamic>;
  final DateTime endDate = DateTime.parse(user['endDate'] as String);
  return endDate;
}

Future<void> removeActiveProjectFromUser(
    ProjectModel project, String userId) async {
  await api.dio.delete<dynamic>('/user/$userId/active-project/${project.id}');
}

Future<void> addActiveProjectToUser(
    ProjectModel project, String userId, bool isActive) async {
  await api.dio
      .post<dynamic>('/user/$userId/projects-return/${project.id}/$isActive');
}
