import 'package:company_id_new/store/models/filter.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class SaveFilter {
  SaveFilter(this.adminFilter);
  FilterModel adminFilter;
}

class ClearFilter {}

class GetLogsFilterUsersPending {
  GetLogsFilterUsersPending(this.projectId);
  String projectId;
}

class GetLogsFilterProjectsPending {
  GetLogsFilterProjectsPending(this.userId);
  String userId;
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
