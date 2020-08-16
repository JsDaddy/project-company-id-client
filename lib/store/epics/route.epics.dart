import 'package:company_id_new/common/services/auth.service.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> routeEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) {
    return action is PushAction;
  }).map((dynamic action) {
    print(action.destination);
    navigatorKey.currentState.pushNamed(action.destination as String);
  });
}
