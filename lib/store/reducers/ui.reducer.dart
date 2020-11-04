import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:redux/redux.dart';

final Reducer<List<String>> titleReducer = combineReducers<
    List<String>>(<List<String> Function(List<String>, dynamic)>[
  TypedReducer<List<String>, SetTitle>(_addTitle),
  TypedReducer<List<String>, SetClearTitle>(_setClearTitle),
  TypedReducer<List<String>, PopAction>(_removeLast),
  TypedReducer<List<String>, PushAction>(_addTitle),
]);

List<String> _addTitle(List<String> titles, dynamic action) {
  final List<String> newTitles = <String>[...titles, action.title as String];
  return newTitles;
}

List<String> _setClearTitle(List<String> titles, dynamic action) {
  return <String>[action.title as String];
}

List<String> _removeLast(List<String> titles, PopAction action) {
  final List<String> newTitles = <String>[...titles];
  newTitles.removeLast();
  return action.changeTitle ? newTitles : <String>[...titles];
}
