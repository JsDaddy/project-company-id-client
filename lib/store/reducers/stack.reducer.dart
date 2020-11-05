import 'package:company_id_new/store/actions/stack.action.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:redux/redux.dart';

final Reducer<List<StackModel>> stackReducers = combineReducers<
    List<StackModel>>(<List<StackModel> Function(List<StackModel>, dynamic)>[
  TypedReducer<List<StackModel>, GetStackSuccess>(_getStack),
]);
List<StackModel> _getStack(List<StackModel> rules, GetStackSuccess action) {
  return action.stack;
}
