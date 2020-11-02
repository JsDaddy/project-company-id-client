import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/log.model.dart';

class GetLogsPending {
  GetLogsPending(this.date);
  String date;
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
  GetLogByDatePending(this.date);
  String date;
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

class EditLogPending {
  EditLogPending(this.log);
  LogModel log;
}

class EditLogSuccess {
  EditLogSuccess(this.log);
  LogModel log;
}

class DeleteLogPending {
  DeleteLogPending(this.id);
  String id;
}

class DeleteLogSuccess {
  DeleteLogSuccess(this.id);
  String id;
}

class RequestVacationPending {
  RequestVacationPending(this.vacation);
  LogModel vacation;
}

class RequestVacationSuccess {
  RequestVacationSuccess(this.vacation);
  LogModel vacation;
}

class SetVacationSickAvail {
  SetVacationSickAvail(this.vacationSickAvailable);
  VacationSickAvailable vacationSickAvailable;
}

class GetRequestsPending {}

class GetRequestsSuccess {
  GetRequestsSuccess(this.requests);
  List<LogModel> requests;
}
