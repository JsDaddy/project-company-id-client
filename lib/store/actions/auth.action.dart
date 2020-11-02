import 'package:company_id_new/store/models/user.model.dart';

class CheckTokenPending {}

class CheckTokenSuccess {
  CheckTokenSuccess(this.user);
  UserModel user;
}

class SignInPending {
  SignInPending(this.email, this.password);
  String email;
  String password;
}

class SignInSuccess {
  SignInSuccess(this.user);
  UserModel user;
}

class SetPasswordPending {
  SetPasswordPending(this.password);
  String password;
}

class SetPasswordSuccess {}

class Logout {}
