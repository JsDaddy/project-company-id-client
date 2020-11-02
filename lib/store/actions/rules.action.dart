import 'package:company_id_new/store/models/rules.model.dart';

class GetRulesPending {}

class GetRulesSuccess {
  GetRulesSuccess(this.rules);
  List<RulesModel> rules;
}
