import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class LogModel {
  LogModel(
      {this.id,
      // this.date,
      this.time,
      this.desc,
      this.project,
      this.status,
      this.type,
      this.user,
      this.vacationType});
  String id;
  String desc;
  String time;
  // DateTime date;
  VacationType vacationType;
  VacationStatus status;
  LogType type;
  ProjectModel project;
  UserModel user;
  static LogModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return LogModel(
        id: json['_id'] as String,
        desc: json['desc'] as String,
        time: json['time'] as String,
        status: json['status'] != null
            ? AppConverting.getVacationStatus(json['status'] as String)
            : null,
        vacationType: json['type'] != null
            ? AppConverting.getVacationType(json['type'] as int)
            : null,
        type: json['type'] != null ? LogType.vacation : LogType.timelog,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        project: json['project'] != null
            ? ProjectModel.fromJson(json['project'] as Map<String, dynamic>)
            : null);
  }

  LogModel copyWith(
      String id,
      String desc,
      String time,
      DateTime date,
      VacationType vacationType,
      VacationStatus status,
      LogType type,
      ProjectModel project,
      UserModel user) {
    return LogModel(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      time: time ?? this.time,
      // date: date ?? this.date,
      vacationType: vacationType ?? this.vacationType,
      status: status ?? this.status,
      type: type ?? this.type,
      project: project ?? this.project,
      user: user ?? this.user,
    );
  }
}

enum LogType { vacation, timelog, all }

enum VacationType { vacationPaid, vacationNonPaid, sickPaid, sickNonPaid }

enum VacationStatus { pending, approved, rejected }
