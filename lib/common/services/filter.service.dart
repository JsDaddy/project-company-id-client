import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:dio/dio.dart';

Future<List<FilteredUserModel>> getFilteredUsers(String projectId) async {
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/filter/logs/users/$projectId');
  final List<dynamic> users = res.data as List<dynamic>;
  return users.isEmpty
      ? <FilteredUserModel>[]
      : users
          .map<FilteredUserModel>((dynamic log) =>
              FilteredUserModel.fromJson(log as Map<String, dynamic>))
          .toList();
}

Future<List<FilteredProjectModel>> getFilteredProjects(String userId) async {
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/filter/logs/projects/$userId');
  final List<dynamic> projects = res.data as List<dynamic>;
  return projects.isEmpty
      ? <FilteredProjectModel>[]
      : projects
          .map<FilteredProjectModel>((dynamic log) =>
              FilteredProjectModel.fromJson(log as Map<String, dynamic>))
          .toList();
}
