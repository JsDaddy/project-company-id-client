import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:redux/redux.dart';

final Reducer<List<UserModel>> usersReducers = combineReducers<
    List<UserModel>>(<List<UserModel> Function(List<UserModel>, dynamic)>[
  TypedReducer<List<UserModel>, GetUsersSuccess>(_setUsers),
]);

List<UserModel> _setUsers(List<UserModel> title, GetUsersSuccess action) {
  return action.users;
}
