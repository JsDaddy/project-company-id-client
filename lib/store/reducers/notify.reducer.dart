import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:redux/redux.dart';

final Reducer<NotifyModel> notifyReducers =
    combineReducers<NotifyModel>(<NotifyModel Function(NotifyModel, dynamic)>[
  TypedReducer<NotifyModel, Notify>(_notify),
  TypedReducer<NotifyModel, NotifyHandled>(_notified),
]);
NotifyModel _notify(NotifyModel notify, Notify action) {
  return action.notify;
}

NotifyModel _notified(NotifyModel notify, NotifyHandled action) {
  return null;
}
