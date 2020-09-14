import 'package:company_id_new/common/services/projects.service.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> getProjectsEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetProjectsPending)
      .switchMap((dynamic action) =>
          Stream<List<ProjectModel>>.fromFuture(getProjects())
              .map((List<ProjectModel> projects) {
            print(projects);
            return GetProjectsSuccess(projects);
          }));
}
