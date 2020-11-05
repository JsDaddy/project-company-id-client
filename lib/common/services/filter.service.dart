import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:dio/dio.dart';

Future<List<UserModel>> getLogFilteredUsers(String projectId) async {
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/user/projects/$projectId');

  final List<dynamic> users = res.data as List<dynamic>;
  return users.isEmpty
      ? <UserModel>[]
      : users
          .map<UserModel>((dynamic user) =>
              UserModel.fromJson(user as Map<String, dynamic>))
          .toList();
}

Future<List<ProjectModel>> getFilteredProjects(String userId) async {
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/projects/users/$userId');

  final List<dynamic> projects = res.data as List<dynamic>;
  return projects.isEmpty
      ? <ProjectModel>[]
      : projects
          .map<ProjectModel>((dynamic project) =>
              ProjectModel.fromJson(project as Map<String, dynamic>))
          .toList();
}

Future<List<UserModel>> getProjectsFilteredUsers(String stackId) async {
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/user/stack/$stackId');

  final List<dynamic> users = res.data as List<dynamic>;
  return users.isEmpty
      ? <UserModel>[]
      : users
          .map<UserModel>((dynamic user) =>
              UserModel.fromJson(user as Map<String, dynamic>))
          .toList();
}

Future<List<StackModel>> getProjectsFilteredStack(String userId) async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/stack/$userId');

  final List<dynamic> stack = res.data as List<dynamic>;
  return stack.isEmpty
      ? <StackModel>[]
      : stack
          .map<StackModel>((dynamic stack) =>
              StackModel.fromJson(stack as Map<String, dynamic>))
          .toList();
}
