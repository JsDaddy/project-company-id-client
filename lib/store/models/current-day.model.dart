class CurrentDateModel {
  CurrentDateModel({this.currentDay, this.currentMohth});
  DateTime currentDay;
  DateTime currentMohth;
  CurrentDateModel copyWith({DateTime currentDay, DateTime currentMohth}) {
    return CurrentDateModel(
        currentDay: currentDay ?? this.currentDay,
        currentMohth: currentMohth ?? this.currentMohth);
  }
}
