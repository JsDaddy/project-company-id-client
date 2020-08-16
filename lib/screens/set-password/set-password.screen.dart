import 'package:company_id_new/common/services/validators.service.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-input/app-input.widget.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatefulWidget {
  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final TextEditingController _cpasswordController =
      TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change password')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              AppInput(
                validator: (String value) => validators.validateSize(
                    value, 6, 'Password has match 6 and more symbols'),
                myController: _passwordController,
                obscureText: true,
                labelText: 'Password',
              ),
              const SizedBox(
                height: 16,
              ),
              AppInput(
                obscureText: true,
                validator: (String value) => validators.compareValidate(
                    value, _passwordController, 'Passwords does not matches'),
                myController: _cpasswordController,
                labelText: 'Confirm password',
              ),
              const SizedBox(
                height: 32,
              ),
              AppButtonWidget(
                  width: 140, title: 'Save password', onClick: () => _save()),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    store.dispatch(SetPasswordPending(
      _passwordController.text,
    ));
  }
}
