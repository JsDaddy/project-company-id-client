import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/store/models/enums.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class LogModel {
  LogModel(
      {this.id,
      this.date,
      this.time,
      this.desc,
      this.project,
      this.status,
      this.type,
      this.name,
      this.user,
      this.fullName,
      this.vacationType});
  String id;
  String desc;
  String time;
  DateTime date;
  VacationType vacationType;
  String status;
  String name;
  LogType type;
  ProjectModel project;
  UserModel user;
  String fullName;
  static LogModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return LogModel(
        id: json['_id'] as String,
        desc: json['desc'] as String,
        time: json['time'] as String,
        date: json['date'] != null
            ? DateTime.parse(json['date'] as String)
            : null,
        name: json['name'] as String,
        fullName: json['fullName'] as String,
        status: json['status'] as String,
        vacationType: json['type'] != null
            ? AppConverting.getVacationType(json['type'] as int)
            : null,
        type: json['type'] != null
            ? LogType.vacation
            : json['name'] != null
                ? LogType.holiday
                : json['fullName'] != null ? LogType.birthday : LogType.timelog,
        user: json['user'] != null
            ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        project: json['project'] != null
            ? ProjectModel.fromJson(json['project'] as Map<String, dynamic>)
            : null);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'time': time,
      'desc': desc,
      'date': date.toIso8601String(),
    };
  }

  Map<String, dynamic> toVacJson() {
    return <String, dynamic>{
      'desc': desc,
      'date': date.toIso8601String(),
      'type': AppConverting.getVacationTypeQuery(vacationType)
    };
  }

  LogModel copyWith(
      String id,
      String desc,
      String time,
      DateTime date,
      VacationType vacationType,
      String status,
      LogType type,
      ProjectModel project,
      UserModel user) {
    return LogModel(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      time: time ?? this.time,
      date: date ?? this.date,
      vacationType: vacationType ?? this.vacationType,
      status: status ?? this.status,
      type: type ?? this.type,
      project: project ?? this.project,
      user: user ?? this.user,
    );
  }
}

class LogResponse {
  LogResponse({this.logs, this.vacationAvailable, this.sickAvailable});
  int vacationAvailable;
  int sickAvailable;
  List<LogModel> logs;
  static LogResponse fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return LogResponse(
        vacationAvailable: json['vacationAvailable'] as int,
        sickAvailable: json['sickAvailable'] as int,
        logs: json['logs']
            .map<LogModel>(
                (dynamic log) => LogModel.fromJson(log as Map<String, dynamic>))
            .toList() as List<LogModel>);
  }
}

class VacationSickAvailable {
  VacationSickAvailable({this.vacationAvailable, this.sickAvailable});
  int vacationAvailable;
  int sickAvailable;
}
