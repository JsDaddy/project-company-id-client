import 'package:company_id_new/store/models/filter.model.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/filter-users-projects-logs.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/auth.reducer.dart';
import 'package:company_id_new/store/reducers/filter.reducer.dart';
import 'package:company_id_new/store/reducers/loading.reducer.dart';
import 'package:company_id_new/store/reducers/logs.reducer.dart';
import 'package:company_id_new/store/reducers/notify.reducer.dart';
import 'package:company_id_new/store/reducers/projects.reducer.dart';
import 'package:company_id_new/store/reducers/ui.reducer.dart';
import 'package:company_id_new/store/reducers/users.reducer.dart';
import 'package:company_id_new/store/models/current-day.model.dart';

import 'projects.reducer.dart';

class AppState {
  AppState(
      {this.isLoading,
      this.notify,
      this.users,
      this.title,
      this.user,
      this.filter,
      this.holidays,
      this.logs,
      this.logsByDate,
      this.projects,
      this.project,
      this.currentUser,
      this.lastProject,
      this.currentDate,
      this.filterLogsUsersProjects,
      this.statistic});
  bool isLoading;
  String lastProject;
  String title;
  List<ProjectModel> projects;
  List<ProjectModel> filterProjects;
  ProjectModel project;
  UserModel user;
  NotifyModel notify;
  List<LogModel> logsByDate;
  UserModel currentUser;
  StatisticModel statistic;
  FilterModel filter;
  List<UserModel> users;
  FilterLogsUsersProjects filterLogsUsersProjects;
  CurrentDateModel currentDate;
  List<UserModel> filterUsers;
  Map<DateTime, List<CalendarModel>> holidays;
  Map<DateTime, List<CalendarModel>> logs;
}

AppState appStateReducer(AppState state, dynamic action) => AppState(
    isLoading: loadingReducers(state.isLoading, action),
    filter: filterReducers(state.filter, action),
    title: titleReducer(state.title, action),
    filterLogsUsersProjects: filterLogsUserProjectsFilterReducers(
        state.filterLogsUsersProjects, action),
    holidays: holidaysReducers(state.holidays, action),
    project: projectReducers(state.project, action),
    lastProject: lastProjectReducers(state.lastProject, action),
    currentDate: currentDateReducers(state.currentDate, action),
    projects: projectsReducers(state.projects, action),
    users: usersReducers(state.users, action),
    currentUser: userReducers(state.currentUser, action),
    logsByDate: logsbyDateReducers(state.logsByDate, action),
    statistic: statisticReducers(state.statistic, action),
    logs: logsReducer(state.logs, action),
    user: authReducers(state.user, action),
    notify: notifyReducers(state.notify, action));
