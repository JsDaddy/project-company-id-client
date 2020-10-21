import 'package:company_id_new/store/models/user.model.dart';

class GetUsersPending {}

class GetUsersSuccess {
  GetUsersSuccess(this.users);
  List<UserModel> users;
}

class GetUserPending {
  GetUserPending(this.id);
  String id;
}

class GetUserSuccess {
  GetUserSuccess(this.user);
  UserModel user;
}
