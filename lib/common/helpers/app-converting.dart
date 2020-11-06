import 'package:company_id_new/common/helpers/app-enums.dart';

class AppConverting {
  static VacationType getVacationType(int type) {
    switch (type) {
      case 0:
        return VacationType.VacNonPaid;
        break;
      case 1:
        return VacationType.VacPaid;
        break;
      case 2:
        return VacationType.SickNonPaid;
        break;
      case 3:
        return VacationType.SickPaid;
        break;
      default:
        return null;
    }
  }

  static String getVacationTypeQuery(VacationType type) {
    switch (type) {
      case VacationType.VacPaid:
        return 'VacationPaid';
        break;
      case VacationType.VacNonPaid:
        return 'VacationNonPaid';
        break;
      case VacationType.SickPaid:
        return 'SickPaid';
        break;
      case VacationType.SickNonPaid:
        return 'SickNonPaid';
        break;
      default:
        return null;
    }
  }

  static String getVacationTypeString(VacationType type) {
    switch (type) {
      case VacationType.VacPaid:
        return 'Vacation - paid';
        break;
      case VacationType.VacNonPaid:
        return 'Vacation - non-paid';
        break;
      case VacationType.SickPaid:
        return 'Sick - paid';
        break;
      case VacationType.SickNonPaid:
        return 'Sick - non-paid';
        break;
      default:
        return null;
    }
  }

  static String getTypeLogQuery(LogType logType) {
    switch (logType) {
      case LogType.Vacation:
        return 'vacations';
        break;
      case LogType.Timelog:
        return 'timelogs';
        break;
      default:
        return 'all';
    }
  }

  static Positions getPositionFromEnum(String position) {
    switch (position) {
      case 'owner':
        return Positions.Owner;
        break;
      case 'developer':
        return Positions.Developer;
        break;
      default:
        return null;
    }
  }

  static String getPositionFromString(Positions position) {
    switch (position) {
      case Positions.Owner:
        return 'Owner';
        break;
      case Positions.Developer:
        return 'Developer';
        break;
      default:
        return null;
    }
  }

  static String getStringFromProjectStatus(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.Finished:
        return 'finished';
      case ProjectStatus.Rejected:
        return 'rejected';
      default:
        return '';
    }
  }

  static String getStringFromRequestStatus(RequestStatus status) {
    switch (status) {
      case RequestStatus.Approved:
        return 'approved';
      case RequestStatus.Rejected:
        return 'rejected';
      case RequestStatus.Pending:
        return 'pending';
      default:
        return '';
    }
  }

  static RequestStatus requestStatusFromString(String status) {
    switch (status) {
      case 'approved':
        return RequestStatus.Approved;
      case 'rejected':
        return RequestStatus.Rejected;
      case 'pending':
        return RequestStatus.Pending;
      default:
        return null;
    }
  }

  static ProjectStatus projectStatusFromString(String status) {
    switch (status) {
      case 'finished':
        return ProjectStatus.Finished;
      case 'rejected':
        return ProjectStatus.Rejected;
      case 'ongoing':
        return ProjectStatus.Ongoing;
      case 'all':
        return ProjectStatus.All;
      default:
        return null;
    }
  }
}
