import 'package:company_id_new/common/services/filter.service.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> filteredLogUsersEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetLogsFilterUsersPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<UserModel>>.fromFuture(
                  getLogFilteredUsers(action.projectId as String))
              .map<dynamic>(
                  (List<UserModel> users) => GetLogsFilterUsersSuccess(users))
              .handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetLogsFilterUsersError());
          }));
}

Stream<void> filteredLogProjectsEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetLogsFilterProjectsPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<ProjectModel>>.fromFuture(
                  getFilteredProjects(action.userId as String))
              .map<dynamic>((List<ProjectModel> projects) =>
                  GetLogsFilterProjectsSucess(projects))
              .handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetLogsFilterProjectsError());
          }));
}

Stream<void> filteredProjectsUsersEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetProjectsFilterUsersPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<UserModel>>.fromFuture(
                  getProjectsFilteredUsers(action.stackId as String))
              .map<dynamic>((List<UserModel> users) =>
                  GetProjectsFilterUsersSuccess(users))
              .handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetProjectsFilterUsersError());
          }));
}

Stream<void> filteredProjectsStackEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetProjectsFilterStackPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<StackModel>>.fromFuture(
                  getProjectsFilteredStack(action.userId as String))
              .map<dynamic>((List<StackModel> stack) =>
                  GetProjectsFilterStackSuccess(stack))
              .handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetProjectsFilterStackError());
          }));
}
