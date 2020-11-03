import 'package:company_id_new/store/actions/rules.action.dart';
import 'package:company_id_new/store/models/rules.model.dart';
import 'package:redux/redux.dart';

final Reducer<List<RulesModel>> rulesReducers = combineReducers<
    List<RulesModel>>(<List<RulesModel> Function(List<RulesModel>, dynamic)>[
  TypedReducer<List<RulesModel>, GetRulesSuccess>(_getRules),
]);
List<RulesModel> _getRules(List<RulesModel> rules, GetRulesSuccess action) {
  return action.rules;
}
