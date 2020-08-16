import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:redux/redux.dart';

final Reducer<String> titleReducer =
    combineReducers<String>(<String Function(String, dynamic)>[
  TypedReducer<String, SetTitle>(_setTitle),
]);

String _setTitle(String title, SetTitle action) {
  return action.title;
}
