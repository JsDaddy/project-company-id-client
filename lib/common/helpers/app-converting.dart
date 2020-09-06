import 'package:company_id_new/store/models/log.model.dart';

class AppConverting {
  static VacationType getVacationType(int type) {
    switch (type) {
      case 0:
        return VacationType.vacationPaid;
        break;
      case 1:
        return VacationType.vacationNonPaid;
        break;
      case 2:
        return VacationType.sickPaid;
        break;
      case 3:
        return VacationType.sickNonPaid;
        break;
      default:
        return null;
    }
  }

  static int getVacationTypeQuery(VacationType type) {
    switch (type) {
      case VacationType.vacationPaid:
        return 0;
        break;
      case VacationType.vacationNonPaid:
        return 1;
        break;
      case VacationType.sickPaid:
        return 2;
        break;
      case VacationType.sickNonPaid:
        return 3;
        break;
      default:
        return null;
    }
  }

  static String getTypeLogQuery(LogType logType) {
    switch (logType) {
      case LogType.vacation:
        return 'vacations';
        break;
      case LogType.timelog:
        return 'timelogs';
        break;
      default:
        return 'all';
    }
  }

  static VacationStatus getVacationStatus(String status) {
    switch (status) {
      case 'approved':
        return VacationStatus.approved;
        break;
      case 'pending':
        return VacationStatus.pending;
        break;
      case 'rejected':
        return VacationStatus.rejected;
        break;
      default:
        return null;
    }
  }
}
