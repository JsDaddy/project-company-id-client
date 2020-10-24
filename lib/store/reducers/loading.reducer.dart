import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';

final Reducer<bool> loadingReducers =
    combineReducers<bool>(<bool Function(bool, dynamic)>[
  TypedReducer<bool, GetLogsPending>(_setTrue),
  TypedReducer<bool, GetUsersPending>(_setTrue),
  TypedReducer<bool, GetProjectsPending>(_setTrue),
  TypedReducer<bool, GetLogsPending>(_setTrue),
  TypedReducer<bool, GetLogsFilterProjectsSucess>(_setFalse),
  TypedReducer<bool, GetLogsFilterUsersSuccess>(_setFalse),
  TypedReducer<bool, GetLogsSuccess>(_setFalse),
  TypedReducer<bool, GetLogsSuccess>(_setFalse),
]);
bool _setTrue(bool isLoading, dynamic action) {
  return true;
}

bool _setFalse(bool isLoading, dynamic action) {
  return false;
}
