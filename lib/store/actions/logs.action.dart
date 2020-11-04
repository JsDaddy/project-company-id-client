import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';

class GetLogsPending {
  GetLogsPending(this.date);
  String date;
}

class GetLogsSuccess {
  GetLogsSuccess(this.logs);
  Map<DateTime, List<CalendarModel>> logs;
}

class GetLogsError {}

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

class GetLogByDateError {}

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

class AddLogError {}

class EditLogPending {
  EditLogPending(this.log);
  LogModel log;
}

class EditLogSuccess {
  EditLogSuccess(this.log);
  LogModel log;
}

class EditLogError {}

class DeleteLogPending {
  DeleteLogPending(this.id);
  String id;
}

class DeleteLogSuccess {
  DeleteLogSuccess(this.id);
  String id;
}

class DeleteLogError {}

class RequestVacationPending {
  RequestVacationPending(this.vacation);
  LogModel vacation;
}

class RequestVacationSuccess {
  RequestVacationSuccess(this.vacation);
  LogModel vacation;
}

class RequestVacationError {}

class SetVacationSickAvail {
  SetVacationSickAvail(this.vacationSickAvailable);
  VacationSickAvailable vacationSickAvailable;
}

class GetRequestsPending {}

class GetRequestsSuccess {
  GetRequestsSuccess(this.requests);
  List<LogModel> requests;
}

class GetRequestsError {}
