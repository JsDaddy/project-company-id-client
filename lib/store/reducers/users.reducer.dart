import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:redux/redux.dart';

final Reducer<List<UserModel>> usersReducers = combineReducers<
    List<UserModel>>(<List<UserModel> Function(List<UserModel>, dynamic)>[
  TypedReducer<List<UserModel>, GetUsersSuccess>(_setUsers),
  TypedReducer<List<UserModel>, ArchiveUserSuccess>(_archiveUser),
]);
List<UserModel> _archiveUser(List<UserModel> users, ArchiveUserSuccess action) {
  return users.map((UserModel user) {
    if (action.id == user.id) {
      user.endDate = action.date;
      return user;
    }
    return user;
  }).toList();
}

List<UserModel> _setUsers(List<UserModel> title, GetUsersSuccess action) {
  return action.users;
}

final Reducer<UserModel> userReducers =
    combineReducers<UserModel>(<UserModel Function(UserModel, dynamic)>[
  TypedReducer<UserModel, GetUserSuccess>(_setUser),
  TypedReducer<UserModel, RemoveProjectFromUserSuccess>(_removeProjectFromUser),
  TypedReducer<UserModel, AddProjectToUserSuccess>(_addProjectToUser),
]);

UserModel _setUser(UserModel user, GetUserSuccess action) {
  return action.user;
}

UserModel _removeProjectFromUser(
    UserModel user, RemoveProjectFromUserSuccess action) {
  user.activeProjects
      .removeWhere((ProjectModel project) => project.id == action.project.id);
  return user;
}

UserModel _addProjectToUser(UserModel user, AddProjectToUserSuccess action) {
  user.activeProjects.add(action.project);
  user.projects.add(action.project);
  return user;
}

final Reducer<List<UserModel>> absentUsersReducers = combineReducers<
    List<UserModel>>(<List<UserModel> Function(List<UserModel>, dynamic)>[
  TypedReducer<List<UserModel>, GetAbsentUsersSuccess>(_setAbsentUsers),
]);

List<UserModel> _setAbsentUsers(
    List<UserModel> title, GetAbsentUsersSuccess action) {
  return action.absentUsers;
}
