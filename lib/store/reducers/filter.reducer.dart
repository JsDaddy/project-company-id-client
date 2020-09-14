import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/models/admin-filter.model.dart';
import 'package:redux/redux.dart';

final Reducer<AdminFilterModel> adminFilterReducers = combineReducers<
    AdminFilterModel>(<AdminFilterModel Function(AdminFilterModel, dynamic)>[
  TypedReducer<AdminFilterModel, SaveAdminFilter>(_saveFilter),
]);

AdminFilterModel _saveFilter(AdminFilterModel title, SaveAdminFilter action) {
  return action.adminFilter;
}
