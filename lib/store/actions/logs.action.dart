import 'package:company_id_new/store/models/calendar.model.dart';
import 'package:company_id_new/store/models/current-day.model.dart';
import 'package:company_id_new/store/models/statistic.model.dart';

class GetAdminLogsPending {
  GetAdminLogsPending(this.query);
  String query;
}

class GetAdminLogsSuccess {
  GetAdminLogsSuccess(this.logs);
  Map<DateTime, List<CalendarModel>> logs;
}

class GetAdmingStatisticSuccess {
  GetAdmingStatisticSuccess(this.statistic);
  StatisticModel statistic;
}

class GetHolidaysLogsSuccess {
  GetHolidaysLogsSuccess(this.holidays);
  Map<DateTime, List<CalendarModel>> holidays;
}

class GetLogsPending {}

class GetLogsSuccess {}

class FilterLogsPending {}

class FilterLogsSuccess {}

class SetAdminCurrentLogDay {
  SetAdminCurrentLogDay(this.currentDay);
  CurrentDateModel currentDay;
}

class SetCurrentLogDay {
  SetCurrentLogDay(this.currentDay);
  CurrentDateModel currentDay;
}
