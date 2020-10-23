import 'package:company_id_new/store/models/admin-filter.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class SaveAdminFilter {
  SaveAdminFilter(this.adminFilter);
  AdminFilterModel adminFilter;
}

class FilteredUsersPending {
  FilteredUsersPending(this.projectId);
  String projectId;
}

class FilteredUsersSuccess {
  FilteredUsersSuccess(this.users);
  List<FilteredUserModel> users;
}

class FilteredProjectsPending {
  FilteredProjectsPending(this.userId);
  String userId;
}

class FilteredProjectsSuccess {
  FilteredProjectsSuccess(this.projects);
  List<FilteredProjectModel> projects;
}
