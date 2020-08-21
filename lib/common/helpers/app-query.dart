import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/store/models/log.model.dart';

class AppQuery {
  static String dateQuery(DateTime dateTime) {
    final String date = dateTime.toIso8601String();
    return 'first=$date';
  }

  static String logTypeQuery(LogType logType) {
    final String type = AppConverting.getTypeLogQuery(logType);
    return 'logType=$type';
  }

  static String vacationTypeQuery(VacationType vacationType) {
    final int type = AppConverting.getVacationTypeQuery(vacationType);
    return 'type=$type';
  }

  static String userQuery(String uid) {
    return 'user=$uid';
  }

  static String projectQuery(String projectId) {
    return 'project=$projectId';
  }
}
