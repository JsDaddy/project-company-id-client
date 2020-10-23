class StackModel {
  StackModel({this.id, this.name});
  String id;
  String name;
  static StackModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return StackModel(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }
}
