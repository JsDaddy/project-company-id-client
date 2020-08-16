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
  final List<dynamic> activeProjects;
  final String lastName;
  final String name;
  final String phone;
  final String position;
  final String skype;
  final String englishLevel;
  final String documentId;
  final bool initialLogin;
  final List<dynamic> projects;

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
      avatar: json['avatar'].toString(),
      englishLevel: json['englishLevel'].toString(),
      github: json['github'].toString(),
      activeProjects: json['activeProjects'] as List<dynamic>,
      role: json['role'].toString(),
      date: json['dob'].toDate() as DateTime,
      email: json['email'].toString(),
      id: json['_id'].toString(),
      lastName: json['lastName'].toString(),
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      projects: json['projects'] as List<dynamic>,
      position: json['position'].toString(),
      skype: json['skype'].toString(),
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
      List<dynamic> activeProjects,
      String lastName,
      String id,
      String name,
      String phone,
      String position,
      String skype,
      String englishLevel,
      String documentId,
      bool initialLogin,
      List<dynamic> projects) {
    return UserModel(
        avatar: avatar ?? this.avatar,
        englishLevel: englishLevel ?? this.englishLevel,
        github: github ?? this.github,
        activeProjects: activeProjects ?? this.activeProjects,
        role: role ?? this.role,
        date: date ?? this.date,
        email: email ?? this.email,
        id: id ?? this.id,
        lastName: lastName ?? lastName,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        projects: projects ?? this.projects,
        position: position ?? this.position,
        skype: skype ?? this.skype,
        initialLogin: initialLogin ?? this.initialLogin);
  }
}
