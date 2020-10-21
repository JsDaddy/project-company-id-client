import 'package:company_id_new/store/epics/auth.epics.dart';
import 'package:company_id_new/store/epics/logs.epics.dart';
import 'package:company_id_new/store/epics/projects.epics.dart';
import 'package:company_id_new/store/epics/route.epics.dart';
import 'package:company_id_new/store/epics/users.epics.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

final Store<AppState> store = Store<AppState>(appStateReducer,
    initialState: AppState(
        isLoading: false,
        title: '',
        projects: <ProjectModel>[],
        adminLogsByDate: <LogModel>[],
        users: <UserModel>[]),
    // ignore: always_specify_types
    middleware: [
      LoggingMiddleware<dynamic>.printer(),
      EpicMiddleware<dynamic>(checkTokenEpic),
      EpicMiddleware<dynamic>(signInEpic),
      EpicMiddleware<dynamic>(routeEpic),
      EpicMiddleware<dynamic>(routePopEpic),
      EpicMiddleware<dynamic>(routePushReplacmentEpic),
      EpicMiddleware<dynamic>(getAdminLogByDateEpic),
      EpicMiddleware<dynamic>(setPasswordEpic),
      EpicMiddleware<dynamic>(getAdminLogsEpic),
      EpicMiddleware<dynamic>(usersEpic),
      EpicMiddleware<dynamic>(getProjectsEpic),
      EpicMiddleware<AppState>(userEpic),
    ]);
