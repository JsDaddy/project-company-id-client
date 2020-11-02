import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:redux/redux.dart';

final Reducer<UserModel> authReducers =
    combineReducers<UserModel>(<UserModel Function(UserModel, dynamic)>[
  TypedReducer<UserModel, SignInSuccess>(_signIn),
  TypedReducer<UserModel, CheckTokenSuccess>(_checkToken),
  TypedReducer<UserModel, LogoutSuccess>(_logout),
]);
UserModel _signIn(UserModel user, SignInSuccess action) {
  return action.user;
}

UserModel _checkToken(UserModel notify, CheckTokenSuccess action) {
  return action.user;
}

UserModel _logout(UserModel user, LogoutSuccess action) {
  return null;
}
