import 'project.model.dart';
import 'user.model.dart';

class FilterLogsUsersProjects {
  FilterLogsUsersProjects({this.users, this.projects});
  List<UserModel> users;
  List<ProjectModel> projects;
  FilterLogsUsersProjects copyWith(
      {List<UserModel> users, List<ProjectModel> projects}) {
    return FilterLogsUsersProjects(
        projects: projects ?? this.projects, users: users ?? this.users);
  }
}
