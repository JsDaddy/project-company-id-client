import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/common/helpers/app-query.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/projects-filter.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:dio/dio.dart';

Future<List<ProjectModel>> getProjects(
    ProjectsType projectTypes, String uid, ProjectsFilterModel filter) async {
  Response<dynamic> res;
  if (projectTypes == ProjectsType.Absent) {
    res = await api.dio.get<dynamic>('/projects/absent/users/$uid');
  } else {
    final List<String> queriesArr = <String>[];
    String fullQuery = '';
    if (filter?.user?.id != null) {
      queriesArr.add(AppQuery.userQuery(filter.user.id));
    }
    if (filter?.stack?.id != null) {
      queriesArr.add(AppQuery.stackQuery(filter.stack.id));
    }
    if (filter?.spec?.title != null && filter.spec.getSpecQuery().isNotEmpty) {
      queriesArr.add(filter.spec.getSpecQuery());
    }
    if (filter?.status?.title != null &&
        filter.status.getStatusQuery().isNotEmpty) {
      queriesArr.add(filter.status.getStatusQuery());
    }
    for (final String query in queriesArr) {
      if (fullQuery.isEmpty) {
        fullQuery = '?$query';
      } else {
        fullQuery += '&$query';
      }
    }
    res = await api.dio.get<dynamic>('/projects$fullQuery');
  }
  final List<dynamic> projects = res.data as List<dynamic>;
  return projects.isEmpty
      ? <ProjectModel>[]
      : projects
          .map<ProjectModel>((dynamic project) =>
              ProjectModel.fromJson(project as Map<String, dynamic>))
          .toList();
}

Future<ProjectModel> getDetailProject(String projectId) async {
  final Response<dynamic> res =
      await api.dio.get<dynamic>('/projects/$projectId');
  final Map<String, dynamic> project = res.data as Map<String, dynamic>;
  return ProjectModel.fromJson(project);
}

Future<void> createProject(ProjectModel project) async {
  await api.dio.post<dynamic>('/projects', data: project.toJson());
}

Future<void> archiveProject(String id, String status) async {
  await api.dio.put<dynamic>('/projects/$id/$status');
}

Future<UserModel> addUserToProject(
    UserModel user, ProjectModel project, bool isActive) async {
  final Response<dynamic> res = await api.dio
      .post<dynamic>('/user/${user.id}/projects/${project.id}/$isActive');
  final Map<String, dynamic> newUser = res.data as Map<String, dynamic>;
  return UserModel.fromJson(newUser);
}

Future<void> removeUserFromActiveProject(
    UserModel user, String projectId) async {
  await api.dio.delete<dynamic>('/user/${user.id}/active-project/$projectId');
}
