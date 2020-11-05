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
    return 'uid=$uid';
  }

  static String projectQuery(String projectId) {
    return 'project=$projectId';
  }

  static String stackQuery(String stackId) {
    return 'stack=$stackId';
  }
}
