import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/store/models/project.model.dart';

class UserModel {
  UserModel({
    this.avatar,
    this.github,
    this.date,
    this.email,
    this.lastName,
    this.name,
    this.phone,
    this.activeProjects,
    this.position,
    this.skype,
    this.projects,
    this.id,
    this.englishLevel,
    this.initialLogin,
    this.sickAvailable,
    this.vacationAvailable,
    this.endDate,
  });
  String avatar;
  String github;
  DateTime date;
  String email;
  String id;
  List<ProjectModel> activeProjects;
  String lastName;
  String name;
  String phone;
  Positions position;
  String skype;
  String englishLevel;
  bool initialLogin;
  List<ProjectModel> projects;
  int vacationAvailable;
  int sickAvailable;
  DateTime endDate;

  static UserModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    print(json['endDate']);
    print(json);

    return UserModel(
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      avatar: json['avatar'] as String,
      vacationAvailable: json['vacationAvailable'] as int,
      sickAvailable: json['sickAvailable'] as int,
      englishLevel: json['englishLevel'] as String,
      github: json['github'] as String,
      date: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      email: json['email'] as String,
      id: json['_id'] as String,
      lastName: json['lastName'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      projects: json['projects'] == null
          ? null
          : json['projects']
              .map<ProjectModel>((dynamic project) =>
                  ProjectModel.fromJson(project as Map<String, dynamic>))
              .toList() as List<ProjectModel>,
      activeProjects: json['activeProjects'] == null
          ? null
          : json['activeProjects']
              .map<ProjectModel>((dynamic project) =>
                  ProjectModel.fromJson(project as Map<String, dynamic>))
              .toList() as List<ProjectModel>,
      position: AppConverting.getPositionFromEnum(json['position'] as String),
      skype: json['skype'] as String,
      initialLogin: json['initialLogin'] as bool,
    );
  }

  UserModel copyWith(
      {String avatar,
      String github,
      DateTime date,
      String email,
      String userId,
      List<ProjectModel> activeProjects,
      String lastName,
      String id,
      String name,
      String phone,
      Positions position,
      int sickAvailable,
      int vacationAvailable,
      String skype,
      String englishLevel,
      String documentId,
      bool initialLogin,
      DateTime endDate,
      List<ProjectModel> projects}) {
    return UserModel(
        avatar: avatar ?? this.avatar,
        englishLevel: englishLevel ?? this.englishLevel,
        github: github ?? this.github,
        activeProjects: activeProjects ?? this.activeProjects,
        date: date ?? this.date,
        email: email ?? this.email,
        id: id ?? this.id,
        lastName: lastName ?? this.lastName,
        sickAvailable: sickAvailable ?? this.sickAvailable,
        vacationAvailable: vacationAvailable ?? this.vacationAvailable,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        projects: projects ?? this.projects,
        position: position ?? this.position,
        skype: skype ?? this.skype,
        endDate: endDate ?? this.endDate,
        initialLogin: initialLogin ?? this.initialLogin);
  }
}

enum Positions { OWNER, DEVELOPER }
