import 'package:company_id_new/common/services/stack.service.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/stack.action.dart';
import 'package:company_id_new/store/models/enums.model.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:company_id_new/store/store.dart' as s;

Stream<void> getStackEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is GetStackPending)
      .switchMap<dynamic>((dynamic action) =>
          Stream<List<StackModel>>.fromFuture(getStack())
              .map<dynamic>((List<StackModel> stack) {
            switch (action.stackTypes as StackTypes) {
              case StackTypes.Default:
                return GetStackSuccess(stack);
              case StackTypes.ProjectFilter:
                return GetProjectsFilterStackSuccess(stack);
              default:
                return null;
            }
          }).handleError((dynamic e) {
            s.store.dispatch(Notify(NotifyModel(NotificationType.error,
                e.message as String ?? 'Something went wrong')));
            s.store.dispatch(GetStackError());
          }));
}
