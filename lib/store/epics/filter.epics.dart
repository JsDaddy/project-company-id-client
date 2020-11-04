import 'package:company_id_new/common/services/filter.service.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> filteredUsersEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetLogsFilterUsersPending)
      .switchMap((dynamic action) => Stream<List<UserModel>>.fromFuture(
              getFilteredUsers(action.projectId as String))
          .map((List<UserModel> users) => GetLogsFilterUsersSuccess(users)))
      .handleError((dynamic e) {
    s.store.dispatch(Notify(NotifyModel(NotificationType.error,
        e.message as String ?? 'Something went wrong')));
    return GetLogsFilterUsersError();
  });
}

Stream<void> filteredProjectsEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetLogsFilterProjectsPending)
      .switchMap((dynamic action) => Stream<List<ProjectModel>>.fromFuture(
              getFilteredProjects(action.userId as String))
          .map((List<ProjectModel> projects) =>
              GetLogsFilterProjectsSucess(projects)))
      .handleError((dynamic e) {
    s.store.dispatch(Notify(NotifyModel(NotificationType.error,
        e.message as String ?? 'Something went wrong')));
    return GetLogsFilterProjectsError();
  });
}
