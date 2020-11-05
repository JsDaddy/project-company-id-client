import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:company_id_new/common/services/validators.service.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-input/app-input.widget.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.stack, this.users, this.user});
  List<StackModel> stack;
  List<UserModel> users;
  UserModel user;
}

class CreateProjectScreen extends StatefulWidget {
  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _customerController =
      TextEditingController(text: '');
  final TextEditingController _industryController =
      TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _startDateController =
      TextEditingController(text: '');
  List<StackModel> savedStack = <StackModel>[];
  List<UserModel> savedUsers = <UserModel>[];
  bool _isActivity = false;
  bool _isInternal = false;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            stack: store.state.stack,
            users: store.state.users,
            user: store.state.user),
        onInit: (Store<AppState> store) {
          store.dispatch(GetUsersPending());
        },
        builder: (BuildContext context, _ViewModel state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 16,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    AppInput(
                        myController: _nameController,
                        labelText: 'Name',
                        validator: (String value) => validators.validateIsEmpty(
                            value, 'Please enter name')),
                    const SizedBox(
                      height: 16,
                    ),
                    AppInput(
                      myController: _customerController,
                      validator: (String value) => validators.validateIsEmpty(
                          value, 'Please enter customer'),
                      labelText: 'Customer',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppInput(
                      validator: (String value) => validators.validateIsEmpty(
                          value, 'Please enter industry'),
                      myController: _industryController,
                      labelText: 'Industry',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _isActivityProject(),
                    _isInternalProject(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Select stack',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _selectStack(state.stack ?? <StackModel>[]),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Select users',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _selectUsers(state.users ?? <UserModel>[]),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () => _chooseDate(),
                      child: AbsorbPointer(
                        child: AppInput(
                          validator: (String value) =>
                              validators.validateIsEmpty(
                            value,
                            'Please enter start date',
                          ),
                          myController: _startDateController,
                          labelText: 'Start date',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButtonWidget(
                      onClick: () => _addProject(state),
                      title: 'Add project',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _isActivityProject() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Is activity project ?', style: TextStyle(fontSize: 16)),
        Switch(
          activeTrackColor: AppColors.red,
          activeColor: AppColors.red,
          value: _isActivity,
          onChanged: (bool value) {
            setState(() => _isActivity = value);
          },
        ),
      ],
    );
  }

  Widget _isInternalProject() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Is internal project ?', style: TextStyle(fontSize: 16)),
        Switch(
          activeTrackColor: AppColors.red,
          activeColor: AppColors.red,
          value: _isInternal,
          onChanged: (bool value) {
            setState(() => _isInternal = value);
          },
        ),
      ],
    );
  }

  void _addProject(_ViewModel state) {
    if (savedStack.isEmpty) {
      setState(() {
        error = 'Please choose at list one stack';
      });
    }
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (savedStack.isEmpty) {
      setState(() {
        error = 'Please choose at list one stack';
      });
      return;
    } else {
      setState(() {
        error = '';
      });
    }
    print(_industryController.text);
    print(_nameController.text);
    print(_customerController.text);
    print(savedStack.length);
    print(_isInternal);
    print(_isActivity);
    print(_selectedDate);
    print(savedUsers.length);
    store.dispatch(CreateProjectPending(ProjectModel(
        industry: _industryController.text,
        name: _nameController.text,
        stack: savedStack,
        customer: _customerController.text,
        isInternal: _isInternal,
        isActivity: _isActivity,
        startDate: _selectedDate,
        onboard: savedUsers)));
  }

  Widget _selectUsers(List<UserModel> users) {
    return Wrap(
        children: users
            .map(
              (UserModel user) => GestureDetector(
                onTap: () => onTapUser(user),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                      color: savedUsers.contains(user)
                          ? AppColors.red
                          : AppColors.red.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('${user.name} ${user.lastName}',
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            )
            .toList());
  }

  void onTapUser(UserModel user) {
    setState(() {
      if (savedUsers.contains(user)) {
        savedUsers.removeWhere((UserModel savedUser) {
          return user.id == savedUser.id;
        });
      } else {
        savedUsers.add(user);
      }
    });
  }

  Widget _selectStack(List<StackModel> stack) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: stack
              .map(
                (StackModel stack) => GestureDetector(
                  onTap: () => _onTapStack(stack),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: savedStack.contains(stack)
                            ? AppColors.red
                            : AppColors.red.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(stack.name,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              )
              .toList(),
        ),
        error.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  error,
                  style: const TextStyle(color: AppColors.red),
                ),
              )
            : Container()
      ],
    );
  }

  void _onTapStack(StackModel stack) {
    setState(() {
      if (savedStack.contains(stack)) {
        savedStack.removeWhere((StackModel savedStack) {
          return stack.id == savedStack.id;
        });
        if (savedStack.isEmpty) {
          error = 'Please choose at list one stack';
        }
      } else {
        savedStack.add(stack);
        error = '';
      }
    });
  }

  Future<void> _chooseDate() async {
    final DateTime today = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: DateTime(1950, 8),
        lastDate: today,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: AppColors.semiGrey,
              colorScheme: const ColorScheme.light(
                  primary: AppColors.red, onSurface: Colors.white),
            ),
            child: child,
          );
        });
    if (picked != null && picked != _selectedDate)
      setState(() {
        _startDateController.text = converter.dateFromString(picked.toString());
        _selectedDate = picked;
      });
  }
}
