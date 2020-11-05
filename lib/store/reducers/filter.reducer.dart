import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/models/log-filter.model.dart';
import 'package:company_id_new/store/models/filter-users-projects-logs.model.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

final Reducer<LogFilterModel> filterReducers = combineReducers<
    LogFilterModel>(<LogFilterModel Function(LogFilterModel, dynamic)>[
  TypedReducer<LogFilterModel, SaveLogFilter>(_saveLogFilter),
  TypedReducer<LogFilterModel, ClearLogFilter>(_clearLogFilter),
]);

LogFilterModel _saveLogFilter(LogFilterModel title, SaveLogFilter action) {
  return action.adminFilter;
}

LogFilterModel _clearLogFilter(LogFilterModel state, ClearLogFilter action) {
  return null;
}

final Reducer<FilterLogsUsersProjects> filterLogsUserProjectsFilterReducers =
    combineReducers<FilterLogsUsersProjects>(<
        FilterLogsUsersProjects Function(FilterLogsUsersProjects, dynamic)>[
  TypedReducer<FilterLogsUsersProjects, GetLogsFilterProjectsSucess>(
      _saveLogsProjectsFilter),
  TypedReducer<FilterLogsUsersProjects, GetLogsFilterUsersSuccess>(
      _saveLogsUserFilter),
  TypedReducer<FilterLogsUsersProjects, ClearLogFilterLogsUsersProjects>(
      _clearLogsProjectsFilter),
]);

FilterLogsUsersProjects _saveLogsProjectsFilter(
    FilterLogsUsersProjects state, GetLogsFilterProjectsSucess action) {
  return state.copyWith(projects: action.projects);
}

FilterLogsUsersProjects _clearLogsProjectsFilter(
    FilterLogsUsersProjects state, ClearLogFilterLogsUsersProjects action) {
  return FilterLogsUsersProjects(
      projects: <ProjectModel>[], users: <UserModel>[]);
}

FilterLogsUsersProjects _saveLogsUserFilter(
    FilterLogsUsersProjects state, GetLogsFilterUsersSuccess action) {
  return state.copyWith(users: action.users);
}
