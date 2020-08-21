class CurrentDateModel {
  CurrentDateModel({this.log, this.logAdmin});
  DateTime logAdmin;
  DateTime log;
  CurrentDateModel copyWith(DateTime logAdmin, DateTime log) {
    return CurrentDateModel(
        log: log ?? this.log, logAdmin: logAdmin ?? this.log);
  }
}
