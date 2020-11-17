import 'package:company_id_new/common/helpers/app-enums.dart';

class ChangeStatusVacationPending {
  ChangeStatusVacationPending(this.vacationId, this.status, {this.slack = ''});
  String vacationId;
  RequestStatus status;
  String slack;
}

class ChangeStatusVacationSuccess {
  ChangeStatusVacationSuccess(this.vacationId, this.status);
  String vacationId;
  RequestStatus status;
}

class ChangeStatusVacationError {}

class SlackNotifyPending {
  SlackNotifyPending(this.uid, this.message);
  String uid;
  String message;
}

class SlackNotifySuccess {}

class SlackNotifyError {}
