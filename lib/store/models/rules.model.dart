class RulesModel {
  RulesModel({this.title, this.desc});
  String title;
  String desc;
  RulesModel copyWith({String title, String desc}) {
    return RulesModel(title: title ?? this.title, desc: desc ?? this.desc);
  }

  static RulesModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return RulesModel(
      title: json['title'] as String,
      desc: json['desc'] as String,
    );
  }
}
