import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-dropdowns.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-dropdown-wrapper/app-dropdown-wrapper.widget.dart';
import 'package:company_id_new/store/models/admin-filter.model.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.users, this.projects, this.adminFilter});
  List<UserModel> users;
  AdminFilterModel adminFilter;
  List<ProjectModel> projects;
}

class AdminLogFilterWidget extends StatefulWidget {
  @override
  _AdminLogFilterWidgetState createState() => _AdminLogFilterWidgetState();
}

class _AdminLogFilterWidgetState extends State<AdminLogFilterWidget> {
  final String paid = 'Paid';
  final String nonPaid = 'Non-paid';
  final String vacation = 'Vacation';
  final String sickness = 'Sickness';
  List<String> vacationTypes;
  List<FilterType> types;
  String selectedVacationType;
  FilterType selectedType;
  UserModel selectedUser;
  ProjectModel selectedProject;

  @override
  void initState() {
    types = <FilterType>[
      FilterType('All', LogType.all),
      FilterType('Log', LogType.timelog),
      FilterType(vacation, LogType.vacation,
          vacationType: VacationType.vacationPaid),
      FilterType(sickness, LogType.vacation,
          vacationType: VacationType.sickPaid)
    ];
    vacationTypes = <String>[paid, nonPaid];
    selectedVacationType = paid;
    selectedType = types.firstWhere((FilterType type) => type.title == 'All');
    selectedType = types.firstWhere((FilterType type) =>
        type.title == store.state.adminFilter.logType.title);
    selectedVacationType =
        getSelectedVacationType(store.state.adminFilter.logType.vacationType);
    super.initState();
  }

  String getSelectedVacationType(VacationType vacationType) {
    if (vacationType == VacationType.sickNonPaid ||
        vacationType == VacationType.sickPaid) {
      return paid;
    } else {
      return nonPaid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            users: store.state.users,
            projects: store.state.projects,
            adminFilter: store.state.adminFilter),
        builder: (BuildContext context, _ViewModel state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: <Widget>[
                  const Text('Filters', style: TextStyle(fontSize: 24)),
                  const SizedBox(
                    height: 16,
                  ),
                  AppDropDownWrapperWidget(
                    child: DropdownButtonFormField<FilterType>(
                      decoration: AppDropDownStyles.decoration,
                      style: AppDropDownStyles.style,
                      icon: AppDropDownStyles.icon,
                      isExpanded: AppDropDownStyles.isExpanded,
                      hint: const Text('Select type',
                          style: AppDropDownStyles.hintStyle),
                      value: selectedType,
                      onChanged: (FilterType value) => setState(() {
                        selectedType = value;
                      }),
                      items: types.map((FilterType value) {
                        return DropdownMenuItem<FilterType>(
                            value: value, child: Text(value.title));
                      }).toList(),
                    ),
                  ),
                  selectedType.logType == LogType.vacation
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: AppDropDownWrapperWidget(
                            child: DropdownButtonFormField<String>(
                              decoration: AppDropDownStyles.decoration,
                              style: AppDropDownStyles.style,
                              icon: AppDropDownStyles.icon,
                              isExpanded: AppDropDownStyles.isExpanded,
                              hint: const Text('Select vacation type',
                                  style: AppDropDownStyles.hintStyle),
                              value: selectedVacationType,
                              onChanged: (String value) => setState(() {
                                types.forEach((FilterType type) {
                                  if (type.title == vacation) {
                                    if (value == nonPaid) {
                                      type.vacationType =
                                          VacationType.vacationNonPaid;
                                    } else {
                                      type.vacationType =
                                          VacationType.vacationPaid;
                                    }
                                  }
                                  if (type.title == sickness) {
                                    if (value == nonPaid) {
                                      type.vacationType =
                                          VacationType.sickNonPaid;
                                    } else {
                                      type.vacationType = VacationType.sickPaid;
                                    }
                                  }
                                });
                                selectedVacationType = value;
                              }),
                              items: vacationTypes.map((String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 16,
                        ),
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
                      items: state.users.map((UserModel value) {
                        return DropdownMenuItem<UserModel>(
                            value: value,
                            child: Text('${value.name} ${value.lastName}'));
                      }).toList(),
                    ),
                  ),
                  selectedUser != null &&
                          selectedType.logType == LogType.timelog
                      ? Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: AppDropDownWrapperWidget(
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
                              items:
                                  state.projects.where((ProjectModel project) {
                                if (selectedUser == null ||
                                    selectedUser.projects.isEmpty ||
                                    selectedUser.projects == null) {
                                  return true;
                                }
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                return selectedUser != null
                                    ? selectedUser.projects.any(
                                        (ProjectModel projectCheck) =>
                                            projectCheck.id == project.id)
                                    : true;
                              }).map((ProjectModel project) {
                                return DropdownMenuItem<ProjectModel>(
                                    value: project, child: Text(project.name));
                              }).toList(),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 16,
                  ),
                  const Spacer(),
                  AppButtonWidget(
                      color: AppColors.green,
                      title: 'Apply',
                      onClick: () {
                        if (selectedType.logType == LogType.vacation) {
                          Navigator.pop(
                              context, AdminFilterModel(logType: selectedType));
                        } else {
                          Navigator.pop(
                              context, AdminFilterModel(logType: selectedType));
                        }
                        // FilterModel();
                      })
                ],
              ),
            ),
          );
        });
  }
}
