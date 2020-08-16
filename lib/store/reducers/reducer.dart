import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/reducers/loading.reducer.dart';
import 'package:company_id_new/store/reducers/notify.reducer.dart';

class AppState {
  AppState({this.isLoading, this.notify});
  bool isLoading;
  NotifyModel notify;
}

AppState appStateReducer(AppState state, dynamic action) => AppState(
    isLoading: loadingReducer(state.isLoading, action),
    notify: notifyReducers(state.notify, action));
