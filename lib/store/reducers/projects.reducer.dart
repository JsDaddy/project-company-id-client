import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:redux/redux.dart';

final Reducer<List<ProjectModel>> projectsReducers =
    combineReducers<List<ProjectModel>>(<
        List<ProjectModel> Function(List<ProjectModel>, dynamic)>[
  TypedReducer<List<ProjectModel>, GetProjectsSuccess>(_setProjects),
]);

List<ProjectModel> _setProjects(
    List<ProjectModel> title, GetProjectsSuccess action) {
  return action.projects;
}

final Reducer<ProjectModel> projectReducers = combineReducers<
    ProjectModel>(<ProjectModel Function(ProjectModel, dynamic)>[
  TypedReducer<ProjectModel, GetDetailProjectSuccess>(_setProject),
  TypedReducer<ProjectModel, ClearDetailProject>(_clearProject),
]);

ProjectModel _setProject(ProjectModel project, GetDetailProjectSuccess action) {
  return action.project;
}

ProjectModel _clearProject(ProjectModel project, ClearDetailProject action) {
  return null;
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
