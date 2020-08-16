import 'package:company_id_new/common/services/auth.service.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> checkTokenEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is CheckTokenPending)
      .switchMap((dynamic action) => Stream<UserModel>.fromFuture(checkToken())
              .map<dynamic>((UserModel user) {
            print('12312312312312');
            print(user);
            print('12312312312312');
            return CheckTokenSuccess() as dynamic;
            // if (user.userId == null) {
            //   return <dynamic>[
            //     SignInFail(),
            //     PushReplacementAction(MaterialPageRoute<void>(
            //         builder: (BuildContext context) => LoginScreen()))
            //   ];
            // }
            // return <dynamic>[
            //   SetTitle(user.role == 'admin' ? 'Statistics' : 'Timelog'),
            //   SignInSuccess(),
            //   SetUserInfo(user),
            //   GetNotificationsPending(user.documentId),
            //   PushReplacementAction(MaterialPageRoute<void>(
            //       builder: (BuildContext context) =>
            //           user.initialLogin ? SetPasswordScreen() : HomeScreen()))
            // ];
          }).onErrorReturnWith((dynamic e) {
            print('qwe $e');
            return PushAction('/login');
          }));
}
