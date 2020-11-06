enum ProjectStatus { Finished, Rejected, Ongoing, All }

enum ProjectSpec { Internal, Commercial, All }

enum ProjectsType { Default, Filter, Absent, ProjectFilter }

enum StackTypes { Default, ProjectFilter }

enum UsersType { Default, Filter, Absent, ProjectFilter }

enum LogType { vacation, timelog, holiday, birthday, all }

enum VacationType { VACPAID, VACNONPAID, SICKPAID, SICKNONPAID }

enum NotificationType { error, warning, success }

enum Positions { OWNER, DEVELOPER }
enum RequestStatus { Approved, Rejected, Pending }

String getStringFromProjectStatus(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.Finished:
      return 'finished';
    case ProjectStatus.Rejected:
      return 'rejected';
    default:
      return '';
  }
}

String getStringFromRequestStatus(RequestStatus status) {
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
