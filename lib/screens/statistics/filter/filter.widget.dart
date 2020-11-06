import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-dropdowns.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-dropdown-wrapper/app-dropdown-wrapper.widget.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/common/helpers/enums.dart';
import 'package:company_id_new/store/models/log-filter.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/store/actions/filter.action.dart';

class _ViewModel {
  _ViewModel({this.users, this.projects, this.filter, this.isLoading});
  List<ProjectModel> projects;
  List<UserModel> users;
  bool isLoading;
  LogFilterModel filter;
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
          vacationType: VacationType.VACPAID),
      FilterType(sickness, LogType.vacation,
          vacationType: VacationType.SICKPAID)
    ];
    vacationTypes = <String>[paid, nonPaid];
    selectedVacationType = paid;
    selectedType = types.firstWhere((FilterType type) => type.title == 'All');
    if (store.state.filter?.logType?.title != null) {
      selectedType = types.firstWhere(
          (FilterType type) => type.title == store.state.filter.logType.title);
    }
    if (store.state.filter?.logType?.vacationType != null) {
      selectedVacationType =
          getSelectedVacationType(store.state.filter.logType.vacationType);
    }
    store.dispatch(GetUsersPending(usersType: UsersType.Filter));
    store.dispatch(GetProjectsPending(projectTypes: ProjectsType.Filter));
    super.initState();
  }

  @override
  void dispose() {
    store.dispatch(ClearLogFilterLogsUsersProjects());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            projects: store.state.filterLogsUsersProjects.projects,
            users: store.state.filterLogsUsersProjects.users,
            isLoading: store.state.isLoading,
            filter: store.state.filter),
        onWillChange: (_, _ViewModel state) {
          if (selectedProject != null) {
            setState(() {
              selectedProject = state.projects.firstWhere(
                  (ProjectModel project) => project.id == selectedProject.id,
                  orElse: () => null);
            });
          }
          if (selectedUser != null) {
            setState(() {
              selectedUser = state.users.firstWhere(
                  (UserModel user) => user.id == selectedUser.id,
                  orElse: () => null);
            });
          }
          if (state.projects.isNotEmpty &&
              state.filter?.project?.id != null &&
              selectedProject == null) {
            setState(() {
              selectedProject = state.projects.firstWhere(
                  (ProjectModel project) =>
                      project.id == state.filter.project.id,
                  orElse: () => null);
            });
          }
          if (state.users.isNotEmpty &&
              state.filter?.user?.id != null &&
              selectedUser == null) {
            setState(() {
              selectedUser = state.users.firstWhere(
                  (UserModel user) => user.id == state.filter.user.id,
                  orElse: () => null);
            });
          }
        },
        builder: (BuildContext context, _ViewModel state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: state.isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Column(
                      children: <Widget>[
                        const Text('Filters', style: TextStyle(fontSize: 24)),
                        const SizedBox(height: 16),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                                      // ignore: avoid_function_literals_in_foreach_calls
                                      types.forEach((FilterType type) {
                                        if (type.title == vacation) {
                                          if (value == nonPaid) {
                                            type.vacationType =
                                                VacationType.VACNONPAID;
                                          } else {
                                            type.vacationType =
                                                VacationType.VACPAID;
                                          }
                                        }
                                        if (type.title == sickness) {
                                          if (value == nonPaid) {
                                            type.vacationType =
                                                VacationType.SICKNONPAID;
                                          } else {
                                            type.vacationType =
                                                VacationType.SICKPAID;
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
                            : const SizedBox(height: 16),
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
                                      store.dispatch(
                                          GetLogsFilterProjectsPending(
                                              value.id));
                                      selectedUser = value;
                                    }),
                                items: state.users.map((UserModel user) {
                                  return DropdownMenuItem<UserModel>(
                                      value: user,
                                      child: Text(
                                          '${user.name} ${user.lastName}'));
                                }).toList())),
                        selectedType.logType != LogType.vacation
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: AppDropDownWrapperWidget(
                                    child: DropdownButtonFormField<
                                            ProjectModel>(
                                        decoration:
                                            AppDropDownStyles.decoration,
                                        style: AppDropDownStyles.style,
                                        icon: AppDropDownStyles.icon,
                                        isExpanded:
                                            AppDropDownStyles.isExpanded,
                                        hint: const Text('Select project',
                                            style: AppDropDownStyles.hintStyle),
                                        value: selectedProject,
                                        onChanged: (ProjectModel value) =>
                                            setState(() {
                                              store.dispatch(
                                                  GetLogsFilterUsersPending(
                                                      value.id));
                                              selectedProject = value;
                                            }),
                                        items: state.projects
                                            .map((ProjectModel project) {
                                          return DropdownMenuItem<ProjectModel>(
                                              value: project,
                                              child: Text(project.name));
                                        }).toList())),
                              )
                            : Container(),
                        const SizedBox(height: 16),
                        const Spacer(),
                        AppButtonWidget(
                            color: AppColors.green,
                            title: 'Apply',
                            onClick: () {
                              if (selectedType.logType == LogType.all &&
                                  selectedUser == null &&
                                  selectedProject == null) {
                                store
                                    .dispatch(PopAction(key: mainNavigatorKey));
                                return;
                              }
                              final LogFilterModel filter = LogFilterModel(
                                  logType: selectedType, user: selectedUser);
                              if (selectedType.logType != LogType.vacation) {
                                filter.project = selectedProject;
                              }
                              store.dispatch(PopAction(
                                  key: mainNavigatorKey,
                                  changeTitle: false,
                                  params: filter));
                            })
                      ],
                    ),
                  ),
          );
        });
  }

  String getSelectedVacationType(VacationType vacationType) {
    if (vacationType == VacationType.VACPAID ||
        vacationType == VacationType.SICKPAID) {
      return paid;
    } else {
      return nonPaid;
    }
  }
}
