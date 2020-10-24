import 'package:company_id_new/store/models/filter.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class SaveFilter {
  SaveFilter(this.adminFilter);
  FilterModel adminFilter;
}

class ClearFilter {}

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

class GetLogsFilterUsersSuccess {
  GetLogsFilterUsersSuccess(this.users);
  List<UserModel> users;
}

class GetLogsFilterProjectsSucess {
  GetLogsFilterProjectsSucess(this.projects);
  List<ProjectModel> projects;
}

class ClearFilterLogsUsersProjects {}
