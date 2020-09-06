class StatisticModel {
  StatisticModel({this.workedOut, this.toBeWorkedOut, this.overtime});
  String workedOut;
  String toBeWorkedOut;
  String overtime;
  static StatisticModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return StatisticModel(
        workedOut: json['workedOut'] as String,
        toBeWorkedOut: json['toBeWorkedOut'] as String,
        overtime: json['overtime'] as String);
  }
}
