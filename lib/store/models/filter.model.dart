import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class FilterModel {
  FilterModel(
      {this.logType,
      this.user,
      this.project,
      this.filteredProjects,
      this.filteredUsers});
  FilterType logType;
  UserModel user;
  ProjectModel project;
  List<FilteredProjectModel> filteredProjects;
  List<FilteredUserModel> filteredUsers;

  FilterModel copyWith({
    FilterType logType,
    String vacation,
    UserModel user,
    ProjectModel project,
    List<FilteredProjectModel> filteredProjects,
    List<FilteredUserModel> filteredUsers,
  }) =>
      FilterModel(
        logType: logType ?? this.logType,
        user: user ?? this.user,
        project: project ?? this.project,
        filteredUsers: filteredUsers ?? this.filteredUsers,
        filteredProjects: filteredProjects ?? this.filteredProjects,
      );
}

class FilterType {
  FilterType(this.title, this.logType, {this.vacationType});
  String title;
  VacationType vacationType;
  LogType logType;
}

class FilterVacationType {
  FilterVacationType(this.title, this.vacationType);
  String title;
  VacationType vacationType;
}
