import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-dropdowns.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-dropdown-wrapper/app-dropdown-wrapper.widget.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.isLoading, this.projects, this.project});
  bool isLoading;
  List<ProjectModel> projects;
  ProjectModel project;
}

class AddProjectWidget extends StatefulWidget {
  @override
  _AddrojectWidgetWidgetState createState() => _AddrojectWidgetWidgetState();
}

class _AddrojectWidgetWidgetState extends State<AddProjectWidget> {
  ProjectModel selectedProject;

  @override
  void initState() {
    store.dispatch(GetProjectsPending(
        projectTypes: ProjectsType.Absent, userId: store.state.currentUser.id));
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
            projects: store.state.absentProjects,
            project: store.state.project),
        onWillChange: (_, _ViewModel state) {},
        builder: (BuildContext context, _ViewModel state) {
          return Container(
            height: 204,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Add project to user ',
                      style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  AppDropDownWrapperWidget(
                      child: DropdownButtonFormField<ProjectModel>(
                          decoration: AppDropDownStyles.decoration,
                          style: AppDropDownStyles.style,
                          icon: AppDropDownStyles.icon,
                          isExpanded: AppDropDownStyles.isExpanded,
                          hint: const Text('Select project',
                              style: AppDropDownStyles.hintStyle),
                          value: selectedProject,
                          onChanged: (ProjectModel value) => setState(() {
                                selectedProject = value;
                              }),
                          items: state.projects.map((ProjectModel project) {
                            return DropdownMenuItem<ProjectModel>(
                                value: project,
                                child: Text('${project.name} '));
                          }).toList())),
                  const SizedBox(height: 16),
                  const Spacer(),
                  AppButtonWidget(
                      color: AppColors.green,
                      title: 'Add',
                      onClick: () {
                        Navigator.pop(context);
                        store.dispatch(AddUserToProjectPending(
                            store.state.currentUser, selectedProject, false,
                            isAddedUserToProject: false));
                      })
                ],
              ),
            ),
          );
        });
  }
}
