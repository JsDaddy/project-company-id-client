enum NotificationType { error, warning, success }

class NotifyModel {
  NotifyModel(this.type, this.notificationMessage);
  NotificationType type;
  String notificationMessage;
}
