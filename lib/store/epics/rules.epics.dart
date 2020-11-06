import 'package:company_id_new/common/services/rules.service.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/rules.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/rules.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> getRulesEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetRulesPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<RulesModel>>.fromFuture(getRules())
              .map<dynamic>((List<RulesModel> rules) {
            return GetRulesSuccess(rules);
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetRulesError());
          }));
}
