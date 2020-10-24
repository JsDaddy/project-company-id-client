import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';

import '../models/log.model.dart';

class GetLogsPending {
  GetLogsPending(this.query);
  String query;
}

class GetLogsSuccess {
  GetLogsSuccess(this.logs);
  Map<DateTime, List<CalendarModel>> logs;
}

class GetStatisticSuccess {
  GetStatisticSuccess(this.statistic);
  StatisticModel statistic;
}

class GetHolidaysLogsSuccess {
  GetHolidaysLogsSuccess(this.holidays);
  Map<DateTime, List<CalendarModel>> holidays;
}

class SetCurrentDay {
  SetCurrentDay(this.currentDay);
  DateTime currentDay;
}

class SetCurrentMonth {
  SetCurrentMonth(this.currentMonth);
  DateTime currentMonth;
}

class GetLogByDatePending {
  GetLogByDatePending(this.query);
  String query;
}

class GetLogByDateSuccess {
  GetLogByDateSuccess(this.logs);
  List<LogModel> logs;
}

class AddLogPending {
  AddLogPending(this.log);
  LogModel log;
}

class AddLogSuccess {
  AddLogSuccess(this.log);
  LogModel log;
}
