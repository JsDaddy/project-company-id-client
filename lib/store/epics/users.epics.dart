import 'package:company_id_new/common/services/users.service.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> usersEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is GetUsersPending).switchMap(
      (dynamic action) => Stream<List<UserModel>>.fromFuture(getUsers())
          .map((List<UserModel> users) => GetUsersSuccess(users)));
}

Stream<void> userEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((dynamic action) => action is GetUserPending)
      .switchMap((dynamic action) =>
          Stream<UserModel>.fromFuture(getUser(action.id as String))
              .map((UserModel user) => GetUserSuccess(user)))
      .handleError((dynamic e) => print(e));
}
