class CalendarModel {
  CalendarModel({this.vacations, this.holiday, this.timelogs, this.birthdays});
  int vacations;
  double timelogs;
  String holiday;
  int birthdays;
  static CalendarModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return CalendarModel(
      vacations: json['vacations'] as int,
      timelogs: json['timelogs'] != null && json['timelogs'] is int
          ? (json['timelogs'] as int).toDouble()
          : json['timelogs'] as double,
      holiday: json['holidays'] != null
          ? (json['holidays'] as List<dynamic>)[0] as String
          : null,
      birthdays: json['birthdays'] != null ? json['birthdays'] as int : null,
    );
  }
}
