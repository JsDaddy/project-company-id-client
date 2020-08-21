import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/auth.reducer.dart';
import 'package:company_id_new/store/reducers/loading.reducer.dart';
import 'package:company_id_new/store/reducers/logs.reducer.dart';
import 'package:company_id_new/store/reducers/notify.reducer.dart';
import 'package:company_id_new/store/reducers/ui.reducer.dart';

class AppState {
  AppState(
      {this.isLoading, this.notify, this.title, this.user, this.adminLogs});
  bool isLoading;
  String title;
  UserModel user;
  NotifyModel notify;
  Map<DateTime, List<double>> adminLogs;
}

AppState appStateReducer(AppState state, dynamic action) => AppState(
    isLoading: loadingReducers(state.isLoading, action),
    title: titleReducer(state.title, action),
    adminLogs: adminLogsReducer(state.adminLogs, action),
    user: authReducers(state.user, action),
    notify: notifyReducers(state.notify, action));
