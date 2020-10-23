import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/store/models/log.model.dart';

class AppQuery {
  static String vacationTypeQuery(VacationType vacationType) {
    if (vacationType == null) {
      return '';
    }
    final String type = AppConverting.getVacationTypeQuery(vacationType);
    return 'type=$type';
  }

  static String userQuery(String uid) {
    return 'user=$uid';
  }

  static String projectQuery(String projectId) {
    return 'project=$projectId';
  }

  static String logTypeQuery(LogType logType) {
    if (logType == null) {
      return '';
    }
    final String type = AppConverting.getTypeLogQuery(logType);
    return 'logType=$type';
  }
}
