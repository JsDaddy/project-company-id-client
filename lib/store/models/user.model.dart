import 'package:company_id_new/store/models/project.model.dart';

class UserModel {
  UserModel(
      {this.avatar,
      this.github,
      this.role,
      this.date,
      this.documentId,
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
      this.initialLogin});
  final String avatar;
  final String github;
  final String role;
  final DateTime date;
  final String email;
  final String id;
  final List<ProjectModel> activeProjects;
  final String lastName;
  final String name;
  final String phone;
  final String position;
  final String skype;
  final String englishLevel;
  final String documentId;
  final bool initialLogin;
  final List<ProjectModel> projects;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar,
      'github': github,
      'lastName': lastName,
      'name': name,
      'phone': phone,
      'skype': skype,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return UserModel(
      avatar: json['avatar'] as String,
      englishLevel: json['englishLevel'] as String,
      github: json['github'] as String,
      role: json['role'] as String,
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
      position: json['position'] as String,
      skype: json['skype'] as String,
      initialLogin: json['initialLogin'] as bool,
    );
  }

  UserModel copyWith(
      String avatar,
      String github,
      String role,
      DateTime date,
      String email,
      String userId,
      List<ProjectModel> activeProjects,
      String lastName,
      String id,
      String name,
      String phone,
      String position,
      String skype,
      String englishLevel,
      String documentId,
      bool initialLogin,
      List<ProjectModel> projects) {
    return UserModel(
        avatar: avatar ?? this.avatar,
        englishLevel: englishLevel ?? this.englishLevel,
        github: github ?? this.github,
        activeProjects: activeProjects ?? this.activeProjects,
        role: role ?? this.role,
        date: date ?? this.date,
        email: email ?? this.email,
        id: id ?? this.id,
        lastName: lastName ?? this.lastName,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        projects: projects ?? this.projects,
        position: position ?? this.position,
        skype: skype ?? this.skype,
        initialLogin: initialLogin ?? this.initialLogin);
  }
}
