import 'package:company_id_new/store/epics/auth.epics.dart';
import 'package:company_id_new/store/epics/filter.epics.dart';
import 'package:company_id_new/store/epics/logs.epics.dart';
import 'package:company_id_new/store/epics/projects.epics.dart';
import 'package:company_id_new/store/epics/route.epics.dart';
import 'package:company_id_new/store/epics/rules.epics.dart';
import 'package:company_id_new/store/epics/stack.epics.dart';
import 'package:company_id_new/store/epics/users.epics.dart';
import 'package:company_id_new/store/epics/vacations.epics.dart';
import 'package:company_id_new/store/models/current-day.model.dart';
import 'package:company_id_new/store/models/filter-projects-users-stack.model.dart';
import 'package:company_id_new/store/models/filter-users-projects-logs.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

final AppState initalState = AppState(
    isLoading: false,
    titles: <String>[],
    projects: <ProjectModel>[],
    logsByDate: <LogModel>[],
    requests: <LogModel>[],
    absentUsers: <UserModel>[],
    usersForCreatingProject: <UserModel>[],
    absentProjects: <ProjectModel>[],
    timelogProjects: <ProjectModel>[],
    currentDate: CurrentDateModel(
        currentDay: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0),
        currentMohth: DateTime(
            DateTime.now().year, DateTime.now().month, 1, DateTime.now().hour)),
    filterProjectsUsersStack:
        FilterProjectsUsersStack(stack: <StackModel>[], users: <UserModel>[]),
    filterLogsUsersProjects: FilterLogsUsersProjects(
        projects: <ProjectModel>[], users: <UserModel>[]),
    users: <UserModel>[]);
final Store<AppState> store =
    Store<AppState>(appStateReducer, initialState: initalState,

        // ignore: always_specify_types
        middleware: [
      LoggingMiddleware<dynamic>.printer(),
      EpicMiddleware<dynamic>(checkTokenEpic), //h
      EpicMiddleware<dynamic>(signInEpic), //h
      EpicMiddleware<dynamic>(logoutEpic), //h
      EpicMiddleware<dynamic>(routeEpic), //h
      EpicMiddleware<dynamic>(routePopEpic), //h
      EpicMiddleware<dynamic>(routePushReplacmentEpic), //h
      EpicMiddleware<dynamic>(routePopUntilEpic),
      EpicMiddleware<dynamic>(getLogByDateEpic), //h
      EpicMiddleware<dynamic>(setPasswordEpic),
      EpicMiddleware<dynamic>(getLogsEpic), //h
      EpicMiddleware<dynamic>(usersEpic), //h
      EpicMiddleware<dynamic>(getProjectsEpic), //h
      EpicMiddleware<dynamic>(getDetailProjectEpic), //h
      EpicMiddleware<AppState>(userEpic), //h
      EpicMiddleware<AppState>(getLastProjectEpic), //h
      EpicMiddleware<AppState>(setLastProjectEpic),
      EpicMiddleware<AppState>(addUserToProjectEpic),
      EpicMiddleware<AppState>(addLogEpic), //h
      EpicMiddleware<AppState>(editLogEpic), //h
      EpicMiddleware<AppState>(deleteLogEpic), //h
      EpicMiddleware<AppState>(getRequestsEpic), //h
      EpicMiddleware<AppState>(requestVacationEpic), //h
      EpicMiddleware<AppState>(changeStatusVacationEpic), //h
      EpicMiddleware<AppState>(filteredLogUsersEpic), //h
      EpicMiddleware<AppState>(filteredLogProjectsEpic), //h
      EpicMiddleware<AppState>(filteredProjectsUsersEpic), //h
      EpicMiddleware<AppState>(filteredProjectsStackEpic), //h
      EpicMiddleware<AppState>(getRulesEpic), //h
      EpicMiddleware<AppState>(removeUserFromProjectEpic),
      EpicMiddleware<AppState>(removeProjectFromUserEpic),
      EpicMiddleware<AppState>(archiveUserEpic),
      EpicMiddleware<AppState>(getStackEpic),
      EpicMiddleware<AppState>(createProjectEpic),
      EpicMiddleware<AppState>(archiveProjectEpic),
    ]);
