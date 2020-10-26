import 'package:company_id_new/store/epics/auth.epics.dart';
import 'package:company_id_new/store/epics/logs.epics.dart';
import 'package:company_id_new/store/epics/projects.epics.dart';
import 'package:company_id_new/store/epics/route.epics.dart';
import 'package:company_id_new/store/epics/users.epics.dart';
import 'package:company_id_new/store/models/filter-users-projects-logs.model.dart';
import 'package:company_id_new/store/models/filter.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

import 'models/current-day.model.dart';

final Store<AppState> store = Store<AppState>(appStateReducer,
    initialState: AppState(
        isLoading: false,
        title: '',
        projects: <ProjectModel>[],
        logsByDate: <LogModel>[],
        currentDate: CurrentDateModel(
            currentDay: DateTime.now(),
            currentMohth: DateTime(DateTime.now().year, DateTime.now().month, 1,
                DateTime.now().hour)),
        filterLogsUsersProjects: FilterLogsUsersProjects(
            projects: <ProjectModel>[], users: <UserModel>[]),
        users: <UserModel>[]),

    // ignore: always_specify_types
    middleware: [
      LoggingMiddleware<dynamic>.printer(),
      EpicMiddleware<dynamic>(checkTokenEpic),
      EpicMiddleware<dynamic>(signInEpic),
      EpicMiddleware<dynamic>(routeEpic),
      EpicMiddleware<dynamic>(routePopEpic),
      EpicMiddleware<dynamic>(routePushReplacmentEpic),
      EpicMiddleware<dynamic>(getLogByDateEpic),
      EpicMiddleware<dynamic>(setPasswordEpic),
      EpicMiddleware<dynamic>(getLogsEpic),
      EpicMiddleware<dynamic>(usersEpic),
      EpicMiddleware<dynamic>(getProjectsEpic),
      EpicMiddleware<dynamic>(getDetailProjectEpic),
      EpicMiddleware<AppState>(userEpic),
      EpicMiddleware<AppState>(addLogEpic),
      EpicMiddleware<AppState>(getLastProjectEpic),
      EpicMiddleware<AppState>(setLastProjectEpic),
    ]);
