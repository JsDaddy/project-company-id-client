import 'package:company_id_new/common/helpers/app-constants.dart';
import 'package:company_id_new/common/services/projects.service.dart';
import 'package:company_id_new/common/services/refresh.service.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/common/services/local-storage.service.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> getProjectsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetProjectsPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<ProjectModel>>.fromFuture(getProjects(
                  action.projectTypes as ProjectsType,
                  action.userId as String,
                  s.store.state.projectsFilter))
              .map<dynamic>((List<ProjectModel> projects) {
            refresh.refreshController.refreshCompleted();
            switch (action.projectTypes as ProjectsType) {
              case ProjectsType.Default:
                return GetProjectsSuccess(projects);
              case ProjectsType.Filter:
                return GetLogsFilterProjectsSucess(projects);
              case ProjectsType.AddTimelog:
                return GetActiveProjectsByUserSuccess(projects);
              case ProjectsType.Absent:
                return GetAbsentProjectsSuccess(
                    projects, action.projectTypes as ProjectsType);
              default:
                return null;
            }
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetProjectsError());
          }));
}

Stream<void> getDetailProjectEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetDetailProjectPending)
      .switchMap<dynamic>((dynamic action) => Stream<ProjectModel>.fromFuture(
                  getDetailProject(action.projectId as String))
              .map<dynamic>((ProjectModel project) {
            refresh.refreshController.refreshCompleted();
            return GetDetailProjectSuccess(project);
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetDetailProjectError());
          }));
}

Stream<void> createProjectEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is CreateProjectPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<void>.fromFuture(createProject(action.project as ProjectModel))
              .expand<dynamic>((_) {
            return <dynamic>[
              CreateProjectSuccess(),
              GetProjectsPending(),
              SetClearTitle('Projects'),
              PopUntilFirst()
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(CreateProjectError());
          }));
}

Stream<dynamic> getLastProjectEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetProjectPrefPending)
      .switchMap<dynamic>((dynamic action) => Stream<String>.fromFuture(
                  localStorageService.getData<String>(AppConstants.lastProject))
              .map<dynamic>((String id) {
            return GetProjectPrefSuccess(id);
          }));
}

Stream<dynamic> setLastProjectEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is SetProjectPrefPending)
      .switchMap<dynamic>((dynamic action) => Stream<bool>.fromFuture(
                  localStorageService.saveData(
                      AppConstants.lastProject, action.lastProjectId as String))
              .map<dynamic>((_) {
            return SetProjectPrefSuccess(action.lastProjectId as String);
          }));
}

Stream<void> addUserToProjectEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is AddUserToProjectPending)
      .switchMap<dynamic>((dynamic action) => Stream<UserModel>.fromFuture(
                  addUserToProject(action.user as UserModel,
                      action.project as ProjectModel, action.isActive as bool))
              .expand<dynamic>((UserModel user) => <dynamic>[
                    action.isAddedUserToProject as bool
                        ? AddUserToProjectSuccess(
                            action.isActive as bool
                                ? action.user as UserModel
                                : user,
                            action.isActive as bool)
                        : AddProjectToUserSuccess(
                            action.project as ProjectModel,
                          ),
                    Notify(NotifyModel(NotificationType.Success,
                        'User has been added to the project')),
                  ])
              .handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(AddUserToProjectError());
          }));
}

Stream<void> removeUserFromProjectEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is RemoveUserFromProjectPending)
      .switchMap<dynamic>((dynamic action) => Stream<void>.fromFuture(
                  removeUserFromActiveProject(
                      action.user as UserModel, action.projectId as String))
              .expand<dynamic>((_) => <dynamic>[
                    RemoveUserFromProjectSuccess(action.user as UserModel),
                    Notify(NotifyModel(NotificationType.Success,
                        'User has been removed from the project')),
                  ])
              .handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(RemoveUserFromProjectError());
          }));
}

Stream<void> archiveProjectEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is ArchiveProjectPending)
      .switchMap<dynamic>((dynamic action) => Stream<void>.fromFuture(
                  archiveProject(
                      action.id as String, action.status as ProjectStatus))
              .expand<dynamic>((_) {
            return <dynamic>[
              GetProjectsPending(),
              Notify(NotifyModel(
                  NotificationType.Success,
                  action.status == ProjectStatus.Finished
                      ? 'Project has been finished'
                      : 'Project has been rejected')),
              ArchiveProjectSuccess(),
            ];
          }).handleError((dynamic e) {
            print(e);
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(ArchiveProjectError());
          }));
}
