import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/models/filter.model.dart';
import 'package:company_id_new/store/models/filter-users-projects-logs.model.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

final Reducer<FilterModel> filterReducers =
    combineReducers<FilterModel>(<FilterModel Function(FilterModel, dynamic)>[
  TypedReducer<FilterModel, SaveFilter>(_saveFilter),
  TypedReducer<FilterModel, ClearFilter>(_clearFilter),
]);

FilterModel _saveFilter(FilterModel title, SaveFilter action) {
  return action.adminFilter;
}

FilterModel _clearFilter(FilterModel state, ClearFilter action) {
  return null;
}

final Reducer<FilterLogsUsersProjects> filterLogsUserProjectsFilterReducers =
    combineReducers<FilterLogsUsersProjects>(<
        FilterLogsUsersProjects Function(FilterLogsUsersProjects, dynamic)>[
  TypedReducer<FilterLogsUsersProjects, GetLogsFilterProjectsSucess>(
      _saveLogsProjectsFilter),
  TypedReducer<FilterLogsUsersProjects, GetLogsFilterUsersSuccess>(
      _saveLogsUserFilter),
  TypedReducer<FilterLogsUsersProjects, ClearFilterLogsUsersProjects>(
      _clearLogsProjectsFilter),
]);

FilterLogsUsersProjects _saveLogsProjectsFilter(
    FilterLogsUsersProjects state, GetLogsFilterProjectsSucess action) {
  return state.copyWith(projects: action.projects);
}

FilterLogsUsersProjects _clearLogsProjectsFilter(
    FilterLogsUsersProjects state, ClearFilterLogsUsersProjects action) {
  return FilterLogsUsersProjects(
      projects: <ProjectModel>[], users: <UserModel>[]);
}

FilterLogsUsersProjects _saveLogsUserFilter(
    FilterLogsUsersProjects state, GetLogsFilterUsersSuccess action) {
  return state.copyWith(users: action.users);
}
