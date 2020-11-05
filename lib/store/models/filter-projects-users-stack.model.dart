import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class FilterProjectsUsersStack {
  FilterProjectsUsersStack({this.users, this.stack});
  List<UserModel> users;
  List<StackModel> stack;

  FilterProjectsUsersStack copyWith(
      {List<UserModel> users, List<StackModel> stack}) {
    return FilterProjectsUsersStack(
        stack: stack ?? this.stack, users: users ?? this.users);
  }
}
