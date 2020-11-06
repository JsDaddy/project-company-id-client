import 'package:company_id_new/common/services/vacations.service.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/vacations.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> changeStatusVacationEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is ChangeStatusVacationPending)
      .switchMap((dynamic action) =>
          Stream<LogModel>.fromFuture(changeStatusVacation(
                  action.vacationId as String, action.status as RequestStatus))
              .expand<dynamic>((LogModel vacation) {
            return <dynamic>[
              ChangeStatusVacationSuccess(vacation.id, vacation.status),
              Notify(NotifyModel(
                  NotificationType.Success,
                  action.status == RequestStatus.Approved
                      ? 'Vacation has been approved'
                      : 'Vacation has been rejected')),
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.Error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(ChangeStatusVacationError());
          }));
}
