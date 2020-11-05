import 'package:date_format/date_format.dart';

final _Converter converter = _Converter();

class _Converter {
  String dateFromString(String strDate) {
    final DateTime todayDate = DateTime.parse(strDate);
    return formatDate(todayDate, <String>[dd, '/', mm, '/', yyyy]);
  }

  String monthYearFromDate(DateTime date) {
    return formatDate(date, <String>[MM, ' ', yyyy]);
  }
}
