import 'package:company_id_new/store/models/admin-filter.model.dart';
import 'package:company_id_new/store/models/calendar.model.dart';
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

class AppState {
  AppState(
      {this.isLoading,
      this.notify,
      this.users,
      this.title,
      this.user,
      this.adminFilter,
      this.holidays,
      this.adminLogs,
      this.adminLogsByDate,
      this.projects,
      this.project,
      this.currentUser,
      this.adminStatistic});
  bool isLoading;
  String title;
  List<ProjectModel> projects;
  ProjectModel project;
  UserModel user;
  NotifyModel notify;
  List<LogModel> adminLogsByDate;
  UserModel currentUser;
  StatisticModel adminStatistic;
  AdminFilterModel adminFilter;
  List<UserModel> users;
  Map<DateTime, List<CalendarModel>> holidays;
  Map<DateTime, List<CalendarModel>> adminLogs;
}

AppState appStateReducer(AppState state, dynamic action) => AppState(
    isLoading: loadingReducers(state.isLoading, action),
    adminFilter: adminFilterReducers(state.adminFilter, action),
    title: titleReducer(state.title, action),
    holidays: holidaysReducers(state.holidays, action),
    project: projectReducers(state.project, action),
    projects: projectsReducers(state.projects, action),
    users: usersReducers(state.users, action),
    currentUser: userReducers(state.currentUser, action),
    adminLogsByDate: adminByDateReducers(state.adminLogsByDate, action),
    adminStatistic: adminStatisticReducers(state.adminStatistic, action),
    adminLogs: adminLogsReducer(state.adminLogs, action),
    user: authReducers(state.user, action),
    notify: notifyReducers(state.notify, action));
