import 'package:company_id_new/common/services/auth.service.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/screens/home/home.screen.dart';
import 'package:company_id_new/screens/login/login.screen.dart';
import 'package:company_id_new/screens/set-password/set-password.screen.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> checkTokenEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is CheckTokenPending)
      .switchMap((dynamic action) => Stream<UserModel>.fromFuture(checkToken())
              .expand<dynamic>((UserModel user) {
            return <dynamic>[
              SetTitle('Statistics'),
              SignInSuccess(user),
              user.position == Positions.OWNER ? GetRequestsPending() : null,
              PushReplacementAction(
                  user.initialLogin ? SetPasswordScreen() : HomeScreen(),
                  key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            print('checktoken error: $e');
            return PushReplacementAction(LoginScreen(), key: mainNavigatorKey);
          }));
}

Stream<void> logoutEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is LogoutPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<void>.fromFuture(logout()).expand<dynamic>((_) {
            return <dynamic>[
              LogoutSuccess(),
              PushReplacementAction(LoginScreen(), key: mainNavigatorKey)
            ];
          }));
}

Stream<void> signInEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is SignInPending).switchMap(
      (dynamic action) => Stream<UserModel>.fromFuture(
                  singIn(action.email as String, action.password as String))
              .expand<dynamic>((UserModel user) {
            return <dynamic>[
              SignInSuccess(user),
              SetTitle('Statistics'),
              PushReplacementAction(
                  user.initialLogin ? SetPasswordScreen() : HomeScreen(),
                  key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            return Notify(NotifyModel(NotificationType.error,
                e.message as String ?? 'Something went wrong'));
          }));
}

Stream<void> setPasswordEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is SetPasswordPending)
      .switchMap((dynamic action) =>
          Stream<void>.fromFuture(setPassword(action.password as String))
              .expand<dynamic>((_) {
            return <dynamic>[
              SetPasswordSuccess,
              Notify(NotifyModel(
                  NotificationType.success, 'Your password has been changed')),
              SetTitle('Statistics'),
              PushReplacementAction(HomeScreen(), key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}
