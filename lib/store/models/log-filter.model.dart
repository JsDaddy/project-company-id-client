import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class LogFilterModel {
  LogFilterModel({
    this.logType,
    this.user,
    this.project,
  });
  FilterType logType;
  UserModel user;
  ProjectModel project;

  LogFilterModel copyWith({
    FilterType logType,
    String vacation,
    UserModel user,
    ProjectModel project,
  }) =>
      LogFilterModel(
        logType: logType ?? this.logType,
        user: user ?? this.user,
        project: project ?? this.project,
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
