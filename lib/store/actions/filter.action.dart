import 'package:company_id_new/common/helpers/enums.dart';
import 'package:company_id_new/store/models/log-filter.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/projects-filter.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class SaveLogFilter {
  SaveLogFilter(this.adminFilter);
  LogFilterModel adminFilter;
}

class ClearLogFilter {}

class GetLogsFilterUsersPending {
  GetLogsFilterUsersPending(this.projectId);
  String projectId;
}

class GetLogsFilterUsersError {}

class GetLogsFilterProjectsPending {
  GetLogsFilterProjectsPending(this.userId);
  String userId;
}

class GetLogsFilterUsersSuccess {
  GetLogsFilterUsersSuccess(this.users, {this.usersType});
  List<UserModel> users;
  UsersType usersType;
}

class GetLogsFilterProjectsSucess {
  GetLogsFilterProjectsSucess(this.projects);
  List<ProjectModel> projects;
}

class GetLogsFilterProjectsError {}

class ClearLogFilterLogsUsersProjects {}

class SaveProjectsFilter {
  SaveProjectsFilter(this.filter);
  ProjectsFilterModel filter;
}

class ClearProjectsFilter {}

class GetProjectsFilterUsersPending {
  GetProjectsFilterUsersPending(this.stackId);
  String stackId;
}

class GetProjectsFilterUsersSuccess {
  GetProjectsFilterUsersSuccess(this.users);
  List<UserModel> users;
}

class GetProjectsFilterUsersError {}

class GetProjectsFilterStackPending {
  GetProjectsFilterStackPending(this.userId);
  String userId;
}

class GetProjectsFilterStackSuccess {
  GetProjectsFilterStackSuccess(this.stack);
  List<StackModel> stack;
}

class GetProjectsFilterStackError {}

class ClearProjectsFilterLogsUsersStack {}
