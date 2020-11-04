import 'package:company_id_new/common/services/rules.service.dart';
import 'package:company_id_new/store/actions/rules.action.dart';
import 'package:company_id_new/store/models/rules.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Stream<void> getRulesEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetRulesPending)
      .switchMap((dynamic action) =>
          Stream<List<RulesModel>>.fromFuture(getRules())
              .map((List<RulesModel> rules) {
            return GetRulesSuccess(rules);
          }))
      .handleError((dynamic e) {
    print(e);
    return GetRulesError();
  });
}
