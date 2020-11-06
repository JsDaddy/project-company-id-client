import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-dropdowns.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-dropdown-wrapper/app-dropdown-wrapper.widget.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.isLoading, this.users, this.project});
  bool isLoading;
  List<UserModel> users;
  ProjectModel project;
}

class AddUserWidget extends StatefulWidget {
  @override
  _AddUserWidgetWidgetState createState() => _AddUserWidgetWidgetState();
}

class _AddUserWidgetWidgetState extends State<AddUserWidget> {
  UserModel selectedUser;

  @override
  void initState() {
    store.dispatch(GetUsersPending(
        usersType: UsersType.Absent, projectId: store.state.project.id));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            isLoading: store.state.isLoading,
            users: store.state.absentUsers,
            project: store.state.project),
        onWillChange: (_, _ViewModel state) {},
        builder: (BuildContext context, _ViewModel state) {
          return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Add user to project',
                      style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  AppDropDownWrapperWidget(
                      child: DropdownButtonFormField<UserModel>(
                          decoration: AppDropDownStyles.decoration,
                          style: AppDropDownStyles.style,
                          icon: AppDropDownStyles.icon,
                          isExpanded: AppDropDownStyles.isExpanded,
                          hint: const Text('Select user',
                              style: AppDropDownStyles.hintStyle),
                          value: selectedUser,
                          onChanged: (UserModel value) => setState(() {
                                selectedUser = value;
                              }),
                          items: state.users.map((UserModel user) {
                            return DropdownMenuItem<UserModel>(
                                value: user,
                                child: Text('${user.name} ${user.lastName}'));
                          }).toList())),
                  const SizedBox(height: 16),
                  const Spacer(),
                  AppButtonWidget(
                      color: AppColors.green,
                      title: 'Add',
                      onClick: () {
                        Navigator.pop(context);
                        store.dispatch(AddUserToProjectPending(
                          selectedUser,
                          state.project,
                          false,
                        ));
                      })
                ],
              ),
            ),
          );
        });
  }
}
