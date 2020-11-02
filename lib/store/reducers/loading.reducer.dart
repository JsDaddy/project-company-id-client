import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/rules.action.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';

final Reducer<bool> loadingReducers =
    combineReducers<bool>(<bool Function(bool, dynamic)>[
  TypedReducer<bool, GetUsersPending>(_setTrue),
  TypedReducer<bool, GetUsersSuccess>(_setFalse),
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
]);
bool _setTrue(bool isLoading, dynamic action) {
  return true;
}

bool _setFalse(bool isLoading, dynamic action) {
  return false;
}
