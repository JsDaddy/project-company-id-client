import 'package:company_id_new/common/services/filter.service.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> filteredUsersEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is FilteredUsersPending)
      .switchMap((dynamic action) => Stream<List<FilteredUserModel>>.fromFuture(
              getFilteredUsers(action.projectId as String))
          .map((List<FilteredUserModel> users) => FilteredUsersSuccess(users)))
      .handleError((dynamic e) => print(e));
}

Stream<void> filteredProjectsEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is FilteredProjectsPending)
      .switchMap((dynamic action) =>
          Stream<List<FilteredProjectModel>>.fromFuture(
                  getFilteredProjects(action.userId as String))
              .map((List<FilteredProjectModel> projects) =>
                  FilteredProjectsSuccess(projects)))
      .handleError((dynamic e) => print(e));
}
