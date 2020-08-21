import 'dart:convert';

import 'package:company_id_new/common/services/auth.service.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/screens/home/home.screen.dart';
import 'package:company_id_new/screens/set-password/set-password.screen.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/store.dart';
import 'package:dio/dio.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import '../../screens/login/login.screen.dart';

Stream<void> checkTokenEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is CheckTokenPending)
      .switchMap((dynamic action) => Stream<UserModel>.fromFuture(checkToken())
              .expand<dynamic>((UserModel user) {
            return <dynamic>[
              SetTitle(user.role == 'admin' ? 'Statistics' : 'Timelog'),
              SignInSuccess(user),
              PushReplacementAction(
                  user.initialLogin ? SetPasswordScreen() : HomeScreen(),
                  key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            print('checktoken error: $e');
            return PushReplacementAction(LoginScreen(), key: mainNavigatorKey);
          }));
}

Stream<void> signInEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is SignInPending).switchMap(
      (dynamic action) => Stream<UserModel>.fromFuture(
                  singIn(action.email as String, action.password as String))
              .expand<dynamic>((UserModel user) {
            return <dynamic>[
              SignInSuccess(user),
              SetTitle(user.role == 'admin' ? 'Statistics' : 'Timelog'),
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
              Notify(NotifyModel(
                  NotificationType.success, 'Your password has been changed')),
              SetTitle(
                  store.state.user.role == 'admin' ? 'Statistics' : 'Timelog'),
              PushReplacementAction(HomeScreen(), key: mainNavigatorKey)
            ];
          }).onErrorReturnWith((dynamic e) {
            print(e);
            print(e.message);
          }));
}
