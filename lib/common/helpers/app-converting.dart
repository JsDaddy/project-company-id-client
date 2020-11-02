import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class AppConverting {
  static VacationType getVacationType(int type) {
    switch (type) {
      case 0:
        return VacationType.VACNONPAID;
        break;
      case 1:
        return VacationType.VACPAID;
        break;
      case 2:
        return VacationType.SICKNONPAID;
        break;
      case 3:
        return VacationType.SICKPAID;
        break;
      default:
        return null;
    }
  }

  static VacationType getIntFromVacationType(int type) {
    switch (type) {
      case 0:
        return VacationType.VACNONPAID;
        break;
      case 1:
        return VacationType.VACPAID;
        break;
      case 2:
        return VacationType.SICKNONPAID;
        break;
      case 3:
        return VacationType.SICKPAID;
        break;
      default:
        return null;
    }
  }

  static String getVacationTypeQuery(VacationType type) {
    switch (type) {
      case VacationType.VACPAID:
        return 'VacationPaid';
        break;
      case VacationType.VACNONPAID:
        return 'VacationNonPaid';
        break;
      case VacationType.SICKPAID:
        return 'SickPaid';
        break;
      case VacationType.SICKNONPAID:
        return 'SickNonPaid';
        break;
      default:
        return null;
    }
  }

  static String getVacationTypeString(VacationType type) {
    switch (type) {
      case VacationType.VACPAID:
        return 'Vacation - paid';
        break;
      case VacationType.VACNONPAID:
        return 'Vacation - non-paid';
        break;
      case VacationType.SICKPAID:
        return 'Sick - paid';
        break;
      case VacationType.SICKNONPAID:
        return 'Sick - non-paid';
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

  static Positions getPositionFromEnum(String position) {
    switch (position) {
      case 'owner':
        return Positions.OWNER;
        break;
      case 'developer':
        return Positions.DEVELOPER;
        break;
      default:
        return null;
    }
  }

  static String getPositionFromString(Positions position) {
    switch (position) {
      case Positions.OWNER:
        return 'Owner';
        break;
      case Positions.DEVELOPER:
        return 'Developer';
        break;
      default:
        return null;
    }
  }
}
