import 'package:company_id_new/common/services/slack.service.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/vacations.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> slackNotify(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is SlackNotifyPending)
      .switchMap((dynamic action) => Stream<bool>.fromFuture(
                  sendMessage(action.uid as String, action.message as String))
              .map<dynamic>((bool result) {
            return result ? SlackNotifySuccess() : SlackNotifyError();
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(SlackNotifyError());
          }));
}
