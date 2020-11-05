import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:redux/redux.dart';

final Reducer<List<ProjectModel>> projectsReducers =
    combineReducers<List<ProjectModel>>(<
        List<ProjectModel> Function(List<ProjectModel>, dynamic)>[
  TypedReducer<List<ProjectModel>, GetProjectsSuccess>(_setProjects),
  TypedReducer<List<ProjectModel>, CreateProjectSuccess>(_createProject),
]);

List<ProjectModel> _setProjects(
    List<ProjectModel> title, GetProjectsSuccess action) {
  return action.projects;
}

List<ProjectModel> _createProject(
    List<ProjectModel> projects, CreateProjectSuccess action) {
  projects.add(action.project);
  return projects;
}

final Reducer<ProjectModel> projectReducers = combineReducers<
    ProjectModel>(<ProjectModel Function(ProjectModel, dynamic)>[
  TypedReducer<ProjectModel, GetDetailProjectSuccess>(_setProject),
  TypedReducer<ProjectModel, AddUserToProjectSuccess>(_addUserToProject),
  TypedReducer<ProjectModel, ClearDetailProject>(_clearProject),
  TypedReducer<ProjectModel, RemoveUserFromProjectSuccess>(
      _removeUserFromProject),
]);

ProjectModel _setProject(ProjectModel project, GetDetailProjectSuccess action) {
  return action.project;
}

ProjectModel _clearProject(ProjectModel project, ClearDetailProject action) {
  return null;
}

ProjectModel _addUserToProject(
    ProjectModel project, AddUserToProjectSuccess action) {
  if (!action.isActive) {
    project.history.add(action.user);
  }
  project.onboard.add(action.user);
  return project;
}

ProjectModel _removeUserFromProject(
    ProjectModel project, RemoveUserFromProjectSuccess action) {
  project.onboard
      .removeWhere((UserModel userOnBoard) => userOnBoard.id == action.user.id);
  return project;
}

final Reducer<String> lastProjectReducers =
    combineReducers<String>(<String Function(String, dynamic)>[
  TypedReducer<String, GetProjectPrefSuccess>(_getLastProject),
  TypedReducer<String, SetProjectPrefSuccess>(_setLastProject),
]);
String _getLastProject(String state, GetProjectPrefSuccess action) {
  return action.lastProjectId;
}

String _setLastProject(String state, SetProjectPrefSuccess action) {
  return action.lastProjectId;
}

final Reducer<List<ProjectModel>> absentProjectsReducers =
    combineReducers<List<ProjectModel>>(<
        List<ProjectModel> Function(List<ProjectModel>, dynamic)>[
  TypedReducer<List<ProjectModel>, GetAbsentProjectsSuccess>(
      _setAbsentProjects),
]);

List<ProjectModel> _setAbsentProjects(
    List<ProjectModel> title, GetAbsentProjectsSuccess action) {
  return action.absentProjects;
}
