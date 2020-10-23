import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:dio/dio.dart';

Future<List<ProjectModel>> getProjects() async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/projects');
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
  final dynamic project = res.data;
  return ProjectModel.fromJson(project as Map<String, dynamic>);
}
