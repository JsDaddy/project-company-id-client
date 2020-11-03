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
  TypedReducer<bool, GetUserPending>(_setTrue),
  TypedReducer<bool, GetUserSuccess>(_setFalse),
  TypedReducer<bool, GetLogsPending>(_setTrue),
  TypedReducer<bool, GetStatisticSuccess>(_setFalse),
  TypedReducer<bool, GetLogByDatePending>(_setTrue),
  TypedReducer<bool, SetVacationSickAvail>(_setFalse),
  TypedReducer<bool, GetProjectsPending>(_setTrue),
  TypedReducer<bool, GetLogsFilterProjectsSucess>(_setFalse),
  TypedReducer<bool, GetProjectsSuccess>(_setFalse),
  TypedReducer<bool, GetDetailProjectPending>(_setTrue),
  TypedReducer<bool, GetDetailProjectSuccess>(_setFalse),
  TypedReducer<bool, GetRulesPending>(_setTrue),
  TypedReducer<bool, GetRulesSuccess>(_setFalse),
  TypedReducer<bool, SignInPending>(_setTrue),
  TypedReducer<bool, SignInSuccess>(_setFalse),
  TypedReducer<bool, GetProjectPrefPending>(_setTrue),
  TypedReducer<bool, GetProjectPrefSuccess>(_setFalse),
  TypedReducer<bool, SetProjectPrefPending>(_setTrue),
  TypedReducer<bool, SetProjectPrefSuccess>(_setFalse),
  TypedReducer<bool, AddLogPending>(_setTrue),
  TypedReducer<bool, AddLogSuccess>(_setFalse),
  TypedReducer<bool, EditLogPending>(_setTrue),
  TypedReducer<bool, EditLogSuccess>(_setFalse),
  TypedReducer<bool, DeleteLogPending>(_setTrue),
  TypedReducer<bool, DeleteLogSuccess>(_setFalse),
  TypedReducer<bool, RequestVacationPending>(_setTrue),
  TypedReducer<bool, RequestVacationSuccess>(_setFalse),
  TypedReducer<bool, GetRequestsPending>(_setTrue),
  TypedReducer<bool, GetRequestsSuccess>(_setFalse),
  TypedReducer<bool, ChangeStatusVacationPending>(_setTrue),
  TypedReducer<bool, ChangeStatusVacationSuccess>(_setFalse),
  TypedReducer<bool, GetLogsFilterUsersPending>(_setTrue),
  TypedReducer<bool, GetLogsFilterUsersSuccess>(_setFalse),
  TypedReducer<bool, GetLogsFilterProjectsPending>(_setTrue),
  TypedReducer<bool, GetLogsFilterProjectsSucess>(_setFalse),
  TypedReducer<bool, SetPasswordPending>(_setTrue),
  TypedReducer<bool, SetPasswordSuccess>(_setFalse),
]);
bool _setTrue(bool isLoading, dynamic action) {
  return true;
}

bool _setFalse(bool isLoading, dynamic action) {
  return false;
}
