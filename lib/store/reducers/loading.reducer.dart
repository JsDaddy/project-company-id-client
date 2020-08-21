import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:redux/redux.dart';

final Reducer<bool> loadingReducers =
    combineReducers<bool>(<bool Function(bool, dynamic)>[
  TypedReducer<bool, GetAdminLogsPending>(_setTrue),
  TypedReducer<bool, GetAdminLogsSuccess>(_setFalse),
]);
bool _setTrue(bool isLoading, dynamic action) {
  return true;
}

bool _setFalse(bool isLoading, dynamic action) {
  return false;
}
