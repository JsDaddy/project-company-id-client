import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-dropdowns.dart';
import 'package:company_id_new/common/services/validators.service.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-dropdown-wrapper/app-dropdown-wrapper.widget.dart';
import 'package:company_id_new/common/widgets/app-input/app-input.widget.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/store.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/models/log.model.dart';

class _ViewModel {
  _ViewModel({this.isLoading, this.projects, this.user, this.lastProject});
  bool isLoading;
  List<ProjectModel> projects;
  String lastProject;
  UserModel user;
}

class AddEditTimelogDialogWidget extends StatefulWidget {
  const AddEditTimelogDialogWidget({
    this.project,
    this.choosedDate,
    this.desc,
    this.hhMm,
    this.timelogId,
  });

  final DateTime choosedDate;
  final String timelogId;
  final ProjectModel project;
  final String desc;
  final String hhMm;

  @override
  _AddEditTimelogDialogWidgetState createState() =>
      _AddEditTimelogDialogWidgetState();
}

class _AddEditTimelogDialogWidgetState
    extends State<AddEditTimelogDialogWidget> {
  ProjectModel selectedProject;
  List<ProjectModel> projects = <ProjectModel>[];
  final TextEditingController _descController = TextEditingController(text: '');
  final TextEditingController _hhController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _descController.text = widget.desc;
    _hhController.text = widget.hhMm;
    store.dispatch(GetProjectsPending(
        projectTypes: ProjectsType.AddTimelog, userId: store.state.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            isLoading: store.state.isLoading,
            user: store.state.user,
            projects: store.state.timelogProjects,
            lastProject: store.state.lastProject),
        onDidChange: (_ViewModel state) {
          if (state.lastProject != null ?? selectedProject == null) {
            setState(() {
              selectedProject = state.projects.firstWhere(
                  (ProjectModel project) => project.name == state.lastProject);
            });
          }
        },
        builder: (BuildContext context, _ViewModel state) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppDropDownWrapperWidget(
                            child: DropdownButtonFormField<ProjectModel>(
                          decoration: AppDropDownStyles.decoration,
                          style: AppDropDownStyles.style,
                          icon: AppDropDownStyles.icon,
                          autovalidate: true,
                          validator: (ProjectModel value) {
                            if (value == null) {
                              return 'Please select project';
                            } else {
                              return null;
                            }
                          },
                          isExpanded: AppDropDownStyles.isExpanded,
                          hint: const Text('Select project',
                              style: AppDropDownStyles.hintStyle),
                          value: selectedProject,
                          onChanged: (ProjectModel value) {
                            setState(() {
                              selectedProject = value;
                            });
                          },
                          items: state.projects.map((ProjectModel project) {
                            return DropdownMenuItem<ProjectModel>(
                                value: project, child: Text(project.name));
                          }).toList(),
                        )),
                        const SizedBox(height: 10),
                        AppInput(
                            validator: (String value) =>
                                validators.validateIsEmpty(
                                    value, 'Please enter description'),
                            maxLines: 4,
                            myController: _descController,
                            labelText: 'Description'),
                        const SizedBox(height: 10),
                        AppInput(
                            validator: (String value) => validators
                                .validateTiming(value, 'Enter valid time'),
                            myController: _hhController,
                            labelText: 'hh mm'),
                        const SizedBox(height: 15),
                        const Align(
                            child: Text('Available format is 1h 30m',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppButtonWidget(
                          color: AppColors.green,
                          onClick: () => _addUpdateTimeLog(state.user),
                          title: 'Add'),
                      const SizedBox(width: 10),
                      AppButtonWidget(
                        title: 'Cancel',
                        onClick: () => Navigator.pop(context),
                      )
                    ])
              ]),
            ),
          );
        });
  }

  void _addUpdateTimeLog(UserModel user) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    Navigator.pop(context);
    store.dispatch(SetProjectPrefPending(selectedProject.name));

    widget.timelogId == null
        ? store.dispatch(AddLogPending(LogModel(
            project: selectedProject,
            date: widget.choosedDate,
            time: _hhController.text,
            type: LogType.Timelog,
            user: user,
            desc: _descController.text)))
        : store.dispatch(EditLogPending(LogModel(
            id: widget.timelogId,
            project: selectedProject,
            date: widget.choosedDate,
            time: _hhController.text,
            type: LogType.Timelog,
            user: user,
            desc: _descController.text)));
  }
}
