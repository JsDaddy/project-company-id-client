import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/services/validators.service.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-input/app-input.widget.dart';
import 'package:company_id_new/common/widgets/loader/loader.widget.dart';
import 'package:company_id_new/common/widgets/notifier/notifier.widget.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.isLoading});
  bool isLoading;
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  bool isRemember = false;
  @override
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              isLoading: store.state.isLoading,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return Notifier(
            child: LoaderWrapper(
              child: Scaffold(
                  body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 100),
                  child: ListView(
                    children: <Widget>[
                      Image.asset('assets/mac_boroda.png'),
                      const SizedBox(
                        height: 64,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: AppColors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      AppInput(
                        validator: (String value) => validators.validateIsEmpty(
                            value, 'Please enter email'),
                        myController: _emailController,
                        labelText: 'Email',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppInput(
                        obscureText: true,
                        validator: (String value) => validators.validateIsEmpty(
                          value,
                          'Please enter password',
                        ),
                        myController: _passwordController,
                        labelText: 'Password',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AppButtonWidget(
                          width: 140,
                          title: 'Login',
                          isLoading: state.isLoading,
                          onClick: () => _onLogin(),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        });
  }

  void _onLogin() {
    store.dispatch(
        SignInPending(_emailController.text.trim(), _passwordController.text));
  }
}
