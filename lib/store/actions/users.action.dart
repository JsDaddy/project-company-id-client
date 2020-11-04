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

class GetAbsentUsersError {}

class GetUserPending {
  GetUserPending(this.id);
  String id;
}

class GetUserSuccess {
  GetUserSuccess(this.user);
  UserModel user;
}

class GetUserError {}

enum UsersType { Default, Filter, Absent }

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
