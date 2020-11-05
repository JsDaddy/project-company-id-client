import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class GetUsersPending {
  GetUsersPending({this.usersType = UsersType.Default, this.projectId});
  UsersType usersType;
  String projectId;
}

class GetUsersSuccess {
  GetUsersSuccess(this.users);
  List<UserModel> users;
}

class GetAbsentUsersSuccess {
  GetAbsentUsersSuccess(this.absentUsers);
  List<UserModel> absentUsers;
}

class GetUsersError {}

class GetUserPending {
  GetUserPending(this.id);
  String id;
}

class GetUserSuccess {
  GetUserSuccess(this.user);
  UserModel user;
}

class GetUserError {}

class ArchiveUserPending {
  ArchiveUserPending(this.id);
  String id;
}

class ArchiveUserSuccess {
  ArchiveUserSuccess(this.id, this.date);
  String id;
  DateTime date;
}

class ArchiveUserError {}

enum UsersType { Default, Filter, Absent, ProjectFilter }

class RemoveProjectFromUserPending {
  RemoveProjectFromUserPending(this.userId, this.project);
  String userId;
  ProjectModel project;
}

class RemoveProjectFromUserSuccess {
  RemoveProjectFromUserSuccess(this.project);
  ProjectModel project;
}

class RemoveProjectFromUserError {}
