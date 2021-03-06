import 'package:company_id_new/common/services/refresh.service.dart';
import 'package:company_id_new/common/services/users.service.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> usersEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetUsersPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<UserModel>>.fromFuture(getUsers(
                  action.usersType as UsersType,
                  action.projectId as String,
                  action.isFired as bool))
              .map<dynamic>((List<UserModel> users) {
            refresh.refreshController.refreshCompleted();
            switch (action.usersType as UsersType) {
              case UsersType.CreateProject:
                return GetUsersForCreatingProjectSuccess(users);
              case UsersType.Default:
                return GetUsersSuccess(users);
              case UsersType.ProjectFilter:
                return GetProjectsFilterUsersSuccess(users);
              case UsersType.Filter:
                return GetLogsFilterUsersSuccess(users,
                    usersType: action.usersType as UsersType);
              case UsersType.Absent:
                return GetAbsentUsersSuccess(users);
              default:
                return null;
            }
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetUsersError());
          }));
}

Stream<void> userEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetUserPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<UserModel>.fromFuture(getUser(action.id as String))
              .map<dynamic>((UserModel user) {
            refresh.refreshController.refreshCompleted();
            return GetUserSuccess(user);
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetUserError());
          }));
}

Stream<void> archiveUserEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is ArchiveUserPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<DateTime>.fromFuture(archiveUser(action.id as String))
              .expand<dynamic>((DateTime dateTime) => <dynamic>[
                    Notify(NotifyModel(
                        NotificationType.Success, 'User has been archived')),
                    ArchiveUserSuccess(action.id as String, dateTime)
                  ])
              .handleError((dynamic e) {
            print(e);
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(ArchiveUserError());
          }));
}

Stream<void> removeProjectFromUserEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is RemoveProjectFromUserPending)
      .switchMap<dynamic>((dynamic action) {
    return Stream<void>.fromFuture(removeActiveProjectFromUser(
            action.project as ProjectModel, action.userId as String))
        .expand<dynamic>((_) => <dynamic>[
              RemoveProjectFromUserSuccess(action.project as ProjectModel),
              Notify(NotifyModel(NotificationType.Success,
                  'Project has been removed from the active projects')),
            ])
        .handleError((dynamic e) {
      s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
          e.message as String ?? 'Something went wrong')));
      s.store.dispatch(RemoveProjectFromUserError());
    });
  });
}
