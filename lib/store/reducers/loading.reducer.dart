import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/rules.action.dart';
import 'package:company_id_new/store/actions/vacations.action.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';

final Reducer<bool> loadingReducers =
    combineReducers<bool>(<bool Function(bool, dynamic)>[
  TypedReducer<bool, GetUsersPending>(_setTrue),
  TypedReducer<bool, GetUsersSuccess>(_setFalse),
  TypedReducer<bool, GetUsersError>(_setFalse),
  TypedReducer<bool, GetAbsentUsersSuccess>(_setFalse),
  TypedReducer<bool, GetUserPending>(_setTrue),
  TypedReducer<bool, GetUserSuccess>(_setFalse),
  TypedReducer<bool, GetUserError>(_setFalse),
  TypedReducer<bool, ArchiveUserPending>(_setTrue),
  TypedReducer<bool, ArchiveUserSuccess>(_setFalse),
  TypedReducer<bool, ArchiveUserError>(_setFalse),
  TypedReducer<bool, GetLogsPending>(_setTrue),
  TypedReducer<bool, GetLogsSuccess>(_setFalse),
  TypedReducer<bool, GetLogsError>(_setFalse),
  TypedReducer<bool, GetLogByDatePending>(_setTrue),
  TypedReducer<bool, GetLogByDateSuccess>(_setFalse),
  TypedReducer<bool, GetLogByDateError>(_setFalse),
  TypedReducer<bool, GetProjectsPending>(_setTrue),
  TypedReducer<bool, GetProjectsSuccess>(_setFalse),
  TypedReducer<bool, GetProjectsError>(_setFalse),
  TypedReducer<bool, GetAbsentProjectsSuccess>(_setFalse),
  TypedReducer<bool, GetDetailProjectPending>(_setTrue),
  TypedReducer<bool, GetDetailProjectSuccess>(_setFalse),
  TypedReducer<bool, GetDetailProjectError>(_setFalse),
  TypedReducer<bool, GetRulesPending>(_setTrue),
  TypedReducer<bool, GetRulesSuccess>(_setFalse),
  TypedReducer<bool, GetRulesError>(_setFalse),
  TypedReducer<bool, SignInPending>(_setTrue),
  TypedReducer<bool, SignInSuccess>(_setFalse),
  TypedReducer<bool, SignInError>(_setFalse),
  TypedReducer<bool, SetPasswordPending>(_setTrue),
  TypedReducer<bool, SetPasswordSuccess>(_setFalse),
  TypedReducer<bool, SetPasswordError>(_setFalse),
  TypedReducer<bool, AddLogPending>(_setTrue),
  TypedReducer<bool, AddLogSuccess>(_setFalse),
  TypedReducer<bool, AddLogError>(_setFalse),
  TypedReducer<bool, EditLogPending>(_setTrue),
  TypedReducer<bool, EditLogSuccess>(_setFalse),
  TypedReducer<bool, EditLogError>(_setFalse),
  TypedReducer<bool, DeleteLogPending>(_setTrue),
  TypedReducer<bool, DeleteLogSuccess>(_setFalse),
  TypedReducer<bool, DeleteLogError>(_setFalse),
  TypedReducer<bool, RequestVacationPending>(_setTrue),
  TypedReducer<bool, RequestVacationSuccess>(_setFalse),
  TypedReducer<bool, RequestVacationError>(_setFalse),
  TypedReducer<bool, GetRequestsPending>(_setTrue),
  TypedReducer<bool, GetRequestsSuccess>(_setFalse),
  TypedReducer<bool, GetRequestsError>(_setFalse),
  TypedReducer<bool, ChangeStatusVacationPending>(_setTrue),
  TypedReducer<bool, ChangeStatusVacationSuccess>(_setFalse),
  TypedReducer<bool, ChangeStatusVacationError>(_setFalse),
  TypedReducer<bool, GetLogsFilterUsersPending>(_setTrue),
  TypedReducer<bool, GetLogsFilterUsersSuccess>(_setFalse),
  TypedReducer<bool, GetLogsFilterUsersError>(_setFalse),
  TypedReducer<bool, GetLogsFilterProjectsPending>(_setTrue),
  TypedReducer<bool, GetLogsFilterProjectsSucess>(_setFalse),
  TypedReducer<bool, GetLogsFilterProjectsError>(_setFalse),
  TypedReducer<bool, RemoveUserFromProjectPending>(_setTrue),
  TypedReducer<bool, RemoveUserFromProjectSuccess>(_setFalse),
  TypedReducer<bool, RemoveUserFromProjectError>(_setFalse),
  TypedReducer<bool, AddUserToProjectPending>(_setTrue),
  TypedReducer<bool, AddUserToProjectSuccess>(_setFalse),
  TypedReducer<bool, AddUserToProjectError>(_setFalse),
  TypedReducer<bool, AddProjectToUserSuccess>(_setFalse),
  TypedReducer<bool, RemoveProjectFromUserPending>(_setTrue),
  TypedReducer<bool, RemoveProjectFromUserSuccess>(_setFalse),
  TypedReducer<bool, RemoveProjectFromUserError>(_setFalse),
  TypedReducer<bool, GetProjectPrefPending>(_setTrue),
  TypedReducer<bool, GetProjectPrefSuccess>(_setFalse),
  TypedReducer<bool, SetProjectPrefPending>(_setTrue),
  TypedReducer<bool, SetProjectPrefSuccess>(_setFalse),
  TypedReducer<bool, GetStatisticSuccess>(_setFalse),
  TypedReducer<bool, SetVacationSickAvail>(_setFalse),
]);
bool _setTrue(bool isLoading, dynamic action) {
  return true;
}

bool _setFalse(bool isLoading, dynamic action) {
  return false;
}
