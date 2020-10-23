import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/store/models/log.model.dart';

class AppParams {
  static String dateQuery(DateTime dateTime) {
    final String date = dateTime.toIso8601String();
    return '/$date';
  }

  static String logTypeQuery(LogType logType) {
    if (logType == null) {
      return '';
    }
    final String type = AppConverting.getTypeLogQuery(logType);
    return '/$type';
  }
}
